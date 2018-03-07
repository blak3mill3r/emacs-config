(use-package lispy
  :straight
  (lispy :type git :files (:defaults "lispy-clojure.clj" "lispy-clojure-test.clj") :host github :repo "blak3mill3r/lispy" :branch "fix/cider-may-not-be-loaded-yet"
         :upstream (:host github
                    :repo "abo-abo/lispy"))
  :commands
  (lispy-mode)

  :general
  (:keymaps 'lispy-mode-map-special
   "J" 'lispy-cursor-down
   "C-SPC" 'lispy-cursor-ace)
  (:keymaps 'lispy-mode-map
   "s-." 'lispy-arglist-inline
   "s-/" 'lispy-describe-inline
   "s-j" 'lispy-eval-and-comment))

;; strict indentation
(use-package aggressive-indent
  :hook (lispy-mode . aggressive-indent-mode))

;; don't break parens with vi editing commands
;; I usually do not use vi editing commands in a lisp buffer, but they might as well play nicely together
(use-package lispyville
  :commands (lispyville-mode)
  :hook (lispy-mode . lispyville-mode))




