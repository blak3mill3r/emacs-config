(use-package clojure-snippets
  :demand t
  :hook '(clojure-mode . yas-minor-mode)
  :config
  (setq yas-prompt-functions '(yas-ido-prompt))
  :diminish yas-minor-mode)

(use-package rainbow-delimiters
  :demand t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package parseedn
  :demand t
  :straight
  (parseedn :type git
            :host github
            :repo "clojure-emacs/parseedn"
            :branch "master"))

(use-package vega-view :demand t)

(use-package flycheck
  :demand t
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
;;  ;; (push '("1/5" . ?⅕) prettify-symbols-alist)
;;  ;; (push '("2/5" . ?⅖) prettify-symbols-alist)
;;  ;; (push '("3/5" . ?⅗) prettify-symbols-alist)
;;  ;; (push '("4/5" . ?⅘) prettify-symbols-alist)
;;  ;; (push '("1/2" . ?½) prettify-symbols-alist)
;;  ;; (push '("3/4" . ?¾) prettify-symbols-alist)
;;  ;; (push '("1/6" . ?⅙) prettify-symbols-alist)
;;  ;; (push '("5/6" . ?⅚) prettify-symbols-alist)
;;  ;; (push '("1/7" . ?⅐) prettify-symbols-alist)
;;  ;; ⅕ ⅖ ⅗ ⅘ ⅙ ⅚ ⅛ ⅜ ⅝ ⅞
;;  ;; (push '("ae" . ?æ) prettify-symbols-alist)
;;  )

;; ᎣლႰႪ
;; ᴪᴫᴎᴂᵦᵧᵩᵫὫᾣῼ‡⁌⁍ጮፙ
;; ፬፭፹፸፷፶፵፴፳፲፱፼፻፺
;; ₰ᴪ
;; ₪
(defun my/pretty-syms ()
  (setq prettify-symbols-alist
        '(("<=" . ?≤)
          (">=" . ?≥)
          ;; ("<-" . ?←)
          ;; ("->" . ?→)
          ;; ("->>" . ?↠)
          ("<=" . ?⇐)
          ("=>" . ?⇒)
          ("fn" . ?λ)
          ("^_^" . ?☻)
          ("1/4" . ?¼)
          ("1/5" . ?⅕)
          ("2/5" . ?⅖)
          ("3/5" . ?⅗)
          ("4/5" . ?⅘)
          ("1/2" . ?½)
          ("3/4" . ?¾)
          ("1/6" . ?⅙)
          ("5/6" . ?⅚)
          ("1/7" . ?⅐)
          ("transform" . ?ჳ)
          ("multi-transform" . ?ჴ)
          ("multi-path" . ?╞)
          ("terminal" . ?Ⴐ)
          ("terminal-val" . ?Ⴊ)
          ("nil->val" . ?⤑)
          ("Double/POSITIVE_INFINITY" . ?∞)
          ("try" . ?Ȣ)
          ("catch" . ?ơ)
          ("throw" . ?☢)
          ("loop". ?↻)
          ("recur". ?↰)
          
          (":)" . ?☺)
          ("):" . ?☹)
          (":D" . ?☺)
          )))


(use-package clojure-mode
  :demand t
  :mode "\\.edn$"
  :mode "\\.clj$"
  :mode "\\.cljx$"
  :general (:states '(normal)
            :keymaps 'clojure-mode-map
            "|"    'clojure-align
            "<f8>" 'prettify-symbols-mode)
  :init
  (defun my-clojure-mode-hook ()
    (message "my CLOJURE MODE hook")
    (lispy-mode 1)
    (my/pretty-syms)
    (prettify-symbols-mode 1)
    (modify-syntax-entry ?_ "w")
    (modify-syntax-entry ?- "w")
    (modify-syntax-entry ?> "w"))
  (add-hook 'clojure-mode-hook #'my-clojure-mode-hook))

;; Weird wtf, without this I get
;; (void-variable clojure-namespace-regexp)
;; even though it IS defined in clojure-mode.el
;; maybe try no-byte-compile for clojure-mode
(defconst clojure-namespace-regexp
  (rx line-start "(" (? "clojure.core/") (or "in-ns" "ns" "ns+") symbol-end))

(use-package clj-refactor
  :straight
  (clj-refactor :no-byte-compile t :type git :host github :repo "clojure-emacs/clj-refactor.el" :branch "master")
  :demand t
  ;;:straight
  ;;(clj-refactor :type git :host github :repo "clojure-emacs/clj-refactor.el" :branch "2.4.0")
  :custom
  (cljr-clojure-test-declaration "[clojure.test :as t :refer [deftest is]]")
  ;; (cljr-inject-dependencies-at-jack-in nil)
  )


;; consider trying this again:

;; (use-package sesman
;;   :demand t
;;   :straight
;;   (sesman :type git :host github :repo "vspinu/sesman" :branch "master"))

(use-package cider
  :demand t
  ;; :straight
  ;; (cider :type git :host github :repo "clojure-emacs/cider" :branch "master"
  ;;        :files (:defaults "cider-test.el"))

  :custom
  (cljr-magic-require-namespaces
   '(("io"   . "clojure.java.io")
     ("set"  . "clojure.set")
     ("str"  . "clojure.string")
     ("walk" . "clojure.walk")
     ("zip"  . "clojure.zip")
     ("mc"   . "monger.collection")))
  (cider-known-endpoints
   '(("ropes-blake" "7887")
     ("ropes-blake" "7888")))

  (cider-jdk-src-paths '("/usr/lib/jvm/openjdk-11/lib/src.zip"))

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
  (cider-macroexpansion-print-metadata nil)
  (nrepl-log-messages t)
  (cider-repl-pop-to-buffer-on-connect nil)
  (cider-repl-use-clojure-font-lock t)
  (cider-auto-jump-to-error 'errors-only)
  (cider-jump-to-compilation-error t)
  (nrepl-sync-request-timeout 300)
  (cider-repl-history-file "~/.emacs.d/nrepl-history")
  (cljr-warn-on-eval nil) ;; just *do not* write effectful namespaces! https://github.com/clojure-emacs/clj-refactor.el/#in-case-refactor-nrepl-used-for-advanced-refactorings
  ;; finally!
  (cider-inject-dependencies-at-jack-in nil)

  :general
  (:states '(normal insert visual)
   :keymaps 'clojure-mode-map
   "s--"      'clojure-cycle-privacy
   "s-]"      'cider-find-var
   "s-["      'cider-pop-back

   "<s-return>"      'cider-test-run-ns-tests

   "s-l"     'cider-eval-last-sexp
   "s-v"     'vega-view
   "s-\\"     'cider-eval-defun-at-point

   "s-b"      'cider-eval-buffer
   "s-r"      'cider-eval-region
   "s-!"      'cider-eval-ns-form
   "s-m"      'cider-macroexpand-1-inplace
   "s-S-m"    'cider-macroexpand-1
   ;; "s-\\"     'lispy-eval
   "s-o"      'cider-pprint-eval-last-sexp
   "s-e"      'cider-enlighten-mode
   ;; "s-p s-\\" 'cider-pprint-eval-defun-at-point
   ;; "s-p s-s"  'cider-eval-print-last-sexp
   "s-d"      'cider-debug-defun-at-point
   "s-i s-r"  'cider-inspect-last-result
   "s-t"    'cider-nrepl-reset
   "C-n" 'lispy-outline-next
   "C-p" 'lispy-outline-prev

   ;; muscle memory expects lispy-eval-and-comment, see cfg-lispy.el, but couldn't get that to work with bleeding-edge cider etc
   "s-j" 'lispy-eval-and-comment

   ;; ace-line -> cider-eval-defun (without moving the cursor)
   "s-SPC" 'ace-fucking-cider-eval

   ;; maybe something closer to s-\\ ? it evals it and then cider-inspects it
   "s-i s-i" 'cider-inspect-last-sexp
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
  ;; working around the insane difficulty of invoking cider-connect programatically after the latest release of cider
  ;; which introduced all this fanciness about sessions linking to buffers
  ;; all of which is quite useless to me... and they made it SUPER HARD to do it non-interactively


  (add-hook 'cider-repl-mode-hook #'cider-company-enable-fuzzy-completion)
  (add-hook 'cider-mode-hook #'cider-company-enable-fuzzy-completion)
  ;; (defun cider-connect-damnit (cider-plist)
  ;;   (with-temp-buffer
  ;;     (unless (car (hash-table-values sesman-sessions-hashmap))
  ;;       (letf (((symbol-function 'yes-or-no-p) (lambda (&rest args) t))
  ;;              ((symbol-function 'y-or-n-p) (lambda (&rest args) t)))
  ;;         (cider-connect-clj cider-plist)))))
  ;; (defun fucking-cider-and-its-fucking-sessions ()
  ;;   (let ((theonlysession (car (hash-table-values sesman-sessions-hashmap))))
  ;;     (if theonlysession
  ;;         (sesman-link-with-buffer (current-buffer) theonlysession)
  ;;       (message "THERE AINT ONE, FUCK"))))

  (defun ace-fucking-cider-eval ()
    (interactive)
    (save-excursion
      (avy-goto-line)
      (cider-eval-defun-at-point)))
  (defun my-cider-mode-hook ()
    (message "MYCIDER: enable yas")
    (yas-minor-mode 1)
    (clj-refactor-mode 1)
    (message "MYCIDER: enable eldoc")
    (eldoc-mode 1)
    (message "MYCIDER: enable company-mode")
    (company-mode 1)
    (message "MYCIDER: require macroexpansion and browse-ns")
    ;; see https://github.com/clojure-emacs/cider/issues/2464
    ;; (message "HACK TO EMULATE cider-default-connection")
    ;; (fucking-cider-and-its-fucking-sessions)
    ;; (require 'cider-macroexpansion)
    ;; (require 'cider-browse-ns)

    ;; not working yet, with no x toolkit anyway... I don't know if it requires that
    ;; had it working at home
    ;; (company-quickhelp-mode)

    ;; (turn-on-eval-sexp-fu-flash-mode)

    (message "MYCIDER: add cljr submap")
    (cljr-add-keybindings-with-prefix "s-,")

    ;; lispy seems to *assume* I am using cider-jack-in, which I am not... FIXME CONFIRM THIS

    ;; (require 'lispy)
    ;; (add-hook 'cider-connected-hook #'lispy--clojure-middleware-load)

    (add-hook 'nrepl-connected-hook
              'lispy--clojure-eval-hook-lambda t)
    )
  (defun my-cider-connected-hook ()
    ;; FIXME what if the necessary dependencies are *not* in the nREPL server?
    ;; I should make this degrade gracefully...
    ;; (lispy-cider-load-file "~/.emacs.d/straight/build/lispy/lispy-clojure.clj")
    (message "NOT DOING IT")
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

(use-package eval-sexp-fu
  :demand t)
(use-package cider-eval-sexp-fu
  :demand t
  :after cider
  :commands (turn-on-eval-sexp-fu-flash-mode)
  :hook '((cider-mode emacs-lisp-mode) . turn-on-eval-sexp-fu-flash-mode))

;; not sure if I like it yet... it seems pretty cool but maybe a bit heavy/bloated
;; play with it more for sure
;; (use-package sayid
;;   :after clojure-mode
;;   :config
;;   (sayid-setup-package))

;; breaks/unbreaks company-quickhelp-mode for cider, filed https://github.com/expez/company-quickhelp/issues/79


;; replacement for clj-refactor?
;; one that does not fuck with the classpath loader?
;; I suspect it is responsible for fishy bugs with loading namespaces failing...

;; (use-package lsp-mode
;;   :commands lsp
;;   :config
;;   (add-to-list 'lsp-language-id-configuration '(clojure-mode . "clojure-mode"))
;;   :init
;;   (setq lsp-enable-indentation nil)
;;   (add-hook 'clojure-mode-hook #'lsp)
;;   (add-hook 'clojurec-mode-hook #'lsp)
;;   (add-hook 'clojurescript-mode-hook #'lsp))

;; (use-package lsp-ui
;;   :commands lsp-ui-mode)

;; (use-package company-lsp
;;   :commands company-lsp)

(defun cider-inspector-watch-iteration ()
  (interactive)
  (let ((window-before (selected-window)))
    (cider-inspector-pop)
    ;; (cider-inspector-refresh)
    (select-window window-before)))

(defun cider-inspector-watch ()
  (setq cider-inspector-watch-timer (run-with-timer 0 1 'cider-inspector-watch-iteration)))

(defun cider-inspector-unwatch ()
  (cancel-timer cider-inspector-watch-timer))

(quote
 (progn
   (cider-inspector-watch-iteration)
   (cider-inspector-watch)
   (cider-inspector-unwatch)
   (cancel-timer 'cider-inspector-watch-iteration)
   ))

(quote
 (progn
   (cider-pprint-eval-last-sexp)
   (cider--pprint-eval-form "(do (Thread/sleep 2000) (+ 1 2))")
   (cider-last-sexp 'bounds)
   (cider-eval-sexp-at-point)
   (with-temp-buffer
     (clojure-mode)
     (cider-mode)
     (insert "(+ 1 2)")
     (goto-char (point-max))
     (cider-eval-last-sexp)
     ;; (sit-for 1)
     )


   ))

(defun cider-just-connect (h p)
  "shut up about sessions and dead repl buffers, and connect when I tell you to..."
  (interactive "^")  
  (letf (((symbol-function 'yes-or-no-p) (lambda (&rest args) t))
         ((symbol-function 'y-or-n-p) (lambda (&rest args) t)))
    (cider-connect `( :host ,h  :port ,p ))))
