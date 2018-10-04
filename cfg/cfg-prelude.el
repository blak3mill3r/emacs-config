
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard nil)

;; wtf is overflowing the c stack when I load awsome-code desktop?
;;(setq max-lisp-eval-depth 10)

(use-package hydra)
(use-package dash)
(use-package smex                 :demand t)
(use-package ido-vertical-mode    :demand t)
(use-package ido-completing-read+ :demand t)
(use-package solarized-dark-theme :straight (solarized-dark-theme :host github :repo "bbatsov/solarized-emacs"))
(use-package diminish)
(use-package general)
(require 'general)
