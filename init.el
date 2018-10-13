;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Bootstrap straight.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(let ((bootstrap-file (concat user-emacs-directory "straight/repos/straight.el/bootstrap.el"))
      (bootstrap-version 3))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq debug-on-error nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load cfg/*.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/cfg/")

(load "cfg-sensitive.el")
(load "cfg-read-from-pipe.el")
(load "cfg-prelude.el")
(load "cfg-documentation.el")
(load "cfg-multiple-cursors.el")
(load "cfg-elisp.el")
(load "cfg-basics.el")
(load "cfg-ivy.el")
(load "cfg-magit.el")
(load "cfg-lispy.el")
(load "cfg-clj.el")
(load "cfg-hy.el")
(load "cfg-cpp.el")
(load "cfg-go.el")
(load "cfg-haskell.el")
(load "cfg-shells.el")
(load "cfg-bash.el")
(load "cfg-js.el")

;; *always* byte-compile *everything* (trying this out)
;; this is a total disaster
;; lots of packages have tests, examples, bullshit in their repos that doesn't compile
;; need to back waaay up and read the docs for straight.el
;; I tried rm -rf uncompilable bullshit from my straight/repos/** but couldn't make it work and got frustrated
;; (byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
