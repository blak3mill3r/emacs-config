(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package flycheck
  :defer 5
  :config
  ;; (global-flycheck-mode)
  (add-hook 'prog-mode-hook #'flycheck-mode)
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc coq))
  :general (:states '(normal visual)
            :keymaps 'prog-mode-map
            "s-n" 'flycheck-next-error
            "s-p" 'flycheck-previous-error
            ))

(use-package flycheck-joker
  :demand t
  ;; :defer 5
  )

(use-package clojure-mode
  :mode "\\.edn$"
  :mode "\\.clj$"
  :mode "\\.cljx$"
  :general (:states '(normal insert visual)
            :keymaps 'clojure-mode-map
            "s-|"    'clojure-align)
  :init
  (progn
    (add-hook 'clojure-mode-hook
              #'(lambda ()
                  (message "my CLOJURE MODE hook")
                  (lispy-mode)
                  ;; (yas-minor-mode 1)
                  ;; (clj-refactor-mode 1)
                  (modify-syntax-entry ?_ "w")
                  (modify-syntax-entry ?- "w")
                  (modify-syntax-entry ?> "w")))))

;; (use-package eval-sexp-fu)
;; (use-package cider-eval-sexp-fu
;;   :commands (turn-on-eval-sexp-fu-flash-mode)
;;   :demand t ;; annoying, tried to get rid of :demand without success
;;   :hook '((cider-mode emacs-lisp-mode) . turn-on-eval-sexp-fu-flash-mode))

(use-package cider
  :straight
  ;; (cider :type git :host github :repo "clojure-emacs/cider" :branch "master")
  (cider :type git :host github :repo "clojure-emacs/cider" :branch "v0.16.0")

  :custom
  (cider-known-endpoints
   '(("ropes-blake" "7887")
     ("ropes-blake" "7888")))

  ;; this isn't supported it 0.16.0
  ;; (cider-jdk-src-paths '("/usr/lib/jvm/openjdk-8/src.zip"
  ;;                        "~/src/clojure-1.9.0-sources.jar"))
  (nrepl-hide-special-buffers t)
  (cider-save-file-on-load 'always-save) 
  (cider-repl-popup-stacktraces t)
  (cider-auto-select-error-buffer t)
  (cider-repl-use-pretty-printing t)
  ;; (cider-prompt-for-project-on-connect t)
  (cider-prompt-for-symbol nil) ;; makes s-] nicer
  (cider-macroexpansion-print-metadata t)
  (nrepl-log-messages t)
  (cider-repl-pop-to-buffer-on-connect nil)
  (cider-repl-use-clojure-font-lock t)
  (cider-auto-jump-to-error t)
  (cider-jump-to-compilation-error t)
  (nrepl-sync-request-timeout 300)
  (cider-repl-history-file "~/.emacs.d/nrepl-history")
  (cljr-warn-on-eval nil) ;; just *do not* write effectful namespaces! https://github.com/clojure-emacs/clj-refactor.el/#in-case-refactor-nrepl-used-for-advanced-refactorings
  
  :general
  (:states '(normal insert visual)
   :keymaps 'clojure-mode-map
   "s-]"      'cider-find-var
   "s-["      'cider-pop-back
   "s-\\"     'cider-eval-defun-at-point
   ;; "s-n"      'cider-eval-ns-form
   "s-b"      'cider-eval-buffer
   "s-r"      'cider-eval-region
   "s-m"      'cider-macroexpand-1-inplace
   "s-S-m"    'cider-macroexpand-1
   "s-o"      'cider-pprint-eval-last-sexp
   ;; "s-p s-\\" 'cider-pprint-eval-defun-at-point
   ;; "s-p s-s"  'cider-eval-print-last-sexp
   "s-d"      'cider-debug-defun-at-point
   "s-i s-r"  'cider-inspect-last-result
   "s-SPC"    'cider-nrepl-reset
   
   ;; maybe something closer to s-\\ ? it evals it and then cider-inspects it
   ;; "s-i s-s" 'cider-inspect-last-sexp
   )
  (:keymaps 'cider-repl-mode-map
   "s-SPC" 'cider-repl-clear-buffer)
  (:states '(normal visual)
   :keymaps 'clojure-mode-map
   :prefix ","
   ;; "cj" cider-jack-in
   "cr"  'cider-switch-to-repl-buffer
   "cc"  'cider-connect
   "c/"  'cider-jump-to-compilation-error
   "cns" 'cider-repl-set-ns
   "cnf" 'cider-browse-ns
   "cna" 'cider-browse-ns-all
   "cnc" 'cider-browse-ns-current-ns
   "cd"  'cider-grimoire
   "cD"  'cider-grimoire-web
   "cJ"  'cider-javadoc)
  (:keymaps 'cider-inspector-mode-map
   "s-]"        'cider-inspector-push
   "s-["        'cider-inspector-pop
   "s-n"        'cider-inspector-next-page
   "s-p"        'cider-inspector-prev-page
   "s-SPC"      'cider-inspector-operate-on-point
   "<s-return>" 'cider-inspector-operate-on-point
   "s-j"        'cider-inspector-next-inspectable-object
   "s-k"        'cider-inspector-previous-inspectable-object)

  :init
  (progn
    (add-to-list 'same-window-buffer-names "*cider-repl localhost*")
    (add-hook 'cider-mode-hook
              #'(lambda ()
                  (require 'cider-macroexpansion)
                  (require 'cider-browse-ns)
                  (message "my CIDER MODE hook")
                  (eldoc-mode)
                  (company-mode)

                  ;; this shouldn't be necessary
                  ;; (lispy--clojure-middleware-load)

                  ;; not working yet, with no x toolkit anyway... I don't know if it requires that
                  ;; had it working at home
                  (company-quickhelp-mode)

                  (clj-refactor-mode 1)
                  (yas-minor-mode 1)
                  ;; (turn-on-eval-sexp-fu-flash-mode)
                  (cljr-add-keybindings-with-prefix "s-,")))
    (add-hook 'cider-repl-mode-hook
              #'(lambda ()
                  (message "my CIDER REPL MODE hook")
                  (eldoc-mode)
                  (lispy-mode)
                  (rainbow-delimiters-mode))))
  
  :config
  (defun cider-nrepl-reset ()
    (interactive)
    (save-some-buffers)
    ;; (set-buffer "*cider-repl localhost*")
    (cider-switch-to-repl-buffer)
    (goto-char (point-max))
    (insert "(in-ns 'user) (dev)")
    (cider-repl-return)
    (insert "(reset)")
    (cider-repl-return)))

;; not sure if I like it yet... it seems pretty cool but maybe a bit heavy/bloated
;; play with it more for sure
;; (use-package sayid
;;   :after clojure-mode
;;   :config
;;   (sayid-setup-package))

;;     ;; conflicts! arrg
;;     ;; (require 'clj-refactor)
;;     ;; (cljr-add-keybindings-with-prefix "s-p")

(use-package clojure-snippets)
(use-package seq-25
  :straight 
  (seq-25 :type git :host github :repo "NicolasPetton/seq.el"))
(use-package clj-refactor)

;; breaks/unbreaks company-quickhelp-mode for cider, filed https://github.com/expez/company-quickhelp/issues/79

;; with cider-nrepl > 0.16.0 I've been having problems, lispy-clojure.clj doesn't load and other funny stuff
;; lispy does some funky shit to load its own deps
;; and, since I specify cider-nrepl in profiles.clj it doesn't get the version it wants and is missing
;; cider.nrepl....tools.java/parser from cider, which uses tools.jar (but I have tools.jar on the classpath)
;; ah, because that tools.java namespace *disappeared* from cider after 0.16.0
