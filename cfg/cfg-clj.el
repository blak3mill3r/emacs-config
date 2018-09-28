(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package flycheck
  :defer 5
  :hook '(clojure-mode . flycheck-mode)
  :config
  ;; (global-flycheck-mode)
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

;; (comment
;;  ;; (push '("\\geq" . ?≥) prettify-symbols-alist)
;;  ;; (push '("\\leq" . ?≤) prettify-symbols-alist)
;;  ;; (push '("\\neg" . ?¬) prettify-symbols-alist)
;;  ;; (push '("\\rightarrow" . ?→) prettify-symbols-alist)
;;  ;; (push '("\\leftarrow" . ?←) prettify-symbols-alist)
;;  ;; (push '("\\infty" . ?∞) prettify-symbols-alist)
;;  ;; (push '("-->" . ?→) prettify-symbols-alist)
;;  ;; (push '("<--" . ?←) prettify-symbols-alist)
;;  ;; (push '("\\exists" . ?∃) prettify-symbols-alist)
;;  ;; (push '("\\nexists" . ?∄) prettify-symbols-alist)
;;  ;; (push '("\\forall" . ?∀) prettify-symbols-alist)
;;  ;; (push '("\\or" . ?∨) prettify-symbols-alist)
;;  ;; (push '("\\and" . ?∧) prettify-symbols-alist)
;;  ;; (push '(":)" . ?☺) prettify-symbols-alist)
;;  ;; (push '("):" . ?☹) prettify-symbols-alist)
;;  ;; (push '(":D" . ?☺) prettify-symbols-alist)
;;  ;; (push '("\\checkmark" . ?✓) prettify-symbols-alist)
;;  ;; (push '("\\check" . ?✓) prettify-symbols-alist)
;;  ;; (push '("1/4" . ?¼) prettify-symbols-alist)
;;  ;; (push '("1/2" . ?½) prettify-symbols-alist)
;;  ;; (push '("3/4" . ?¾) prettify-symbols-alist)
;;  ;; (push '("1/7" . ?⅐) prettify-symbols-alist)
;;  ;; ⅕ ⅖ ⅗ ⅘ ⅙ ⅚ ⅛ ⅜ ⅝ ⅞
;;  ;; (push '("ae" . ?æ) prettify-symbols-alist)
;;  )

;; ᎣლႰႪ
;; ᴪᴫᴎᴂᵦᵧᵩᵫὫᾣῼ‡⁌⁍ጮፙ
;; ፬፭፹፸፷፶፵፴፳፲፱፼፻፺
;; ₰ᴪ
(defun my/pretty-syms ()
  (setq prettify-symbols-alist
        '(("<=" . ?≤)
          (">=" . ?≥)
          ("<-" . ?←)
          ("->" . ?→)
          ("<=" . ?⇐)
          ("=>" . ?⇒)
          ("fn" . ?λ)
          ("^_^" . ?☻)
          ("transform" . ?ჳ)
          ("multi-transform" . ?ჴ)
          ("multi-path" . ?╞)
          ("terminal" . ?Ꮿ)
          ("terminal-val" . ?Ꮂ)
          ("true" . ?ፐ)
          ("false" . ?ፑ))))


(use-package clojure-mode
  :mode "\\.edn$"
  :mode "\\.clj$"
  :mode "\\.cljx$"
  :general (:states '(normal insert visual)
            :keymaps 'clojure-mode-map
            "s-|"    'clojure-align
            "<f8>" 'prettify-symbols-mode)
  :init
  (defun my-clojure-mode-hook ()
    (message "my CLOJURE MODE hook")
    (lispy-mode 1)
    (prettify-symbols-mode 1)
    (my/pretty-syms)
    (modify-syntax-entry ?_ "w")
    (modify-syntax-entry ?- "w")
    (modify-syntax-entry ?> "w"))
  (add-hook 'clojure-mode-hook #'my-clojure-mode-hook))

;; (use-package eval-sexp-fu)
;; (use-package cider-eval-sexp-fu
;;   :commands (turn-on-eval-sexp-fu-flash-mode)
;;   :demand t ;; annoying, tried to get rid of :demand without success
;;   :hook '((cider-mode emacs-lisp-mode) . turn-on-eval-sexp-fu-flash-mode))

(use-package sesman
  :straight
  (sesman :type git :host github :repo "vspinu/sesman" :branch "master"))

(use-package cider
  :straight
  (cider :type git :host github :repo "clojure-emacs/cider" :branch "v0.18.0")

  :custom
  (cider-known-endpoints
   '(("ropes-blake" "7887")
     ("ropes-blake" "7888")))

  ;; this isn't supported it 0.16.0
  ;; (cider-jdk-src-paths '("/usr/lib/jvm/openjdk-8/src.zip"
  ;;                        "~/src/clojure-1.9.0-sources.jar"))
  (nrepl-hide-special-buffers t)
  (cider-save-file-on-load t) ;; always save without prompt
  (cider-repl-popup-stacktraces t)
  (cider-auto-select-error-buffer t)
  (cider-repl-use-pretty-printing t)
  ;; (cider-prompt-for-project-on-connect t)
  (cider-prompt-for-symbol nil) ;; makes s-] nicer
  (cider-macroexpansion-print-metadata t)
  (nrepl-log-messages t)
  (cider-repl-pop-to-buffer-on-connect nil)
  (cider-repl-use-clojure-font-lock t)
  (cider-auto-jump-to-error 'errors-only)
  (cider-jump-to-compilation-error t)
  (nrepl-sync-request-timeout 300)
  (cider-repl-history-file "~/.emacs.d/nrepl-history")
  (cljr-warn-on-eval nil) ;; just *do not* write effectful namespaces! https://github.com/clojure-emacs/clj-refactor.el/#in-case-refactor-nrepl-used-for-advanced-refactorings
  
  :general
  (:states '(normal insert visual)
   :keymaps 'clojure-mode-map
   "s-]"      'cider-find-var
   "s-["      'cider-pop-back
   "s-\\"     'cider-eval-last-sexp
   ;; "s-\\"     'cider-eval-defun-at-point
   "s-b"      'cider-eval-buffer
   "s-r"      'cider-eval-region
   "s-;"      'cider-eval-ns-form
   "s-m"      'cider-macroexpand-1-inplace
   "s-S-m"    'cider-macroexpand-1
   "s-o"      'cider-pprint-eval-last-sexp
   "s-e"      'cider-enlighten-mode
   ;; "s-p s-\\" 'cider-pprint-eval-defun-at-point
   ;; "s-p s-s"  'cider-eval-print-last-sexp
   "s-d"      'cider-debug-defun-at-point
   "s-i s-r"  'cider-inspect-last-result
   "s-SPC"    'cider-nrepl-reset
   "C-n" 'lispy-outline-next
   "C-p" 'lispy-outline-prev

   ;; muscle memory expects lispy-eval-and-comment, see cfg-lispy.el, but couldn't get that to work with bleeding-edge cider etc
   "s-j" 'cider-pprint-eval-last-sexp
   
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
  (defun my-cider-mode-hook ()
    (message "MYCIDER: enable yas & clj-ref")
    (yas-minor-mode 1)
    (clj-refactor-mode 1)
    (message "MYCIDER: enable eldoc")
    (eldoc-mode 1)
    (message "MYCIDER: enable company-mode")
    (company-mode 1)
    (message "MYCIDER: require macroexpansion and browse-ns")
    (require 'cider-macroexpansion)
    (require 'cider-browse-ns)

    ;; not working yet, with no x toolkit anyway... I don't know if it requires that
    ;; had it working at home
    ;; (company-quickhelp-mode)

    ;; (turn-on-eval-sexp-fu-flash-mode)
    (message "MYCIDER: add cljr submap")
    (cljr-add-keybindings-with-prefix "s-,"))
  (defun my-cider-connected-hook ()
    ;; lispy seems to *assume* I am using cider-jack-in, which I am not... FIXME CONFIRM THIS
    (message "MYCIDERCONNECT: load lispy middleware")
    (lispy--clojure-middleware-load)
    )
  (defun my-cider-repl-mode-hook ()
    (eldoc-mode 1)
    (lispy-mode 1)
    ;; (too-long-lines-mode 1)
    (aggressive-indent-mode 0)
    (rainbow-delimiters-mode 1))
  ;; (add-to-list 'same-window-buffer-names "*cider-repl localhost*")
  (add-hook 'cider-mode-hook #'my-cider-mode-hook)
  (add-hook 'cider-connected-hook #'my-cider-connected-hook)
  (add-hook 'cider-repl-mode-hook #'my-cider-repl-mode-hook)
  
  :config
  ;; https://www.reddit.com/r/emacs/comments/7au3hj/how_do_you_manage_your_emacs_windows_and_stay_sane/
  (add-to-list 'display-buffer-alist
               '("\\*cider-repl .*"
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (reusable-frames . visible)
                 (side . bottom)
                 (window-height . 0.2)))
  ;; (add-to-list 'display-buffer-alist
  ;;              '("\\*compilation\\*"
  ;;                (display-buffer-reuse-window display-buffer-same-window)))

  (defun cider-nrepl-reset ()
    (interactive)
    (save-excursion
      (save-some-buffers)
      ;; (set-buffer "*cider-repl localhost*")
      (set-buffer "dev.clj")
      (cider-eval-buffer)
      (cider-switch-to-repl-buffer)
      (goto-char (point-max))
      (insert "(in-ns 'user) (reset)")
      ;; (insert "(in-ns 'dev) (reset)")
      (cider-repl-return) )))

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
(use-package clj-refactor
  :straight
  (clj-refactor :type git :host github :repo "clojure-emacs/clj-refactor.el" :branch "2.4.0")
  :config
  (cljr-add-keybindings-with-prefix "s-i")
  ;; :general
  ;; '(:states (normal visual)
  ;;   :keymaps clojure-mode-map
  ;;   "s-n" 'flycheck-next-error
  ;;   "s-p" 'flycheck-previous-error
  ;;   )
  
  
  )

;; breaks/unbreaks company-quickhelp-mode for cider, filed https://github.com/expez/company-quickhelp/issues/79

;; with cider-nrepl > 0.16.0 I've been having problems, lispy-clojure.clj doesn't load and other funny stuff
;; lispy does some funky shit to load its own deps
;; and, since I specify cider-nrepl in profiles.clj it doesn't get the version it wants and is missing
;; cider.nrepl....tools.java/parser from cider, which uses tools.jar (but I have tools.jar on the classpath)
;; ah, because that tools.java namespace *disappeared* from cider after 0.16.0
