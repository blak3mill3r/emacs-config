;; install relevant go packages
;;
;; go get github.com/nsf/gocode
;; go get github.com/rogpeppe/godef
;; go get golang.org/x/tools/cmd/goimports
;; go get golang.org/x/tools/cmd/guru
;; go get golang.org/x/tools/cmd/gorename

(use-package go-mode
  :demand t
  :config
  (add-hook 'go-mode-hook (lambda () (add-hook 'before-save-hook 'gofmt-before-save nil 'local)))

  :general
  (:states '(normal)
   :keymaps 'go-mode-map
   "s-]" 'godef-jump
   "s-[" 'pop-tag-mark))

(use-package go-rename
  :demand t
  :general
  (:keymaps 'go-mode-map
   :states '(normal insert visual)
   "s-r" 'go-rename))

(use-package go-guru
  :demand t
  :config
  (go-guru-hl-identifier-mode))

(use-package flycheck
  :demand t
  :commands 'flycheck-mode)

(use-package company-go
  :demand t
  :general
  (:keymaps '(go-mode-map)
   ;; reintroduce these without breaking ,
   ;; ",,gd"        'go-goto-docstring
   ;; ",,gi"        'go-import-add
   "s-<return>"  'compile
   "s-]"         'godef-jump
   "s-["         'pop-tag-mark
   "s-/"         'godoc-at-point
   "s-j"         'go-goto-function-name
   "s-k"         'go-goto-arguments
   "s-l"         'go-goto-return-values
   "s-i"         'go-goto-imports
   "s-."         'go-guru-expand-region
   "s-g s-]"     'go-guru-callers
   "s-g s-["     'go-guru-callees
   "s-g s-\\"    'go-guru-callstack
   "s-g s-i"     'go-guru-implements
   "s-g s-p"     'go-guru-peers
   "s-g s-r"     'go-guru-referrers
   "s-g s-o"     'go-guru-pointsto
   "s-g s-f"     'go-guru-freevars
   "s-g s-d"     'go-guru-describe
   "s-n"         'flycheck-next-error
   "s-p"         'flycheck-previous-error)

  :init
  (progn
    (add-hook 'go-mode-hook #'go-guru-hl-identifier-mode)
    (add-hook 'go-mode-hook #'flycheck-mode)
    (add-hook 'go-mode-hook (lambda ()
                              (set (make-local-variable 'company-backends) '(company-go))
                              (company-mode)
                              (flycheck-mode)
                              (if (not (string-match "go" compile-command))
                                  (set (make-local-variable 'compile-command)
                                       "go build -v && go test -v && go tool vet -composites=false ."))
                              (setq tab-width 3)))
    (add-hook 'before-save-hook 'gofmt-before-save)
    (setq gofmt-command "goimports")))

(provide 'cfg-go)
;;; config-go.el ends here
