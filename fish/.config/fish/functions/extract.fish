function extract
  switch (uname)
    # use gtar on Darwin
    case Darwin
      if command -sq gtar
        alias tar gtar
      else
        echo "gtar was not found!" 1>&2
        return 1
      end
    case '*'
      if not command -sq tar
        echo "tar was not found!" 1>&2
        return 1
      end
  end

  for file in $argv
    set name (set_color blue)$file(set_color normal)

    if not test -r $file
      echo "Cannot read:" $name 1>&2
      return 1
    end

    for ext in sig asc
      if test -r "$file.$ext"
        if not command -sq gpg
          echo "$name was signed but gpg was not found" 1>&2
          return 1
        end
        echo "Verifying signature for:" $name 1>&2
        if not gpg --verify "$file.$ext"
          return $status
        end
      end
    end

    echo "Extracting:" $name 1>&2

    switch $file
      case '*.tar*' '*.t*'
        tar -xf $file
      case '*.xz'
        unxz $file
      case '*.bz2'
        bunzip2 $file
      case '*.gz'
        gunzip $file
      case '*.rar'
        unrar x $file
      case '*.zip' '*.war' '*.jar'
        unzip $file
      case '*.7z'
        7z x $file
      case '*.pax'
        pax -r < $file
      case '*.deb'
        dpkg-deb -x $file (basename $file .deb)
      case '*.rpm'
        rpm2cpio $file | cpio -idmv
      case '*.pkg'
        pkgutil --expand $file (basename $file *.pkg)
      case '*'
        echo "Cannot extract:" $name 1>&2
        return 1
    end
  end
end
