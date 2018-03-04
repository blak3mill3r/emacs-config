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
;; ,,,s magit-stash

;; these conflict with built-in magit ones that I might like to use, skipping between chunks and sections (with shift)
;; that means choosing another binding for expand/contract
      ;; (define-key map (kbd "[") 'magit-diff-less-context)
      ;; (define-key map (kbd "]") 'magit-diff-more-context)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Git
;; lots of TODOs for me here
;; in my legacy emacs config I had butchered magit in order to have reasonable keybindings for my vim-muscle-memory
;; now the community has done that for me (see evil-magit below)
;; I still do not use ~80% of what magit provides, and I want to learn
(use-package magit :commands (magit-status))

(use-package evil-magit
  :demand t
  :general
  (:keymaps 'magit-status-mode-map
            ;; my new favorite push/pull
            "s-]"   'magit-push-current-to-upstream
            "s-["   'magit-pull-from-upstream
            ;; backwards compatible for myself if I forget, and for others who may share my old config
            ",,ps"  'magit-push-current-to-upstream
            ",,F"   'magit-pull-from-upstream
            ;; grow/shrink chunks
            "}"     'magit-diff-more-context
            "{"     'magit-diff-less-context
            ;; most common git actions are under the prefix ,,
            ",,c"   'magit-commit
            ",,ac"  'magit-commit-amend
            ",,f"   'magit-fetch-all
            ",,gc"  'magit-git-command
            ",,t"   'magit-tag
            ",,s"   'magit-stash
            :keymaps 'git-commit-mode-map
            "<C-return>"     'with-editor-finish
            "<C-backspace>"  'with-editor-cancel))
