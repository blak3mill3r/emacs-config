(use-package cquery
  :init
  (setq cquery-executable  "/home/blake/src/cquery/build/release/bin/cquery"))

(use-package yasnippet-snippets
  :init
  (yas-load-directory (concat user-emacs-directory "/straight/repos/yasnippet-snippets/snippets")))

(use-package yasnippet
  :after yasnippet-snippets)

(use-package lsp-mode)

(defun cquery//enable ()
  (condition-case nil
      (lsp-cquery-enable)
    (user-error nil)))

(use-package cquery
  :commands lsp-cquery-enable
  :init
  (add-hook 'c-mode-hook #'cquery//enable)
  (add-hook 'c++-mode-hook #'cquery//enable)
  (setq cquery-project-roots '("~/w/iris/iris-aces-client-universal" ))
  :config
  (with-eval-after-load 'projectile
    (setq projectile-project-root-files-top-down-recurring
          (append '("compile_commands.json"
                    ".cquery")
                  projectile-project-root-files-top-down-recurring))))

(add-hook 'c-mode-hook #'yas-minor-mode)
(add-hook 'cc-mode-hook #'yas-minor-mode)
(add-hook 'c++-mode-hook #'yas-minor-mode)


(use-package company-lsp
  :config
  (setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)
  (setq cquery-extra-init-params '(:completion (:detailedLabel t)))
  (setq-local company-backends
              (add-to-list 'company-backends 'company-lsp))) 
