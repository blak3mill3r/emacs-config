(use-package lispy
  :demand t
  :straight
  (lispy :type git
         :files (:defaults "lispy-clojure.clj")
         :host github
         :repo "blak3mill3r/lispy"
         :branch "classpath-control"
         :upstream (:host github :repo "abo-abo/lispy"))

  :custom
  (lispy-cider-connect-method 'cider-connect)

  ;; (lispy :repo "abo-abo/lispy"
  ;;        :fetcher github
  ;;        :files (:defaults "lispy-clojure.clj" "lispy-clojure-test.clj"))

  ;; try lispy-out-forward-newline binding
  ;; maybe S-return ?
  ;; handy if you're in a form and want to escape and go new line

  :commands
  'lispy-mode

  :config
  ;; without this, lispy's special wrapping of "/" for lispy-splice, overrides cljr-slash so that / just self-inserts
  (lispy-define-key lispy-mode-map "/" 'lispy-splice :inserter 'cljr-slash)
  ;; (lispy-define-key lispy-mode-map "/" 'lispy-splice :inserter 'self-insert-command)

  (lispy-define-key lispy-mode-map "=" 'lispy-oneline)
  (lispy-define-key lispy-mode-map "J" 'lispy-cursor-down)
  (lispy-define-key lispy-mode-map "K" 'lispy-kill)
  (lispy-define-key lispy-mode-map "-" 'lispy-ace-subword)
  (lispy-define-key lispy-mode-map "\\" 'lispy-splice)

  :custom
  (lispy-eval-display-style "overlay")

  :general
  (:states '(normal)
   "C-o" 'lispy-tab)
  (:states '(normal insert)
   "C-K" 'lispy-kill-sentence
   ;; <M-return>
   "<M-return>" 'lispy-out-forward-newline)
  (:keymaps 'lispy-mode-map-special
   "C-SPC" 'lispy-cursor-ace
   )
  (:keymaps 'lispy-mode-map
   "s-u" 'lispy-undo
   "s-." 'lispy-arglist-inline
   "s-/" 'lispy-describe-inline
   "s-j" 'lispy-eval-and-comment
   "s-J" 'lispy-eval-and-insert
   ;; "s-\\" 'lispy-eval
   ;; "s-o" 'lispy-eval
   "!" 'special-lispy-beginning-of-defun))

;; strict indentation
(use-package aggressive-indent
  :demand t
  :hook '(lispy-mode . aggressive-indent-mode))

;; don't break parens with vi editing commands
;; I usually do not use vi editing commands in a lisp buffer, but they might as well play nicely together
(use-package lispyville
  :demand t
  :commands
  'lispyville-mode
  :hook '(lispy-mode . lispyville-mode))
