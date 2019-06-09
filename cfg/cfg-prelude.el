
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard nil)

;; wtf is overflowing the c stack when I load awsome-code desktop?
;;(setq max-lisp-eval-depth 10)

(use-package general              :demand t)
(use-package hydra                :demand t)
(use-package dash                 :demand t)
(use-package smex                 :demand t)
(use-package ido-vertical-mode    :demand t)
(use-package ido-completing-read+ :demand t)
(use-package solarized-dark-theme :demand t :straight (solarized-dark-theme :host github :repo "bbatsov/solarized-emacs"))
(use-package diminish             :demand t)
