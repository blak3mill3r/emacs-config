(use-package hydra)
(use-package dash)
(use-package smex                 :demand t)
(use-package ido-vertical-mode    :demand t)
(use-package ido-completing-read+ :demand t)
(use-package solarized-dark-theme :straight (el-patch :host github :repo "bbatsov/solarized-emacs"))
(load-theme 'solarized-dark t)
(menu-bar-mode -1)
(tooltip-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; check out help+ mode and the other + modes for builtins

(bind-keys :map help-mode-map
           ("s-]" . help-go-forward)
           ("s-[" . help-go-back))
(bind-keys :map emacs-lisp-mode-map
               ("s-]" . find-function-at-point)
               ("s-[" . help-go-back))

(setq evil-want-integration nil)

(use-package evil
  :demand t
  :config
  (progn
    (evil-mode 1)
    (ido-mode)
    (ido-everywhere 1)
    (ido-ubiquitous-mode 1)
    (ido-vertical-mode)


    (unbind-key "," evil-motion-state-map)
    (bind-keys* :map evil-normal-state-map
                ("SPC" . avy-goto-char-timer)
                :prefix-map evil-leader-prefix-map
                :prefix ","
                ("b."     . next-buffer)
                ("b,"     . previous-buffer)
                ("bd"     . kill-buffer)
                ("bl"     . buffer-menu)
                ("b SPC"  . ido-switch-buffer)

                ("wd"     . delete-window)
                ("wb"     . delete-other-windows)
                ("bk"     . kill-buffer-and-window)
                ("bd"     . kill-buffer)
                ("br"     . revert-buffer)
                (",s"     . shell)
                (",/"     . ido-find-file)
                (",x"     . smex)
                (",b"     . ivy-switch-buffer)
                (",,x"    . smex-major-mode-commands)
                (",w"     . make-frame)
                ("gs"     . magit-status))))

(use-package evil-collection
  :after evil
  :custom (evil-collection-setup-minibuffer t)
  :config (evil-collection-init))

(use-package magit)
(use-package evil-magit)

