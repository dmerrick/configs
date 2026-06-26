#!/usr/bin/env bash

# <xbar.title>Caravel Bio Build Status</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Dana Merrick</xbar.author>
# <xbar.author.github>dmerrick</xbar.author.github>
# <xbar.desc>Menu-bar indicator for the state of the image/artifact builds across the Caravel Bio repos. Green when idle, building when a publish build is in flight (wait before grabbing a new image), red when the latest publish run failed. Caravel has no deploy branch: builds publish on a push to main (:latest + :sha) and on a vX.Y.Z tag cut by release-please (the versioned image). This watches push-event runs only, so PR smoke tests and release-please PR-branch builds are ignored.</xbar.desc>
# <xbar.dependencies>bash,gh,jq</xbar.dependencies>

# SwiftBar runs plugins with a minimal PATH, so add the homebrew bin where gh/jq live.
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

# Builds to watch, as "repo|workflow-file|label". These are the workflows that
# actually publish an image/artifact. App images (build-image.yml) and the shared
# CI ansible-runner image (build-ansible-runner.yml) all fire on a push to main and
# on vX.Y.Z tags. The Python libraries (mimir, munin) have no image build —
# release-please tags them and they're consumed by tag-fetch — so there's nothing
# to wait on; phoebe has no release yet. Both are intentionally omitted.
TARGETS=(
  "caravelbio/emoji-picker|build-image.yml|emoji-picker"
  "caravelbio/hugin|build-image.yml|hugin"
  "caravelbio/infra|build-ansible-runner.yml|infra · ansible-runner"
)

# --- gather, in parallel -----------------------------------------------------
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

i=0
for target in "${TARGETS[@]}"; do
  i=$((i+1))
  (
    IFS='|' read -r repo workflow label <<<"$target"
    # --event push: only the runs that actually publish (main + vX.Y.Z tags),
    # never PR smoke tests or the release-please PR-branch build.
    json="$(gh run list --repo "$repo" --workflow "$workflow" --event push --limit 1 \
      --json status,conclusion,displayTitle,createdAt,url,headBranch 2>/dev/null)"
    if [[ -z "$json" ]]; then
      printf '%s\037unknown\037\037\037%s\n' "$label" "https://github.com/$repo/actions" > "$tmp/$i"   # gh call failed
      exit 0
    fi
    if [[ "$json" == "[]" ]]; then
      printf '%s\037none\037\037\037%s\n' "$label" "https://github.com/$repo/actions" > "$tmp/$i"       # no runs yet
      exit 0
    fi
    status=$(jq -r '.[0].status'          <<<"$json")
    concl=$(jq -r '.[0].conclusion // ""' <<<"$json")
    branch=$(jq -r '.[0].headBranch // ""' <<<"$json")
    created=$(jq -r '.[0].createdAt'      <<<"$json")
    url=$(jq -r '.[0].url'                <<<"$json")

    # classify into one of: building | failed | ok
    case "$status" in
      in_progress|queued|waiting|requested|pending)
        state="building" ;;
      completed)
        case "$concl" in
          success)            state="ok" ;;
          failure|timed_out|startup_failure) state="failed" ;;
          *)                  state="ok" ;;   # cancelled/skipped/neutral -> not "wrong"
        esac ;;
      *) state="unknown" ;;
    esac
    printf '%s\037%s\037%s\037%s\037%s\n' "$label" "$state" "$branch" "$created" "$url" > "$tmp/$i"
  ) &
done
wait

# friendly relative age, e.g. "3h ago"
ago() {
  local ts="$1" secs now
  [[ -z "$ts" ]] && { echo ""; return; }
  now=$(date -u +%s)
  secs=$(date -u -j -f "%Y-%m-%dT%H:%M:%SZ" "$ts" +%s 2>/dev/null) || { echo ""; return; }
  local d=$(( now - secs ))
  if   (( d < 60 ));    then echo "just now"
  elif (( d < 3600 ));  then echo "$(( d / 60 ))m ago"
  elif (( d < 86400 )); then echo "$(( d / 3600 ))h ago"
  else                       echo "$(( d / 86400 ))d ago"; fi
}

# Caravel has no deploy branch, so the headBranch tells the release story directly:
# a vX.Y.Z branch is the versioned release image, "main" is the continuous build.
# A stray release-please PR branch (shouldn't appear under --event push) is folded
# to "release-pr" just in case.
pretty_branch() {
  local b="$1"
  case "$b" in
    release-please--*) echo "release-pr" ;;
    *)                 echo "$b" ;;
  esac
}

# --- aggregate ---------------------------------------------------------------
building=0; failed=0; unknown=0
rows=""
i=0
for target in "${TARGETS[@]}"; do
  i=$((i+1))
  IFS=$'\037' read -r label state branch created url < "$tmp/$i"
  case "$state" in
    building) building=$((building+1)) ;;
    failed)   failed=$((failed+1)) ;;
    unknown)  unknown=$((unknown+1)) ;;
  esac
  case "$state" in
    building) icon="⚙️"; word="building" ;;
    failed)   icon="🚨"; word="failed" ;;
    ok)       icon="✅"; word="idle" ;;
    none)     icon="⚪️"; word="no builds yet" ;;
    *)        icon="❓"; word="unreachable" ;;
  esac
  age="$(ago "$created")"
  detail="$label — $word"
  [[ -n "$branch" ]] && detail="$detail ($(pretty_branch "$branch"))"
  [[ -n "$age" ]]    && detail="$detail · $age"
  rows+="$icon $detail | href=$url"$'\n'
done

# --- menu bar line -----------------------------------------------------------
if   (( building > 0 )); then
  bar="⚙️"; (( building > 1 )) && bar="⚙️ $building"
  summary="$building publish build(s) in flight"
elif (( failed > 0 )); then
  bar="🚨"; (( failed > 1 )) && bar="🚨 $failed"
  summary="$failed publish build(s) failed"
elif (( unknown > 0 && unknown == ${#TARGETS[@]} )); then
  bar="⚪️"
  summary="couldn't reach GitHub"
else
  bar="✅"
  summary="all publish builds idle"
fi

echo "$bar"
echo "---"
echo "Caravel Bio builds | size=12 color=gray"
echo "$summary | size=12 color=gray"
echo "---"
printf '%s' "$rows"
echo "---"
echo "Refresh now | refresh=true"
