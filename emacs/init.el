(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
	     '("marmalade" .  "http://marmalade-repo.org/packages/"))
(package-initialize)

(load-theme 'solarized-dark t)


