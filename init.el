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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Load cfg/*.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/cfg/")

(load "cfg-elisp.el")
(load "cfg-basics.el")
(load "cfg-ivy.el")
(load "cfg-magit.el")
(load "cfg-lispy.el")
(load "cfg-clj.el")

;; *always* byte-compile *everything* (trying this out)
;; this is a total disaster
;; lots of packages have tests, examples, bullshit in their repos that doesn't compile
;; need to back waaay up and read the docs for straight.el
;; I tried rm -rf uncompilable bullshit from my straight/repos/** but couldn't make it work and got frustrated
;; (byte-recompile-directory (expand-file-name "~/.emacs.d") 0)

(custom-set-variables
 '(inhibit-startup-screen t))
