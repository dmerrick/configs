const TRACKING_PARAMS = [
  "utm_source", "utm_medium", "utm_campaign", "utm_term", "utm_content",
  "fbclid", "gclid", "msclkid", "dclid", "yclid", "twclid",
  "mc_cid", "mc_eid",
  "_hsenc", "_hsmi",
  "igshid", "ref_src", "ref_url",
  "vero_conv", "vero_id",
  "wickedid", "wt_mc", "wt_zmc",
  "_ga", "_gl",
  "trk", "trkCampaign", "spm"
];

// Firefox 137+ profile-group profiles. Map display name → on-disk dir.
// (profiles.ini's Name= entries are legacy/stale; the real names live in
// ~/Library/Application Support/Firefox/Profile Groups/<id>.sqlite.)
const FF_PROFILE_ROOT = "/Users/dmerrick/Library/Application Support/Firefox/Profiles";
const FF_PROFILES = {
  Personal: "chf1zbku.default-release",
  Math: "FGej1baA.Profile 1",
  ADanaLife: "ExPB1DT0.Profile 2",
  Caravel: "L93lhfL9.Profile 4"
};

const firefoxProfile = (name) => (url) => ({
  name: "Firefox",
  args: [
    "--new", "--args",
    "--profile", `${FF_PROFILE_ROOT}/${FF_PROFILES[name]}`,
    "--profiles-activate",
    url.toString()
  ]
});

// Match a URL's hostname against a domain exactly or as a subdomain.
const hostIn = (...domains) => (url) =>
  domains.some((d) => url.hostname === d || url.hostname.endsWith(`.${d}`));

// Hosts that belong to the Caravel (company) profile. raw.githubusercontent.com
// isn't a *.github.com host, so it's listed explicitly.
const CARAVEL_HOSTS = [
  "meet.google.com",
  "caravel.bio",
  "notion.so",
  "notion.site",
  "slack.com",
  "zoom.us",
  "github.com",
  "raw.githubusercontent.com"
];

export default {
  defaultBrowser: firefoxProfile("Personal"),
  options: {
    checkForUpdates: true,
    logRequests: true
  },
  rewrite: [
    {
      match: (url) => TRACKING_PARAMS.some((p) => url.searchParams.has(p)),
      url: (url) => {
        const u = new URL(url.toString());
        TRACKING_PARAMS.forEach((p) => u.searchParams.delete(p));
        return u;
      }
    }
  ],
  handlers: [
    {
      // Hold ⌘+⌥ to force the Personal profile regardless of URL
      match: () => {
        const k = finicky.getModifierKeys();
        return k.command && k.option;
      },
      browser: firefoxProfile("Personal")
    },
    {
      // adanalife's own GitHub stays on the ADanaLife profile.
      // Must precede the Caravel catch-all below.
      match: (url) =>
        hostIn("github.com", "raw.githubusercontent.com")(url) &&
        url.pathname.toLowerCase().startsWith("/adanalife"),
      browser: firefoxProfile("ADanaLife")
    },
    {
      // Company hosts → Caravel
      match: hostIn(...CARAVEL_HOSTS),
      browser: firefoxProfile("Caravel")
    }
  ]
};
