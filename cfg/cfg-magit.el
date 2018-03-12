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

(use-package git-gutter
  :hook '((prog-mode markdown-mode) . git-gutter-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Git
;; lots of TODOs for me here
;; in my legacy emacs config I had butchered magit in order to have reasonable keybindings for my vim-muscle-memory
;; now the community has done that for me (see evil-magit below)
;; I still do not use ~80% of what magit provides, and I want to learn
(use-package magit
  :config
  (setq
   magit-diff-refine-hunk 'all
   magit-log-margin '(t "%Y-%m-%d %H:%M" magit-log-margin-width t 18)
   magit-diff-highlight-indentation '((".*" . tabs))
   magit-branch-rename-push-target 'local-only)
  (add-to-list 'magit-log-arguments "--follow"))

(use-package evil-magit
  :demand t                             ;; without this I don't get evil-magit bindings in git-status buffer
  :commands (magit-status magit-log)
  :general
  (:keymaps 'magit-status-mode-map
   ;; my new favorite push/pull
   "s-]"   'magit-push-current-to-upstream
   "s-["   'magit-pull-from-upstream
   ;; backwards compatible for myself if I forget, and for others who may share my old config
   ",ps"  'magit-push-current-to-upstream
   ",F"   'magit-pull-from-upstream
   ;; grow/shrink chunks
   "}"     'magit-diff-more-context
   "{"     'magit-diff-less-context
   ;; most common git actions are under the prefix ,,
   ",c"   'magit-commit
   ",ac"  'magit-commit-amend
   ",f"   'magit-fetch-all
   ",gc"  'magit-git-command
   ",t"   'magit-tag
   ",s"   'magit-stash)
  (:keymaps 'git-commit-mode-map
   "<C-return>"     'with-editor-finish
   "<C-backspace>"  'with-editor-cancel))
