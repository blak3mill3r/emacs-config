
;; don't break parens with vi editing commands
(use-package lispyville
  :after lispy
  :config
  (add-hook 'lispy-mode-hook #'lispyville-mode))

;; strict indentation
(use-package aggressive-indent
  :after lispy
  :config
  (progn
    (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
    ;; (add-hook 'css-mode-hook #'aggressive-indent-mode)
    ))

;; C-k inserts digraphs?

;;           ~ ~ ~
;; ㄩㄩㄩ   ~ ~
;; いόい?  ~~
;;   o===ぽ
;;   ѫ

(use-package lispy

  :commands
  (lispy-mode)

  :bind (:map
         lispy-mode-map-special
         ("<S-backspace>" . lispy-kill)

         :map lispy-mode-map
         ("<C-backspace>" . lispy-backward-kill-word)

         :map emacs-lisp-mode-map
         ("s-\\ s-\\" . eval-last-sexp)
         ("s-j" . eval-last-sexp-and-replace)
         ("s-." . describe-function))

  :init
  (progn
    (defun eval-last-sexp-and-replace ()
      "Replace the preceding sexp with its value."
      (interactive)
      (backward-kill-sexp)
      (insert (current-kill 0))
      (insert "\n;; => ")
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
      (insert "\n\n"))

    (dolist (hook '(emacs-lisp-mode-hook))
      (add-hook hook (lambda () (lispy-mode 1))))))
