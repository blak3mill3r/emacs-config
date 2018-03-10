

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
