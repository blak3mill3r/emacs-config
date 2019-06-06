(use-package cquery
  :init
  (setq cquery-executable  "/home/blake/src/cquery/build/release/bin/cquery"))

(use-package yasnippet-snippets
  :init
  (yas-load-directory (concat user-emacs-directory "/straight/repos/yasnippet-snippets/snippets")))

(use-package yasnippet
  :after yasnippet-snippets)

(use-package function-args
  :config
  (fa-config-default))


;; (use-package lsp-mode)

;; (defun cquery//enable ()
;;   (condition-case nil
;;       (lsp-cquery-enable)
;;     (user-error nil)))

;; (use-package cquery
;;   :commands lsp-cquery-enable
;;   :init
;;   (add-hook 'c-mode-hook #'cquery//enable)
;;   (add-hook 'c++-mode-hook #'cquery//enable)
;;   (setq cquery-project-roots '("~/w/iris/iris-aces-client-universal" ))
;;   :config
;;   (with-eval-after-load 'projectile
;;     (setq projectile-project-root-files-top-down-recurring
;;           (append '("compile_commands.json"
;;                     ".cquery")
;;                   projectile-project-root-files-top-down-recurring))))

(add-hook 'c-mode-hook #'yas-minor-mode)
(add-hook 'cc-mode-hook #'yas-minor-mode)
(add-hook 'c++-mode-hook #'yas-minor-mode)


(use-package company-lsp
  :config
  (setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)
  (setq cquery-extra-init-params '(:completion (:detailedLabel t)))
  (setq-local company-backends
              (add-to-list 'company-backends 'company-lsp))) 

;;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; the following complains about finder-inf.elc being empty... wtf
;;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;; (use-package irony)
;; (use-package flycheck-irony
;;   :after flycheck
;;   :hook '(cc-mode . flycheck-mode)
;; 
;;   :config
;;   (add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
;; (use-package irony-eldoc
;;   )
;;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

;; http://tsengf.blogspot.com/2011/06/semantic-ia-fast-jump-doesnt-push-tag.html
(require 'etags)
(unless (fboundp 'push-tag-mark)
  (defun push-tag-mark ()
    "Push the current position to the ring of markers so that
    \\[pop-tag-mark] can be used to come back to current position."
    (interactive)
    (ring-insert find-tag-marker-ring (point-marker))
    )
  )

(defun ciao-goto-symbol ()
  (interactive)
  (deactivate-mark)
  (ring-insert find-tag-marker-ring (point-marker))
  (or (and (require 'rtags nil t)
           (rtags-find-symbol-at-point))
      (and (require 'semantic/ia)
           (condition-case nil
               (semantic-ia-fast-jump (point))
             (error nil)))))

(general-define-key
 :states '(normal)
 :keymaps '( c++-mode-map c-mode )
 "s-]" 'ciao-goto-symbol
 "s-[" 'pop-tag-mark)
