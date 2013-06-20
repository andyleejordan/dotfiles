(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
	     '("marmalade" .  "http://marmalade-repo.org/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar default-packages '(
			   color-theme-solarized
			   magit
			   ))

(dolist (p default-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(load-theme 'solarized-dark t)


