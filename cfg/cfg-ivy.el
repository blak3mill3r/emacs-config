
(use-package ivy
  :demand t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t) ))

(use-package projectile
  :demand t
  :bind (:map evil-normal-state-map
              (",pf" . projectile-find)
              (",pa" . projectile-ag)
              (",pr" . projectile-replace)
              (",p!" . projectile-commander)
              ;; ("" . )
              ;; ("" . )
              )
  )

(use-package counsel
  :demand t
  :bind (:map evil-normal-state-map
              (",hf" . counsel-describe-function)
              (",hv" . counsel-describe-variable)
              (",yr" . counsel-yank-pop)
              (",hi" . counsel-info-lookup-symbol)
              (",hu" . counsel-unicode-char)

              ;; process list
              (",pl" . counsel-list-processes)
              ;; fancier search in buffer
              ("C-/" . swiper)
              ;; find file
              (",ff" . counsel-find-file)
              ;; find git file
              (",gf" . counsel-git)
              ;; search for a string in this directory
              (",//" . counsel-ag)
              ;; wow that is cool, uses slocate
              (",/l" . counsel-locate)
         
              ;; ("" . )
              )
  )

(use-package swiper
  :demand t
  :diminish ivy-mode
  ;; :bind (("" .)
  ;;        ("" .)
  ;;        ("" .)
  ;;        ("" .)
  ;;        ("" .)
  ;;        ("" .)
  ;;        ("" .))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  )

;; (global-set-key "\C-s" 'swiper)
;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
;; (global-set-key (kbd "<f6>") 'ivy-resume)
;; (global-set-key (kbd "M-x") 'counsel-M-x)
;; (global-set-key (kbd "C-x C-f") 'counsel-find-file)
;; (global-set-key (kbd "<f1> f") 'counsel-describe-function)
;; (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;; (global-set-key (kbd "<f1> l") 'counsel-find-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "C-c g") 'counsel-git)
;; (global-set-key (kbd "C-c j") 'counsel-git-grep)
;; (global-set-key (kbd "C-c k") 'counsel-ag)
;; (global-set-key (kbd "C-x l") 'counsel-locate)
;; (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
;; (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
