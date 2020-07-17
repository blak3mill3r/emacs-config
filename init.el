;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bootstrap straight.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq straight-use-package-by-default t)
(setq straight-emacsmirror-use-mirror t)
(setq debug-on-error t)
(defvar bootstrap-version)
(let ((bootstrap-file
	(expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
	"https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(setq server-socket-dir "/run/user/1000/emacs") ;; FIXME hard-coded user id

(add-to-list 'load-path "~/.emacs.d/straight/repos/use-package")
(require 'use-package)

(straight-use-package 'use-package)

;; I get desktop restore problems with this enabled, as it is by default
(setq desktop-restore-forces-onscreen nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load cfg/*.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/cfg/")
(load (concat user-emacs-directory "custom.el"))
(load (substitute-in-file-name "$ELSHOME/elisp/emacs-ludicrous-speed.el"))
(load "cfg-prelude.el")
(load "cfg-sensitive.el")
(load "cfg-read-from-pipe.el")
(load "cfg-elisp.el")
(load "cfg-basics.el")
(load "cfg-documentation.el")
(load "cfg-multiple-cursors.el")
(load "cfg-ivy.el")
(load "cfg-magit.el")
(load "cfg-lispy.el")
(load "cfg-clj.el")
(load "cfg-hy.el")
(load "cfg-cpp.el")
(load "cfg-go.el")
(load "cfg-haskell.el")
(load "cfg-rust.el")
(load "cfg-ruby.el")
(load "cfg-shells.el")
(load "cfg-bash.el")
(load "cfg-js.el")
(load "cfg-chat.el")
(load "cfg-ops.el")

;; *always* byte-compile *everything* (trying this out)
;; this is a total disaster
;; lots of packages have tests, examples, bullshit in their repos that doesn't compile
;; need to back waaay up and read the docs for straight.el
;; I tried rm -rf uncompilable bullshit from my straight/repos/** but couldn't make it work and got frustrated
;; (byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; this is poorly named
;; it really means hitting A in dired will replace the dired buffer with the file rather than opening a new one
(put 'dired-find-alternate-file 'disabled nil)
