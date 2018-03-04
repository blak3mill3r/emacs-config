(use-package clojure-mode
  :mode ("\\.edn$" . clojure-mode)
  :mode ("\\.clj$" . clojure-mode)
  :mode ("\\.cljx$" . clojure-mode)
  :config
  (progn
    (message "LOADED CLOJURE MODE")
    (add-hook 'clojure-mode-hook
              #'(lambda ()
                  (lispy-mode)
                  (aggressive-indent-mode)
                  (yas-minor-mode 1)
                  (clj-refactor-mode 1)
                  (modify-syntax-entry ?_ "w")
                  (modify-syntax-entry ?- "w")
                  (modify-syntax-entry ?> "w")))))

;; not sure if I like it yet... it seems pretty cool but maybe a bit heavy/bloated
;; play with it more for sure
;; (use-package sayid
;;   :after clojure-mode
;;   :config
;;   (sayid-setup-package))

;; had this working but now it's broken, bah
;; (use-package highlight  :demand t)
;; (use-package cider-eval-sexp-fu
;;   :demand t
;;   :config
;;   (progn
;;     (defun init-sexp-fu ()
;;       (turn-on-eval-sexp-fu-flash-mode))
;;     (add-hook 'clojure-mode-hook #'init-sexp-fu)
;;     (add-hook 'emacs-lisp-mode-hook #'init-sexp-fu)
;;     ;; works even though it's commented out...?
;;     (add-hook 'pixie-mode-hook #'init-sexp-fu)
;;     ))


(use-package cider
  :bind (:map evil-normal-state-map
              ("s-m" . cider-macroexpand-1)
              (",cj" . cider-jack-in)
              (",cr" . cider-switch-to-repl-buffer)
              (",cc" . cider-connect)
              (",c/" . cider-jump-to-compilation-error)
              (",cns" . cider-repl-set-ns)
              ;; (",cljs" . cider-figwheel-repl)
              ;; (",cljj" . cider-jack-in-clojurescript)
              )
  :init
  (progn

    (add-hook 'cider-mode-hook #'company-mode)
    (add-hook 'cider-mode-hook #'company-quickhelp-mode) ;; This seems to be broken if I have clj-refactor enabled
    ;; (add-hook 'cider-mode-hook #'init-sexp-fu)

    ;; copied from https://github.com/otijhuis/emacs.d/blob/master/config/lisp-settings.el
    (setq nrepl-hide-special-buffers t)
    (setq cider-prompt-save-file-on-load 'always-save)

    ;; Enable error buffer popping also in the REPL:
    (setq cider-repl-popup-stacktraces t)

    ;; auto-select the error buffer when it's displayed
    (setq cider-auto-select-error-buffer t)

    ;; Pretty print results in repl
    ;; (setq cider-repl-use-pretty-printing t)
    (setq cider-repl-use-pretty-printing nil)

    ;; Don't prompt for project when connecting
    (setq cider-prompt-for-project-on-connect nil)

    ;; Don't prompt for symbols
    (setq cider-prompt-for-symbol nil)

    (setq cider-repl-print-length 100))
  :config
  (progn

    (bind-keys :map clojure-mode-map
               ("s-/" . lispy-describe-inline)
               ("s-." . lispy-arglist-inline)
               ("s-j" . lispy-eval-and-comment)
               ("s-k" . cider-eval-last-sexp-and-replace)
               ("s-m" . lispy-alt-multiline)
               ("s-SPC" . nrepl-reset))

    ;; conflicts! arrg
    (require 'clj-refactor)
    (cljr-add-keybindings-with-prefix "s-p")

    (defun nrepl-reset ()
      (interactive)
      (save-some-buffers)
      (set-buffer "*cider-repl localhost*")
      (goto-char (point-max))
      (insert "(in-ns 'user) (dev)")
      (cider-repl-return)
      (insert "(reset)")
      (cider-repl-return))

    (setq nrepl-sync-request-timeout 300)
    (setq nrepl-hide-special-buffers t)
    (setq cider-popup-stacktraces-in-repl t)
    (setq cider-repl-history-file "~/.emacs.d/nrepl-history")
    (setq cider-repl-pop-to-buffer-on-connect nil)
    (setq cider-repl-use-clojure-font-lock t)
    ;;(setq cider-auto-select-error-buffer nil)
    (setq cider-prompt-save-file-on-load nil)

    ;; copied from https://github.com/otijhuis/emacs.d/blob/master/config/lisp-settings.el
    (setq cider-repl-pop-to-buffer-on-connect nil) ; Prevent the auto-display of the REPL buffer in a separate window after connection is established
    (setq cider-repl-use-clojure-font-lock t)
    (setq cider-show-error-buffer nil)
    (setq cider-jump-to-compilation-error nil)
    (setq cider-auto-jump-to-error nil)
    (add-to-list 'same-window-buffer-names "*cider-repl localhost*")
    ;; FIXME use :bind
    (define-key clojure-mode-map (kbd "s-m") 'cider-macroexpand-1-inplace)
    (define-key clojure-mode-map (kbd "s-e") 'cider-enlighten-mode)
    (define-key cider-inspector-mode-map (kbd "s-[") 'cider-inspector-pop)
    (define-key cider-inspector-mode-map (kbd "s-]") 'cider-inspector-push)
    (define-key cider-inspector-mode-map (kbd "s-n") 'cider-inspector-next-page)
    (define-key cider-inspector-mode-map (kbd "s-p") 'cider-inspector-prev-page)
    (define-key cider-inspector-mode-map (kbd "s-SPC")      'cider-inspector-operate-on-point)
    (define-key cider-inspector-mode-map (kbd "<s-return>") 'cider-inspector-operate-on-point)
    (define-key cider-inspector-mode-map (kbd "s-j") 'cider-inspector-next-inspectable-object)
    (define-key cider-inspector-mode-map (kbd "s-k") 'cider-inspector-previous-inspectable-object)

    (define-key clojure-mode-map (kbd "s-]"     ) 'cider-find-var)
    (define-key clojure-mode-map (kbd "s-["     ) 'cider-pop-back)
    (define-key clojure-mode-map (kbd "s-m"     ) 'cider-macroexpand-1-inplace)
    (define-key cider-repl-mode-map (kbd "s-SPC") 'cider-repl-clear-buffer)
    (define-key clojure-mode-map (kbd "s-o") 'cider-pprint-eval-last-sexp)



    ;; this was deprecated in favor of whatever "C-c SPC" runs, which is built into clojure-mode
    ;;(define-key clojure-mode-map (kbd "s-="   ) 'align-cljlet)

    ;; wtf does this even do? if I redefine the macro and run it, it doesn't pick up the change...
    ;; (define-key cider-macroexpansion-mode (kbd "s-m"     ) 'cider-macroexpand-again)
    ;;  upcoming? in cider master...
    ;; (define-key clojure-mode-map (kbd "s-m s-m"     ) 'cider-macroexpand-1-inplace)
    ;; (define-key clojure-mode-map (kbd "s-m s-k"     ) 'cider-macroexpand-all-inplace)



    ;;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
    (add-hook 'cider-repl-mode-hook 'subword-mode)

    (setq cider-macroexpansion-print-metadata t ) 
    (define-key clojure-mode-map (kbd "s-d"   ) 'cider-pprint-eval-defun-at-point)
    (define-key clojure-mode-map (kbd "s-\\"    ) 'cider-eval-defun-at-point)
    (define-key clojure-mode-map (kbd "s-|"     ) 'cider-debug-defun-at-point)
    (define-key clojure-mode-map (kbd "s-n"     ) 'cider-eval-ns-form)
    (define-key clojure-mode-map (kbd "s-b"     ) 'cider-eval-buffer)
    (define-key clojure-mode-map (kbd "s-m"     ) 'lispy-alt-multiline)
    (define-key clojure-mode-map (kbd "s-r"     ) 'cider-eval-region) 
    (define-key clojure-mode-map (kbd "s-h"     ) 'cider-eval-print-handler) 
    (define-key clojure-mode-map (kbd "s-l"     ) 'cider-eval-print-last-sexp) 
    (define-key clojure-mode-map (kbd "s-i s-r"   ) 'cider-inspect-last-result)
    (define-key clojure-mode-map (kbd "s-i s-s"   ) 'cider-inspect-last-sexp)


    ;;(evil-leader/set-key-for-mode 'clojure-mode "cnf" 'cider-browse-ns )
    ;;(evil-leader/set-key-for-mode 'clojure-mode "cna" 'cider-browse-ns-all )
    ;;(evil-leader/set-key-for-mode 'clojure-mode "cnc" 'cider-browse-ns-current-ns )
    ;;(evil-leader/set-key-for-mode 'clojure-mode "cd" 'cider-grimoire)
    ;;(evil-leader/set-key-for-mode 'clojure-mode "cD" 'cider-grimoire-web)
    ;;(evil-leader/set-key-for-mode 'clojure-mode "cJ" 'cider-javadoc)

    (defun cider-figwheel-repl ()
      (interactive)
      (save-some-buffers)
      (with-current-buffer (cider-current-repl-buffer)
        (goto-char (point-max))
        (insert "(require 'figwheel-sidecar.repl-api)
             (figwheel-sidecar.repl-api/start-figwheel!) ; idempotent
             (figwheel-sidecar.repl-api/cljs-repl)")
        (cider-repl-return)))

    ;; I find it extremely annoying to have exceptions take over a frame with this buffer so I shut it off:
    (setq cider-show-error-buffer nil)

    
    (global-set-key [f8] 'prettify-symbols-mode)

    ;; cool Georgian chars:
    ;; ა ბ გ დ ე ვ ზ თ ი კ ლ მ ნ ო პ
    ;; ჟ რ ს ტ უ ფ ქ ღ ყ შ ჩ ც ძ წ ჭ
    ;; ხ ჯ ჰ ჱ ჲ ჳ ჴ ჵ ჶ ჷ ჸ ჹ ჺ

    ;; there's Greek, Lao, Arabic
    

    (setq clojure--prettify-symbols-alist
          '(("fn"         . ?λ )
            ("comp"       . ?∘ )
            ("filter"     . ?Ƒ )
            ("not="       . ?≠ )
            ("some"       . ?∃ )
            ("none?"      . ?∄ )
            ("map"        . ?∀ )
            ("true"       . ?𝐓 )
            ("false"      . ?𝐅 )
            ("cons"       . ?« )
            ("and"        . ?∧ )
            ("or"         . ?∨ )
            ("<="         . ?≤ )
            (">="         . ?≥ )
            ("partial"    . ?⋈ )
            ("loop"       . ?◎ )
            ("recur"      . ?◉ )
            ("reduce"     . ?∑ )
            ("chan"       . ?≋ )
            ("complement" . ?∁ )
            ("identical?" . ?≡ )
            ;;("->" . ?→)
            ;;("->>" . ?⇒)
            ;;("<!" . ?⪡) ;; wtf happened here? same font Menlo-Regular.ttf, doesn't have these unicode chars on my new workstation
            ;;(">!" . ?⪢ )
            ;;("<!!" . ?⫷ )
            ;;(">!!" . ?⫸ )
            ;;("" . ?◉ )
            ;;("" . ?⧬ )
            ;;("" . ?⧲ )
            ;;("" . ?⚇ )
            ;;("" . ?◍ )
            ;;⟅ ⟆ ⦓ ⦔ ⦕ ⦖ ⸦ ⸧ ⸨ ⸩ ｟ ｠ ⧘ ⧙ ⧚ ⧛ ︷ ︸
            ;;∾ ⊺ ⋔ ⫚ ⟊ ⟔ ⟓ ⟡ ⟢ ⟣ ⟤ ⟥
            ;;      ("" . ? )
            ))))


(use-package clojure-snippets)
(use-package clj-refactor) ;; breaks/unbreaks company-quickhelp-mode for cider, filed https://github.com/expez/company-quickhelp/issues/79

;; with cider-nrepl > 0.16.0 I've been having problems, lispy-clojure.clj doesn't load and other funny stuff
;; lispy does some funky shit to load its own deps
;; and, since I specify cider-nrepl in profiles.clj it doesn't get the version it wants and is missing
;; blah.blah.tools.java/parser from cider, which uses tools.jar (but I have tools.jar on the classpath)
