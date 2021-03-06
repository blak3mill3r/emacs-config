(use-package json-mode
  :demand t
  :general
  (:state '(normal insert visual)
   :keymaps 'json-mode-map
   "s-t" 'json-toggle-boolean
   "s-<backspace>" 'json-nullify-sexp
   "s--" 'json-decrement-number-at-point
   "s-=" 'json-increment-number-at-point
   "s-, s-f" 'json-mode-beautify
   "s-k" 'json-mode-kill-path
   "s-j" 'jq-interactively
   "s-y" (lambda () (interactive) (kill-new (car minibuffer-history)))
   ;; "" 'jq-interactive-command
   
   )
  :config
  (setq json-reformat:indent-width 4))

(use-package jq-mode
  :demand t
  :general
  (:states '(normal insert visual)
   :keymaps 'json-mode-map
   ;; ""      '
   ))
