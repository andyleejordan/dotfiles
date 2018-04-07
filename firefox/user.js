// Prefetching
user_pref("browser.urlbar.speculativeConnect.enabled", true);
user_pref("network.dns.disablePrefetch", false);
user_pref("network.predictor.enabled", true);
user_pref("network.http.speculative-parallel-limit", 4);

// Tracking
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("beacon.enabled", false);
user_pref("browser.safebrowsing.appRepURL", "");
user_pref("browser.safebrowsing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.selfsupport.url", "");
user_pref("browser.send_pings", false);
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("dom.battery.enabled", false);
user_pref("extensions.getAddons.cache.enabled", false);
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.webservice.discoverURL", "");
user_pref("geo.enabled", false);
user_pref("media.navigator.enabled", false);
user_pref("media.peerconnection.enabled", false);
user_pref("media.video_stats.enabled", false);
user_pref("toolkit.telemetry.enabled", false);

// Breaks too many things
user_pref("privacy.resistFingerprinting", false);

// Cookies
// https://feeding.cloud.geek.nz/posts/tweaking-cookies-for-privacy-in-firefox/
user_pref("privacy.firstparty.isolate", true);
user_pref("network.cookie.cookieBehavior", 3);
user_pref("network.cookie.lifetimePolicy", 3);
user_pref("network.cookie.lifetime.days", 21);
user_pref("network.cookie.thirdparty.sessionOnly", true);

// Referer Headers
// https://feeding.cloud.geek.nz/posts/tweaking-referrer-for-privacy-in-firefox/
user_pref("network.http.referer.XOriginPolicy", 1);

// Behavior
// https://www.reddit.com/r/firefox/wiki/aboutconfig
user_pref("browser.fixup.alternate.enabled", false);
user_pref("browser.newtabpage.introShown", true);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.default.sites", "https://www.wikipedia.org/,https://duckduckgo.com/")
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.onboarding.notification.finished", true);
user_pref("browser.tabs.closeWindowWithLastTab", false);
user_pref("browser.urlbar.trimURLs", false);
user_pref("general.warnOnAboutConfig", false);
user_pref("signon.rememberSignons", false);
user_pref("security.webauth.u2f", true);

// Superfluous with uBlock Origin
user_pref("privacy.trackingprotection.enabled", false);

// uBlock Origin fixes the leaks
user_pref("webgl.disabled", false);

// Breaks GitHub Gist
user_pref("dom.event.clipboardevents.enabled", true);

// Breaks AMO
user_pref("dom.storage.enabled", true);

// Breaks Twitter
user_pref("dom.indexedDB.enabled", true);
