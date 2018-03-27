(use-package hy-mode
  :demand t
  :mode "\\.hy$"
  :init
  (defun my-hy-mode-hook ()
    (message "my HY MODE hook")
    (lispy-mode 1)
    (modify-syntax-entry ?_ "w")
    (modify-syntax-entry ?- "w")
    (modify-syntax-entry ?> "w"))
  (add-hook 'hy-mode-hook #'my-hy-mode-hook))
