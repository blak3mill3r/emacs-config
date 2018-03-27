(use-package cquery
  :init
  (setq cquery-executable  "/home/blake/src/cquery/build/release/bin/cquery"))

(use-package yasnippet-snippets
  :init
  (yas-load-directory (concat user-emacs-directory "/straight/repos/yasnippet-snippets/snippets")))

(use-package yasnippet
  :after yasnippet-snippets)

(add-hook 'c-mode-hook #'yas-minor-mode)
(add-hook 'cc-mode-hook #'yas-minor-mode)
(add-hook 'c++-mode-hook #'yas-minor-mode)


