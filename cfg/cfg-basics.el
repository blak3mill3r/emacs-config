;; make it more pretty, and remove all the fluff
(load-theme 'solarized-dark t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; recent file list, my "scratch buffers" are files with jibberish names
;; disabled because of lock conflicts between multiple instances of emacs
;; maybe look into https://github.com/ffevotte/sync-recentf if I miss recentf-mode
(recentf-mode -1)
;; (setq recentf-max-menu-items 25)
;; (global-set-key "\C-x\ \C-r" 'recentf-open-files)
;; (run-at-time nil (* 5 60) 'recentf-save-list)

(menu-bar-mode -1)

(tooltip-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; I use compton for x compositing and without this incantation emacs doesn't cooperate (it's on top of my xmonad-electric overlay)
;;(set-frame-parameter (selected-frame) 'alpha '(100 . 85))
(set-frame-parameter nil 'alpha nil)
;;(add-to-list 'default-frame-alist '(alpha . nil))

;; this is the analogue of
;; :set nowrap
(setq-default truncate-lines t)

;; whitespace! booo!
(setq show-trailing-whitespace t)
;; (use-package ws-butler
;;   :diminish ws-butler-mode
;;   :commands (ws-butler-mode)
;;   :init
;;   (add-hook 'prog-mode-hook #'ws-butler-mode)
;;   (add-hook 'org-mode-hook #'ws-butler-mode)
;;   (add-hook 'text-mode-hook #'ws-butler-mode)
;;   (add-hook 'proof-mode-hook #'ws-butler-mode)
;;   (add-hook 'bibtex-mode-hook #'ws-butler-mode)
;;   :config
;;   (setq ws-butler-convert-leading-tabs-or-spaces t))

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
(setq history-length 2048)
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

(defun x-urgency-hint (frame arg &optional source)
  "Set the x-urgency hint for the frame to arg:

- If arg is nil, unset the urgency.
- If arg is any other value, set the urgency.

If you unset the urgency, you still have to visit the frame to make the urgency setting disappear (at least in KDE)."
  (let* ((wm-hints (append (x-window-property
                            "WM_HINTS" frame "WM_HINTS"
                            source nil t) nil))
         (flags (car wm-hints)))
                                        ; (message flags)
    (setcar wm-hints
            (if arg
                (logior flags #x00000100)
              (logand flags #x1ffffeff)))
    (x-change-window-property "WM_HINTS" wm-hints frame "WM_HINTS" 32 t)))

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
(general-define-key
 :keymaps 'help-mode-map
 "s-]" 'help-go-forward
 "s-[" 'help-go-back)
(general-define-key
 :keymaps 'emacs-lisp-mode-map
 ;; "s-]" 'find-function-at-point
 "s-]" 'xref-find-definitions
 "s-[" 'xref-pop-marker-stack
 "s-r" 'eval-region
 "s-b" 'eval-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Completion framework
(use-package company)
;; (global-company-mode)
(use-package company-quickhelp)

(use-package company-restclient
  :defer t
  :general
  (:keymaps 'restclient-mode-map
   :states '(normal insert visual)
   "s-\\ s-\\" 'restclient-http-send-current-stay-in-window)
  :init
  (defun my--company-restclient ()
    (setq-local company-backends
                (add-to-list 'company-backends 'company-restclient)))

  (add-hook 'restclient-mode-hook #'my--company-restclient))

;; (use-package company-emoji
;;   :defer t

;;   :init
;;   (defun my--company-emoji ()
;;     (add-to-list 'company-backends 'company-emoji t))

;;   (add-hook 'global-company-mode-hook #'my--company-emoji))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Undo tree (undo/redo never forgets anything)
;; persists on disk as well
(use-package undo-tree
  :demand t
  :diminish undo-tree-mode
  :custom
  (undo-tree-auto-save-history t)
  :general
  (:keymaps 'undo-tree-visualizer-mode-map
   :states '(normal motion)
   :prefix ","
   "bd" 'kill-buffer)
  :init
  ;; Do not litter undo-tree files all over the place, because that is super annoying
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . "~/.emacs.d/undo")))
  (unless (file-exists-p "~/.emacs.d/undo")
    (make-directory "~/.emacs.d/undo"))
  (global-undo-tree-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Make emacs usable by someone with VIM muscle memory

;; this is required for evil-collection which is better than evil-integration
(setq evil-want-integration nil)
(use-package evil
  :demand 't
  :general
  (:keymaps 'normal
   "SPC" 'avy-goto-char-timer)
  (:prefix ","
   :keymaps 'normal
   ;; buffers
   "b."     'next-buffer
   "b,"     'previous-buffer
   "bl"     'ibuffer
   "br"     'revert-buffer
   "b SPC"  'ido-switch-buffer
   ",b"     'ido-switch-buffer
   "bk"     'kill-buffer-and-window
   "bd"     'kill-buffer
   ;; frames and windows
   ",w"     'make-frame
   "wd"     'delete-window
   "wb"     'delete-other-windows
   ;; general utilities
   "ds"     'desktop-save-in-desktop-dir
   ",s"     'shell
   ",x"     'smex
   ",,x"    'smex-major-mode-commands
   )
  (:keymaps 'visual
   "|"     'align-regexp)
  (:states '(normal motion visual insert)
   "M-x"    'smex)
  (:keymaps 'motion
   ;; I sometimes accidentally hit these instead of C-w k (move between splits in vim)
   "C-w C-k" 'evil-window-up
   "C-w C-j" 'evil-window-down
   "C-w C-h" 'evil-window-left
   "C-w C-l" 'evil-window-right)
  :demand t
  :config
  (progn
    (evil-mode 1)
    (ido-mode)
    (ido-everywhere 1)
    (ido-ubiquitous-mode 1)
    (ido-vertical-mode)))

;; multiple cursors that are compatible with evil
(use-package evil-mc)

(use-package evil-collection
  :after evil
  :custom (evil-collection-setup-minibuffer t)
  :config (evil-collection-init))

(use-package evil-surround :config (global-evil-surround-mode 1) :defer 3)

;; this is how vim behaves, I think? It's a subtle difference
(setq evil-move-cursor-back t)

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

(use-package yaml-mode
  :defer t)
