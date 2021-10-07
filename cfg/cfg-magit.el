;; TODO, replicate from my old setup

;; these were in evil-magit.el, for magit-mode-map
;; a lot of them I don't have in muscle-memory
;;   so I guess I never put them into practice, and might as well start over and reconsider it all

;; ,,gc magit-git-command
;; ,,c magit-commit
;; ,,ac magit-commit-amend
;; ,,f magit-fetch-all
;; ,,F magit-pull
;; ,,ps magit-push-current-to-upstream
;; ,,t magit-tag
;; ,,l magit-log

;(use-package magit-todos
;  :demand t
;  :hook (magit-mode . magit-todos-mode)
;  :config
;  (setq magit-todos-recursive t
;        magit-todos-depth 100)
;  (setq magit-todos-keywords (list "TODO" "FIXME"))
;  )

(use-package browse-at-remote
  :demand t
  :commands (browse-at-remote)
  :general
  (:prefix ","
   :states '(normal visual)
   "ghl" 'browse-at-remote-kill
   "gho" 'browse-at-remote))

;; I think I prefer diff-hl and global-diff-hl-mode (maybe, trying it out)
;; (use-package git-gutter
;;   :hook '((prog-mode markdown-mode) . git-gutter-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Git
;; lots of TODOs for me here
;; in my legacy emacs config I had butchered magit in order to have reasonable keybindings for my vim-muscle-memory
;; now the community has done that for me (see evil-magit below)
;; I still do not use ~80% of what magit provides, and I want to learn
(use-package magit
  :demand t
  :config
  (setq
   magit-diff-refine-hunk 'all
   magit-log-margin '(t "%Y-%m-%d %H:%M" magit-log-margin-width t 18)
   magit-diff-highlight-indentation '((".*" . tabs))
   magit-branch-rename-push-target 'local-only)
  ;; this var disappeared:
  ;; (add-to-list 'magit-log-arguments "--follow")
  )


;; https://magit.vc/manual/ghub/Setting-the-Username.html#Setting-the-Username
;; (use-package ghub
;;   )

;; (use-package auth-source-pass
;;   :defer t
;;   :config
;;   (auth-source-pass-enable)

;;   (defvar auth-source-pass--cache (make-hash-table :test #'equal))

;;   (defun auth-source-pass--reset-cache ()
;;     (setq auth-source-pass--cache (make-hash-table :test #'equal)))

;;   (defun auth-source-pass--read-entry (entry)
;;     "Return a string with the file content of ENTRY."
;;     (run-at-time 45 nil #'auth-source-pass--reset-cache)
;;     (let ((cached (gethash entry auth-source-pass--cache)))
;;       (or cached
;;           (puthash
;;            entry
;;            (with-temp-buffer
;;              (insert-file-contents (expand-file-name
;;                                     (format "%s.gpg" entry)
;;                                     (getenv "PASSWORD_STORE_DIR")))
;;              (buffer-substring-no-properties (point-min) (point-max)))
;;            auth-source-pass--cache))))

;;   (defun auth-source-pass-entries ()
;;     "Return a list of all password store entries."
;;     (let ((store-dir "/home/blake/.password-store"))
;;       (mapcar
;;        (lambda (file) (file-name-sans-extension (file-relative-name file store-dir)))
;;        (directory-files-recursively store-dir "\.gpg$")))))

;; (use-package magithub
;;   :after magit
;;   :config
;;   (magithub-feature-autoinject t)

;;   (require 'auth-source-pass)
;;   (defvar my-ghub-token-cache nil)

;;   (advice-add
;;    'ghub--token :around
;;    #'(lambda (orig-func host username package &optional nocreate forge)
;;        (or my-ghub-token-cache
;;            (setq my-ghub-token-cache
;;                  (funcall orig-func host username package nocreate forge)))))

;;   ;; what it do? https://github.com/jwiegley/dot-emacs/blob/master/init.el#L2620

;;   ;; (require 'auth-source-pass)
;;   ;; (defvar my-ghub-token-cache nil)

;;   ;; (advice-add
;;   ;;  'ghub--token :around
;;   ;;  #'(lambda (orig-func host username package &optional nocreate forge)
;;   ;;      (or my-ghub-token-cache
;;   ;;          (setq my-ghub-token-cache
;;   ;;                (funcall orig-func host username package nocreate forge)))))
;;   )
