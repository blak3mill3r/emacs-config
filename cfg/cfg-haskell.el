;; eval region of a haskell buffer in intero, but *without* switching to the repl buffer (which is a dumb idea)
(defun haskell-eval-region ()
  (interactive)
  (intero-repl-eval-region (region-beginning) (region-end)) (intero-repl-switch-back))

(defun haskell-eval-line ()
  (interactive)
  (intero-repl-eval-region (point-min) (point-max)) (intero-repl-switch-back))

;; (use-package intero
;;   :bind (:map evil-normal-state-map
;;          (",,t" . intero-targets)
;;          :map intero-repl-mode-map
;;          ("s-\\ s-SPC" . intero-repl-clear-buffer)
;;          :map haskell-mode-map
;;          ("s-\\ s-SPC" . (lambda ()
;;                            (interactive)
;;                            (intero-repl-restart)
;;                            (intero-repl-load)
;;                            (intero-repl-switch-back)))
;;          ("s-\\ s-k" . intero-restart)
;;          ("s-\\ s-\\" . haskell-eval-line)
;;          ("s-." . intero-type-at)
;;          ("s-," . intero-info)
;;          ("s-\\ s-u" . intero-uses-at)
;;          ;; hydra this:
;;          ;; ("s-n" . intero-highlight-uses-mode-next)
;;          ;; ("s-p" . intero-highlight-uses-mode-prev)
;;          ;; ("s-\\ s-r" . intero-highlight-uses-mode-replace)
;;          ;; ("s-j" . intero-highlight-uses-mode-stop-here)
;;          ("s-r" . haskell-eval-region)
;;          ("s-\\ s-j" . intero-repl-load)
;;          ("s-]" . intero-goto-definition)
;;          ("s-[" . pop-tag-mark)
;;          ;; ("s-]" . haskell-mode-jump-to-def-or-tag)
;;          ("<tab>" . company-complete)
;;          ;; ("s-," . (lambda () (interactive) (intero-get-loc-at  (point-min) (point-max))))

;;          :map intero-repl-mode-map
;;          ("s-<return>" . intero-repl-switch-back))
;;   :commands (intero-mode)
;;   ;; :config

;;   )



;; want, but last I tried it I got confused and shit broke:
;; (use-package intero
;;   :demand t)

(use-package haskell-mode
  :demand t
  :mode ("\\.hs$" . haskell-mode)
  :general (:states '(normal)
            :keymaps 'haskell-mode-map
            "s-n"         'flycheck-next-error
            "s-p"         'flycheck-previous-error
            "s-/"         'flycheck-list-errors
            "s-]"         'haskell-mode-jump-to-def
            ;; ("s-b"         . flycheck-buffer)
            ))

(use-package hindent
  :demand t)
