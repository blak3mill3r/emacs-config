(use-package ivy
  :demand t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t) ))

(use-package ag)

(use-package projectile
  :bind (:map evil-normal-state-map
         (",pf" . projectile-find)
         (",pa" . projectile-ag)
         (",pr" . projectile-replace)
         (",p!" . projectile-commander)))

(use-package counsel
  :general
  (:keymaps 'normal
   ;; "/" 'swiper
   :prefix ","
   ;; getting help
   "hf" 'counsel-describe-function
   "hv" 'counsel-describe-variable
   "yr" 'counsel-yank-pop
   "uc" 'counsel-unicode-char
   "pl" 'counsel-list-processes
   ;; searching for files or for strings in files
   "pa"     'counsel-ag                 ;; grep(ish) current directory interactively
   ",/"     'counsel-find-file          ;; the way I usually find *nearby* files
   ",?"     'counsel-git                ;; same as the above but only for git-tracked files
   "/l"     'counsel-locate             ;; quickly find files *on the entire filesystem*
   "gg"     'counsel-git-grep           ;; git-grep for a string
   ",."     'ido-dired
   ;; todo (do I want rhythmbox?)
   ;; 'counsel-rhythmbox
   ))

(use-package swiper
  :demand t
  :diminish ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t))
