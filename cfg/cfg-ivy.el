(use-package ivy
  :demand t
  :diminish ivy-mode
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t) ))

(use-package ag)

(use-package projectile
  :config
  (setq projectile-mode-line
        '(:eval
          (if (or (file-remote-p default-directory) (not (projectile-project-p)))
              " ℘"
            (format " ℘[%s]" (projectile-project-name)))))
  :general
  (:states '(normal visual)
   :prefix ","
   ;; project-aware things:
   ;; "pc"     'projectile-commander ;; I don't think I like this interface
   "pa" 'projectile-ag                 ;; find file by name
   "pr" 'projectile-replace            ;; globally replace a string
   "pR" 'projectile-replace-regexp     ;; globally replace a regexp
   "pd" 'projectile-dired-other-window ;; dired the project
   "pt" 'projectile-find-implementation-or-test-other-window ;; open associated test or implementation
   ))

(use-package counsel
  :general
  (:keymaps 'normal
   ;; "/" 'swiper
   :prefix ","
   ;; getting help
   "hf" 'counsel-describe-function
   "hv" 'counsel-describe-variable
   ;; yank ring filtering! cool!
   "yr" 'counsel-yank-pop
   "uc" 'counsel-unicode-char
   "pl" 'counsel-list-processes
   ;; searching for files or for strings in files
   ;; "pa"     'counsel-ag                 ;; is there any utility to this with pa? what if there's no project? what does counsel-ag search?
   ",/"     'counsel-find-file ;; the way I usually find *nearby* files
   ",?"     'counsel-git ;; same as the above but only for git-tracked files
   "/l"     'counsel-locate ;; quickly find files *on the entire filesystem*
   "gg"     'counsel-git-grep ;; git-grep for a string
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
