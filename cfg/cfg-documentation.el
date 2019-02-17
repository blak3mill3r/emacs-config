

(use-package markdown-mode
  :mode  (("\\.markdown\\'" . markdown-mode)
          ("\\.md\\'" . markdown-mode))
  :init
  (use-package vmd-mode
    :demand t
    :commands (vmd-mode))
  (defun md-insert-clojure ()
    (interactive)
    (insert "```clojure\n\n```")
    (evil-beginning-of-line)
    (evil-previous-line)
    (evil-insert-line))
  :general
  (:states '(normal)
   :prefix ","
   "vmd" 'vmd-mode)
  (:states '(insert)
   :prefix "s-\\"
   "clj" 'md-insert-clojure)
  :init
  (defun my-markdown-mode-hook ()
    (add-to-list 'company-backends 'vmd-mode-company-backend)
    (company-mode))
  (add-hook 'markdown-mode-hook #'my-markdown-mode-hook))


(use-package evil-org
  :commands (evil-org-mode)
  :init
  ;; this approach has some drawbacks: it's too dumb (doesn't understand nesting or indentation)
  (defun org-insert-clojure ()
    (interactive)
    (insert "#+BEGIN_SRC clojure\n\n#+END_SRC")
    (evil-beginning-of-line)
    (evil-previous-line)
    (org-edit-special))
  :general
  (:keymaps 'evil-org-mode-map
   :states '(normal)
   "^" 'evil-first-non-blank-of-visual-line)
  (:keymaps 'evil-org-mode-map
   :states '(insert)
   :prefix "s-\\"
   "s-\\" 'org-insert-clojure)
  (:keymaps 'clojure-mode-map
   "<s-return>" 'org-edit-src-exit)
  (:keymaps 'evil-org-mode-map
   :states '(normal insert visual)
   "<s-return>" 'org-open-at-point)
  :hook '(org-mode . evil-org-mode)
  :config
  (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading)))

;; something is borked with org + use-package ... org is a little bit insane
;; it worked when I eval'd the following but then it broke when starting fresh emacs

;;(use-package org
;;  )
;;
;;(use-package ox-hugo
;;  :after ox
;;; :config
;;; (require 'ox-hugo-auto-export)
;;  )
