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

(use-package forge
  :demand t
  :after magit)

(setq auth-sources '("~/.authinfo.gpg"))
(setq github.user "blak3mill3r")
