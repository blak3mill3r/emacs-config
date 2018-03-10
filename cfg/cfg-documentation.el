(use-package vmd-mode
  :commands (vmd-mode))

(use-package markdown-mode
  :mode  (("\\.markdown\\'" . gfm-mode)
          ("\\.md\\'" . gfm-mode))
  :init
  (defun md-insert-clojure ()
    (interactive)
    (insert "```clojure\n\n```")
    (evil-beginning-of-line)
    (evil-previous-line)
    (evil-insert-line))
  :general
  (:states '(normal)
   :prefix ","
   "vmd" 'vmd-mode)
  (:states '(insert)
   :prefix "s-\\"
   "clj" 'md-insert-clojure)
  :init
  (add-hook 'markdown-mode-hook #'visual-line-mode))

(setq show-trailing-whitespace t)

;; ws-butler (unobtrusive whitespace remover)
(use-package ws-butler
  :diminish ws-butler-mode
  :commands (ws-butler-mode)
  :init
  (add-hook 'prog-mode-hook #'ws-butler-mode)
  (add-hook 'org-mode-hook #'ws-butler-mode)
  (add-hook 'text-mode-hook #'ws-butler-mode)
  (add-hook 'proof-mode-hook #'ws-butler-mode)
  (add-hook 'bibtex-mode-hook #'ws-butler-mode)
  :config
  (setq ws-butler-convert-leading-tabs-or-spaces t))
