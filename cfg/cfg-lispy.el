(use-package lispy
  ;; :straight
  ;; (lispy :type git
  ;;        :files (:defaults "lispy-clojure.clj")
  ;;        :host github
  ;;        :repo "blak3mill3r/lispy"
  ;;        :upstream (:host github :repo "abo-abo/lispy"))

  ;; (lispy :repo "abo-abo/lispy"
  ;;        :fetcher github
  ;;        :files (:defaults "lispy-clojure.clj" "lispy-clojure-test.clj"))


  ;; :straight
  ;; (lispy :type git
  ;;        :files (:defaults "lispy-clojure.clj" "lispy-clojure-test.clj")
  ;;        :host github :repo "blak3mill3r/lispy" :branch "fix/cider-may-not-be-loaded-yet"
  ;;        :upstream (:host github :repo "abo-abo/lispy"))

  :commands
  'lispy-mode

  :config
  ;; without this, lispy's special wrapping of "/" for lispy-splice, overrides cljr-slash so that / just self-inserts
  (lispy-define-key lispy-mode-map "/" 'lispy-splice :inserter 'cljr-slash)
  (lispy-define-key lispy-mode-map "=" 'lispy-oneline)
  (lispy-define-key lispy-mode-map "J" 'lispy-cursor-down)
  (lispy-define-key lispy-mode-map "K" 'lispy-kill)

  :custom
  (lispy-eval-display-style "overlay")

  :general
  (:states '(normal insert)
   "C-K" 'lispy-kill-sentence)
  (:keymaps 'lispy-mode-map-special
   "C-SPC" 'lispy-cursor-ace
   )
  (:keymaps 'lispy-mode-map
   "s-u" 'lispy-undo
   "s-." 'lispy-arglist-inline
   "s-/" 'lispy-describe-inline
   ;; "s-j" 'lispy-eval-and-comment
   "C-]" 'lispy-beginning-of-defun
   ))

;; strict indentation
(use-package aggressive-indent
  :hook '(lispy-mode . aggressive-indent-mode))

;; don't break parens with vi editing commands
;; I usually do not use vi editing commands in a lisp buffer, but they might as well play nicely together
(use-package lispyville
  :commands
  'lispyville-mode
  :hook '(lispy-mode . lispyville-mode))
