#!/usr/bin/env bash

# <xbar.title>Fuzzy Clock</xbar.title>
# <xbar.version>v1.0</xbar.version>
# <xbar.author>Dana Merrick</xbar.author>
# <xbar.author.github>dmerrick</xbar.author.github>
# <xbar.desc>Menu-bar clock that tells the time in words, à la FuzzyClock — "quarter past ten", "twenty to five". Rounds to the nearest five minutes.</xbar.desc>
# <xbar.dependencies>bash</xbar.dependencies>

# 10# forces base-10 so leading zeros (08, 09) don't parse as octal; BSD date
# has no GNU %-I/%-M, so strip the pad ourselves.
h=$((10#$(date +%I)))   # 1-12
m=$((10#$(date +%M)))   # 0-59

# nearest 5 minutes
r=$(( (m + 2) / 5 * 5 ))
nh=$(( h % 12 + 1 ))
if (( r >= 60 )); then r=0; h=$nh; nh=$(( h % 12 + 1 )); fi

# index 1..12 → word; [0] duplicates twelve so hour 12 reads naturally
w=(twelve one two three four five six seven eight nine ten eleven twelve)

case $r in
  0)  phrase="${w[h]} o'clock" ;;
  5)  phrase="five past ${w[h]}" ;;
  10) phrase="ten past ${w[h]}" ;;
  15) phrase="quarter past ${w[h]}" ;;
  20) phrase="twenty past ${w[h]}" ;;
  25) phrase="twenty-five past ${w[h]}" ;;
  30) phrase="half past ${w[h]}" ;;
  35) phrase="twenty-five to ${w[nh]}" ;;
  40) phrase="twenty to ${w[nh]}" ;;
  45) phrase="quarter to ${w[nh]}" ;;
  50) phrase="ten to ${w[nh]}" ;;
  55) phrase="five to ${w[nh]}" ;;
esac

echo "$phrase"
echo "---"
echo "$(date '+%A, %B %-d') | size=12 color=gray"
echo "$(date '+%-l:%M %p')" 2>/dev/null || echo "$(date '+%I:%M %p')"
