

(use-package markdown-mode
  :mode  (("\\.markdown\\'" . markdown-mode)
          ("\\.md\\'" . markdown-mode))
  :init
  (use-package vmd-mode
    :demand t
    :commands (vmd-mode))
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
  (defun my-markdown-mode-hook ()
    (add-to-list 'company-backends 'vmd-mode-company-backend)
    (company-mode))
  (add-hook 'markdown-mode-hook #'my-markdown-mode-hook))


(use-package evil-org
  :commands (evil-org-mode)
  :general
  (:keymaps 'evil-org-mode-map
   :states '(normal)
   "^" 'evil-first-non-blank-of-visual-line)
  :hook '(org-mode . evil-org-mode)
  :config
  (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading)))
