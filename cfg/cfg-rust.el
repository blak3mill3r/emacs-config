(use-package cargo)
(use-package racer
  :general
  (:states '(normal insert)
   :keymaps 'rust-mode-map
   "s-]" 'racer-find-definition
   "s-[" 'pop-tag-mark)
  
  :config
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)
  (add-hook 'rust-mode-hook #'cargo-minor-mode)


  ;; (require 'rust-mode)
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t)
  ;; For automatic completions, customize company-idle-delay and company-minimum-prefix-length.



  )

;; without explicitly using flymake-easy:
;; Error (use-package): flymake-rust/:catch: Cannot open load file: No such file or directory, flymake-easy
(use-package flymake-easy)
(use-package flymake-rust)
