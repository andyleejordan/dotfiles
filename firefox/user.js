// Isolate and limit cookies
// https://feeding.cloud.geek.nz/posts/tweaking-cookies-for-privacy-in-firefox/
user_pref("privacy.firstparty.isolate", true);
user_pref("network.cookie.cookieBehavior", 0);
user_pref("network.cookie.lifetimePolicy", 3);
user_pref("network.cookie.lifetime.days", 28);
// user_pref("network.cookie.thirdparty.sessionOnly", true);

// Trim Referer Headers
// https://feeding.cloud.geek.nz/posts/tweaking-referrer-for-privacy-in-firefox/
user_pref("network.http.referer.XOriginPolicy", 1);

// Superfluous with uBlock Origin
user_pref("privacy.trackingprotection.enabled", false);

// Superfluous with password managers
user_pref("signon.rememberSignons", false);

// Disable pings
user_pref("browser.send_pings", false);

// Don't try to fix DNS issues
user_pref("browser.fixup.alternate.enabled", false);

// Disable new tab telemetry and ads
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.disableSnippets", true);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.pinned", []);

// Disable opt-out Mozilla studies
user_pref("app.normandy.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);

// Disable about:config warning
user_pref("general.warnOnAboutConfig", false);

// Just close
user_pref("browser.tabs.warnOnClose", false);
