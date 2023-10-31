(setq comp-deferred-compilation t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bootstrap straight.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq straight-use-package-by-default t)
(setq straight-emacsmirror-use-mirror t)
(setq debug-on-error t
      )



(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))






(setq server-socket-dir "/run/user/1000/emacs") ;; FIXME hard-coded user id

;(add-to-list 'load-path "~/.emacs.d/straight/repos/use-package")
;(require 'use-package)

(straight-use-package 'use-package)

(setq straight--wait-for-async-jobs t)

;; I need to fool around with these more
;; consider multiple frames on different subspaces from the same instance of emacs
;; this is also useful even though my default is to have a single frame, single instance
;; sometimes I make a new frame and move it to nextdoor subspace
;; if I save desktop like that, it isn't going to restore there (what will it do?)
(setq desktop-restore-forces-onscreen nil)
(setq desktop-restore-reuses-frames nil)
(setq desktop-restore-frames nil)
(setq desktop-save nil) ;; I prefer manually saving the desktops in some nice state

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load cfg/*.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/cfg/")
(load (concat user-emacs-directory "custom.el"))
(load (substitute-in-file-name "$ELSHOME/elisp/emacs-ludicrous-speed.el"))
(load "cfg-prelude.el")
(load "cfg-sensitive.el")
(load "cfg-read-from-pipe.el")
(load "cfg-basics.el")
(load "cfg-documentation.el")
(load "cfg-multiple-cursors.el")
(load "cfg-ivy.el")
(load "cfg-magit.el")
(load "cfg-lispy.el")
(load "cfg-elisp.el")
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

(message "Waiting for async comp")
(block-on-native-comp)
(message "(block-on-native-comp) has returned")
