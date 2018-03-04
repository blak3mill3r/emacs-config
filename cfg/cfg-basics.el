(use-package hydra)
(use-package dash)
(use-package smex                 :demand t)
(use-package ido-vertical-mode    :demand t)
(use-package ido-completing-read+ :demand t)
(use-package solarized-dark-theme :straight (solarized-dark-theme :host github :repo "bbatsov/solarized-emacs"))

;; make it more pretty, and remove all the fluff
(load-theme 'solarized-dark t)
(menu-bar-mode -1)
(tooltip-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; I use compton for x compositing and without this incantation emacs doesn't cooperate (it's on top of my xmonad-electric overlay)
(set-frame-parameter (selected-frame) 'alpha '(100 . 85))
(add-to-list 'default-frame-alist '(alpha . (100 . 85)))

;; this is the analogue of
;; :set nowrap
(setq-default truncate-lines t)

;; use UTF-8 for new buffers by default (subtle, I don't really understand fully, what is the default behavior?)
(prefer-coding-system 'utf-8)

;; open symlinks in emacs => follow them to the real file
(setq vc-follow-symlinks 1)

;; I'm pretty careful; I do not want emacs to protect me *too* much from accidental action
(fset 'yes-or-no-p 'y-or-n-p)

;; actual Tab characters are *far* more trouble than they are worth
(setq-default indent-tabs-mode nil)

;; Emacs backups and auto-save files
;; keep backup files forever, in a separate directory, and version them
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq version-control t)
(setq delete-old-versions -1)
(setq vc-make-backup-files t)
;; keep auto-save files somewhere sensible
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; emacs history customization: put it somewhere sensible, never truncate, don't store dupes, remember kill-ring and search-ring
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; for git-gutter? I can't remember what this is exactly...
(set-fringe-mode '(10 . 0))

;; global keys
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Integrations with the surrounding environment outside emacs
;; XWindows, bash

;; first, I find it maddening to have an independent $PATH for emacs, so fix that:
(use-package exec-path-from-shell :config (exec-path-from-shell-initialize))

;; XWindow urgency integrates with many other tools, including xmonad-electric
;; I've yet to make any use of this but it's a good idea
;; demo
;; ( (lambda
;;     ()
;;     (sleep-for 2)
;;     (x-urgent)) )
(defun x-urgent (&optional arg)
  (interactive "P")
  (let (frame (selected-frame))
    (x-urgency-hint frame (not arg))))

;; x primary selection will be set by emacs whenever a region is selected
(setq x-select-enable-clipboard t)
(setq x-select-enable-primary t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customize some of the built-in emacs modes
;;  TODO check out help+ mode and the other + modes for builtins
(bind-keys :map help-mode-map
           ("s-]" . help-go-forward)
           ("s-[" . help-go-back))
(bind-keys :map emacs-lisp-mode-map
           ("s-]" . find-function-at-point)
           ("s-[" . help-go-back)
           ("s-r" . eval-region)
           ("s-b" . eval-buffer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Completion framework
(use-package company)
;; (global-company-mode)
(use-package company-quickhelp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Make emacs usable by someone with VIM muscle memory

(use-package general)

;; this is required for evil-collection which is better than evil-integration
(setq evil-want-integration nil)
(use-package evil
  :general
  (:keymaps 'normal
   "SPC" 'avy-goto-char-timer
   :prefix ","
   :keymaps 'normal
   "b."     'next-buffer
   "b,"     'previous-buffer
   "bd"     'kill-buffer
   "bl"     'buffer-menu
   "b SPC"  'ido-switch-buffer
   "wd"     'delete-window
   "wb"     'delete-other-windows
   "bk"     'kill-buffer-and-window
   "bd"     'kill-buffer
   "br"     'revert-buffer
   ",s"     'shell
   "pa"     'projectile-ag
   ",/"     'ido-find-file
   ",."     'ido-dired
   ",x"     'smex
   ",b"     'ivy-switch-buffer
   ",,x"    'smex-major-mode-commands
   ",w"     'make-frame
   "gs"     'magit-status)
  :demand t
  :config
  (progn
    (evil-mode 1)
    (ido-mode)
    (ido-everywhere 1)
    (ido-ubiquitous-mode 1)
    (ido-vertical-mode)))

(use-package evil-collection
  :after evil
  :custom (evil-collection-setup-minibuffer t)
  :config (evil-collection-init))

(use-package evil-surround :config (global-evil-surround-mode 1) :defer 3)

;; this is how vim behaves, I think? It's a subtle difference
(setq evil-move-cursor-back t)

;; multiple cursors that are compatible with evil
(use-package evil-mc)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs "windows"

;; Mimic VIM for switching windows
;; I keep hitting these accidentally instead of "C-w k" etc
(define-key evil-motion-state-map (kbd "C-w C-k") 'evil-window-up)
(define-key evil-motion-state-map (kbd "C-w C-j") 'evil-window-down)
(define-key evil-motion-state-map (kbd "C-w C-h") 'evil-window-left)
(define-key evil-motion-state-map (kbd "C-w C-l") 'evil-window-right)

;; I really like this: the mental overhead is low and I can adjust emacs windows with the keyboard
(use-package move-border :straight (move-border :host github :repo "ramnes/move-border"))

;; a hydra for window commands
(defhydra hydraww
  (global-map "s-w"
              :pre (set-cursor-color "#40e0d0")
              :post (progn (set-cursor-color "#ffffff") (message "Thank you, come again.")))

  "windows"
  ("h" evil-window-left  "navigate left")
  ("j" evil-window-down  "navigate down")
  ("k" evil-window-up    "navigate up")
  ("l" evil-window-right "navigate right")

  ("H" move-border-left  "move border left")
  ("J" move-border-down  "move border down")
  ("K" move-border-up    "move border up")
  ("L" move-border-right "move border right")

  ("x" delete-window "delete window")
  ("DEL" kill-this-buffer "kill buffer")

  ("v" split-window-horizontally "split horizontally")
  ("s" split-window-vertically   "split vertically")

  ("." next-buffer     "cycle buffers +")
  ("," previous-buffer "cycle buffers -")

  ("=" text-scale-increase "font size +")
  ("-" text-scale-decrease "font size -")

  ("b" ido-switch-buffer "choose buffer" :exit t)
  ("e" ido-find-file "edit" :exit t)

  ;; how about some to switch to particular kind of buffers?
  ;; should learn more about the buffer list mode in emacs, I know it can filter
  )

;; TODO a hydra for opening interactive environments like repls, database clients, etc... including TRAMP
;; or, should that be xmonad-electric's domain?
