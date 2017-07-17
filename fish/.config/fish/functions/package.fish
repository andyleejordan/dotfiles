function package -d "Manages packages agnostically"
  # ag:	search packages
  # ar:	auto-remove unused dependencies
  # bd:	list build dependencies
  # cl:	clean caches
  # dp:	show dependencies
  # i:	install package
  # in:	show package info
  # f:	install from package file
  # p:  purge package
  # r:	remove package
  # re:	reinstall package
  # up:	update repositories and show upgrades
  # ug:	install upgrades
  # uu:	update repositories and install upgrades

  if command -sq apt-get
    package_apt $argv
  else if command -sq yum
    package_yum $argv
  else if command -sq brew
    package_brew $argv
  else if command -sq pacman
    package_pacman $argv
  else
    echo "package manager unknown" 1>&2
  end
end

function package_apt -w apt-get -a cmd
  set --erase argv[1]
  switch $cmd
    case ag
      apt-cache search $argv
    case ar
      sudo apt-get autoremove $argv
    case bd
      sudo apt-get build-dep $argv
    case cl
      sudo apt-get autoclean
    case i
      sudo apt-get install $argv
    case in dp
      apt-cache show $argv
    case f
      sudo dpkg -i $argv
    case p
      sudo apt-get purge $argv
    case r
      sudo apt-get remove $argv
    case re
      sudo apt-get install --reinstall $argv
    case up
      sudo apt-get update $argv
    case ug
      sudo apt-get upgrade $argv
    case uu
      package_apt up $argv
      and package_apt ug $argv
  end
end

function package_yum -w yum -a cmd
  set --erase argv[1]
  switch $cmd
    case ag
      yum search $argv
    case ar p
      sudo yum autoremove $argv
    case bd
      sudo yum build-dep $argv
      or echo "need dnf-plugins-core" 1>&2
    case cl
      sudo yum clean $argv
    case dp
      sudo yum deplist $argv
    case i
      sudo yum install $argv
    case in
      sudo yum info $argv
    case f
      sudo rpm -i $argv
    case r
      sudo yum remove $argv
    case re
      sudo yum reinstall $argv
    case up
      sudo yum update-to $argv
    case ug uu
      sudo yum update $argv
  end
end

function package_brew -w brew -a cmd
  set --erase argv[1]
  switch $cmd
    case ag
      brew search $argv
    case ar
      echo "brew cannot auto-remove unused dependencies" 1>&2
    case cl
      brew cleanup
      and brew prune
    case dp bd
      brew deps --tree $argv
    case i
      brew install $argv
    case in
      brew info $argv
    case f
      sudo installer -pkg $argv -target /
    case r
      brew uninstall $argv
    case re
      brew reinstall $argv
    case up
      brew update
      and brew outdated
    case ug
      brew upgrade $argv
    case uu
      brew update
      and brew upgrade $argv
  end
end

function package_pacman -w pacman -a cmd
  set --erase argv[1]
  switch $cmd
    case ag
      pacman --sync --search $argv
    case ar
      sudo pacman --remove --unneeded $argv
    case cl
      sudo pacman --sync --clean $argv
    case dp
      sudo pacman --query --deps $argv
    case i re
      sudo pacman --sync $argv
    case in
      pacman --query --info $argv
    case f
      sudo pacman --upgrade $argv
    case p
      package_pacman r --recursive $argv
    case r
      sudo pacman --remove $argv
    case up
      sudo pacman --sync --refresh
      and pacman --query --upgrades $argv
    case ug uu
      sudo pacman --sync --refresh --sysupgrade $argv
  end
end

