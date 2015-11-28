## p: a common package manager interface

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

if command -v aptitude >/dev/null 2>&1; then
    alias p='aptitude'
    alias pag='p search'
    alias par='apt-get autoremove'
    alias pbd='p build-dep'
    alias pcl='p clean'
    alias pdep='pin'
    alias pi='p install'
    alias pin='p show'
    alias pif='dpkg -i'
    alias pr='p purge'
    alias pre='p reinstall'
    alias pup='p update'
    alias pug='p upgrade'
    alias puu='pup && pug'
elif command -v apt-get >/dev/null 2>&1; then
    alias p='apt-get'
    alias pag='apt-cache search'
    alias par='p autoremove'
    alias pbd='p build-dep'
    alias pcl='p clean'
    alias pdep='pin'
    alias pi='p install'
    alias pin='apt-cache show'
    alias pif='dpkg -i'
    alias pr='p purge'
    alias pre='p install --reinstall'
    alias pup='p update'
    alias pug='p upgrade'
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
    alias par='p -Q --deps --unrequired'
    alias pcl='p -S --clean'
    alias pdep='p -Q --deps'
    alias pi='p -S'
    alias pin='p -S --info'
    alias pif='p -U'
    alias pr='p -R --recursive'
    alias pre='pi'
    alias pup='p -S --refresh --sysupgrade'
    alias pug='p -S --sysupgrade'
    alias puu='pup --noconfirm'
elif command -v yum >/dev/null 2>&1; then
    alias p='yum'
    alias pag='p search'
    alias par='p autoremove'
    alias pbd='p-builddep'
    alias pcl='p clean'
    alias pdep='p deplist'
    alias pi='p install'
    alias pin='p info'
    alias pif='rpm -i'
    alias pr='p remove'
    alias pre='p reinstall'
    alias pup='p update-to'
    alias pug='p update'
    alias puu='pug'
fi
