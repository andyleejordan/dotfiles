## p: a common package manager interface
## https://github.com/andschwa/shell/blob/master/.config/shell/packages.sh

# p:	the package manager
# pag:	search packages
# par:	auto-remove unused dependencies
# pbd:	list build dependencies
# pcl:	clean caches
# pdep:	show dependencies
# pi:	install package
# pin:	show package info
# pif:	install from package file
# pr:	remove package
# pre:	reinstall package
# pup:	update repositories and show upgrades
# pug:	install upgrades
# puu:	update repositories and upgrade

# TODO: set PSUDO only if not set.
PSUDO='sudo '
if command -v aptitude >/dev/null 2>&1; then
    alias p='aptitude'
    alias pag='p search'
    alias par="$PSUDO apt-get autoremove"
    alias pbd="$PSUDO p build-dep"
    alias pcl="$PSUDO p clean"
    alias pdep='pin'
    alias pi="$PSUDO p install"
    alias pin='p show'
    alias pif="$PSUDO dpkg -i"
    alias pr="$PSUDO p purge"
    alias pre="$PSUDO p reinstall"
    alias pup="$PSUDO p update"
    alias pug="$PSUDO p upgrade"
    alias puu='pup && pug'
elif command -v apt-get >/dev/null 2>&1; then
    alias p='apt-get'
    alias pag='apt-cache search'
    alias par="$PSUDO p autoremove"
    alias pbd="$PSUDO p build-dep"
    alias pcl="$PSUDO p clean"
    alias pdep='pin'
    alias pi="$PSUDO p install"
    alias pin='apt-cache show'
    alias pif="$PSUDO dpkg -i"
    alias pr="$PSUDO p purge"
    alias pre="$PSUDO p install --reinstall"
    alias pup="$PSUDO p update"
    alias pug="$PSUDO p upgrade"
    alias puu='pup && pug'
elif command -v brew >/dev/null 2>&1; then
    alias p='brew'
    alias pag='p search'
    alias par='echo brew cannot auto-remove unused dependencies'
    alias pbd='pdep' # not exactly build dependencies
    alias pcl='p cleanup && p prune'
    alias pdep='p deps --tree'
    alias pi='p install'
    alias pin='p info'
    alias pif='p install'
    alias pr='p uninstall'
    alias pre='p reinstall'
    alias pup='p update && p outdated'
    alias pug='p upgrade'
    alias puu='p update && pug'
elif command -v pacman >/dev/null 2>&1; then
    alias p='pacman'
    alias pag='p -S --search'
    alias par="$PSUDO p -Q --deps --unrequired"
    alias pcl="$PSUDO p -S --clean"
    alias pdep="$PSUDO p -Q --deps"
    alias pi="$PSUDO p -S"
    alias pin='p -S --info'
    alias pif="$PSUDO p -U"
    alias pr="$PSUDO p -R --recursive"
    alias pre='pi'
    alias pup="$PSUDO p -S --refresh --sysupgrade"
    alias pug="$PSUDO p -S --sysupgrade"
    alias puu='pup --noconfirm'
elif command -v yum >/dev/null 2>&1; then
    alias p='yum'
    alias pag='p search'
    alias par="$PSUDO p autoremove"
    alias pbd="$PSUDO p builddep || echo Install dnf-plugins-core"
    alias pcl="$PSUDO p clean"
    alias pdep="$PSUDO p deplist"
    alias pi="$PSUDO p install"
    alias pin='p info'
    alias pif="$PSUDO rpm -i"
    alias pr="$PSUDO p remove"
    alias pre="$PSUDO p reinstall"
    alias pup="$PSUDO p update-to"
    alias pug="$PSUDO p update"
    alias puu='pug'
fi
