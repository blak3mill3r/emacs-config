;; (use-package haskell-interactive-mode
;;   :commands (haskell-interactive-mode-clear)
;;   ;; :bind (:map haskell-interactive-mode-map
;;   ;;             )
;;   )

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

(use-package haskell-mode
  :mode ("\\.hs$" . haskell-mode)
  :general (:states '(normal)
            :keymaps 'haskell-mode-map
            "s-n"         'flycheck-next-error
            "s-p"         'flycheck-previous-error
            "s-/"         'flycheck-list-errors
            "s-]"         'haskell-mode-jump-to-def
            ;; ("s-b"         . flycheck-buffer)
            )
  :config
  (progn
    ;; (remove-hook 'haskell-mode-hook 'interactive-haskell-mode)
    ;; (remove-hook 'haskell-mode-hook 'stack-mode)
    ;; (add-hook 'haskell-mode-hook (lambda ()
    ;;                                (message "FUCK YOU INTERO")
    ;;                                ;; (message "here comes intero")
    ;;                                ;; (intero-mode)
    ;;                                ;; (message "intero done?")
    ;;                                ;; (interactive-haskell-mode)
    ;;                                ;; (message "interactive done?")
    ;;                                ;; (stack-mode)
    ;;                                ;; (haskell-auto-insert-module-template)

    ;;                                ;; (modify-syntax-entry ?> "w")
    ;;                                (modify-syntax-entry ?_ "w")
    ;;                                (modify-syntax-entry ?- "w")
    ;;                                ))
    ))

(use-package hindent
  :demand t
  )

;; (use-package haskell-doc
;;   :demand t)

;; (use-package haskell-process
;;   :mode haskell-process-mode
;;   :config (progn
;;             (setq haskell-process-type 'ghci)
;;             (setq haskell-process-path-ghci "stack")
;;             (setq haskell-process-use-ghci t)
;;             (setq haskell-process-args-ghci '("ghci" "--with-ghc" "intero" "--no-load" "--no-build"))

;;             (setq haskell-tags-on-save t)
;;             (setq haskell-process-suggest-remove-import-lines t)
;;             (setq haskell-process-auto-import-loaded-modules t)
;;             (setq haskell-process-log t)
;;             (setq haskell-process-suggest-hoogle-imports nil)
;;             (setq haskell-process-suggest-haskell-docs-imports t)
;;             ))

;; (require 'hindent)
                                        ;(require 'haskell-simple-indent)
;; (require 'haskell)

;; (require 'haskell-font-lock)
;; (require 'haskell-debug)
;; (require 'ghci-script-mode)

;; (setq haskell-process-type 'ghci)
;; (setq haskell-process-path-ghci "stack")
;; (setq haskell-process-use-ghci t)
;; (setq haskell-process-args-ghci '("ghci" "--with-ghc" "intero" "--no-load" "--no-build"))

;; (setq hindent-style "johan-tibell")

;; Functions

;; (defvar haskell-process-use-ghci nil)

;; (defun haskell-process-cabal-build-and-restart ()
;;   "Build and restart the Cabal project."
;;   (interactive)
;;   (intero-devel-reload))

;; (setq haskell-complete-module-preferred
;;       '("Data.ByteString"
;;         "Data.ByteString.Lazy"
;;         "Data.Conduit"
;;         "Data.Function"
;;         "Data.List"
;;         "Data.Map"
;;         "Data.Maybe"
;;         "Data.Monoid"
;;         "Data.Text"
;;         "Data.Ord"))

;; (setq haskell-session-default-modules
;;       '("Control.Monad.Reader"
;;         "Data.Text"
;;         "Control.Monad.Logger"))

;; (setq haskell-interactive-mode-eval-mode 'haskell-mode)

;; (setq haskell-process-path-ghci
;;       "ghci")

;; (setq haskell-process-args-ghci '("-ferror-spans"))

;; (setq haskell-process-args-cabal-repl
;;       '("--ghc-option=-ferror-spans" "--with-ghc=ghci-ng"))

;; (setq haskell-process-generate-tags nil)

;; (setq haskell-import-mapping
;;       '(("Data.Text" . "import qualified Data.Text as T
;; import Data.Text (Text)
;; ")
;;         ("Data.Text.Lazy" . "import qualified Data.Text.Lazy as LT
;; ")
;;         ("Data.ByteString" . "import qualified Data.ByteString as S
;; import Data.ByteString (ByteString)
;; ")
;;         ("Data.ByteString.Char8" . "import qualified Data.ByteString.Char8 as S8
;; import Data.ByteString (ByteString)
;; ")
;;         ("Data.ByteString.Lazy" . "import qualified Data.ByteString.Lazy as L
;; ")
;;         ("Data.ByteString.Lazy.Char8" . "import qualified Data.ByteString.Lazy.Char8 as L8
;; ")
;;         ("Data.Map" . "import qualified Data.Map.Strict as M
;; import Data.Map.Strict (Map)
;; ")
;;         ("Data.StrMap" . "import Data.StrMap as StrMap
;; import Data.StrMap (StrMap)
;; ")
;;         ("Data.Map.Strict" . "import qualified Data.Map.Strict as M
;; import Data.Map.Strict (Map)
;; ")
;;         ("Data.Set" . "import qualified Data.Set as S
;; import Data.Set (Set)
;; ")
;;         ("Data.Vector" . "import qualified Data.Vector as V
;; import Data.Vector (Vector)
;; ")
;;         ("Data.Vector.Storable" . "import qualified Data.Vector.Storable as SV
;; import Data.Vector (Vector)
;; ")
;;         ("Data.Conduit.List" . "import qualified Data.Conduit.List as CL
;; ")
;;         ("Data.Conduit.Binary" . "import qualified Data.Conduit.Binary as CB
;; ")))

;; (setq haskell-language-extensions '())

;; Add hook





;; Keybindings

;; (define-key haskell-mode-map (kbd "C-c i") 'hindent/reformat-decl)
;; (define-key haskell-mode-map [f8] 'haskell-navigate-imports)

;; (define-key haskell-mode-map (kbd "<space>") 'haskell-mode-contextual-space)

;; (define-key haskell-cabal-mode-map [f9] 'haskell-interactive-mode-visit-error)
;; (define-key haskell-cabal-mode-map [f11] 'haskell-process-cabal-build)
;; (define-key haskell-cabal-mode-map [f12] 'haskell-process-cabal-build-and-restart)
;; (define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
;; (define-key haskell-cabal-mode-map [?\C-c ?\C-z] 'haskell-interactive-switch)
;; (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;; (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
;; (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)

;; (define-key haskell-interactive-mode-map (kbd "C-c C-v") 'haskell-interactive-toggle-print-mode)
;; (define-key haskell-interactive-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
;; (define-key haskell-interactive-mode-map [f9] 'haskell-interactive-mode-visit-error)
;; (define-key haskell-interactive-mode-map [f11] 'haskell-process-cabal-build)
;; (define-key haskell-interactive-mode-map [f12] 'haskell-process-cabal-build-and-restart)
;; (define-key haskell-interactive-mode-map (kbd "C-<left>") 'haskell-interactive-mode-error-backward)
;; (define-key haskell-interactive-mode-map (kbd "C-<right>") 'haskell-interactive-mode-error-forward)
;; (define-key haskell-interactive-mode-map (kbd "C-c c") 'haskell-process-cabal)


;; (defun haskell-insert-operator ()
;;   (interactive)
;;   (insert ()))

;; (defun haskell-process-all-types ()
;;   "List all types in a grep-mode buffer."
;;   (interactive)
;;   (let ((session (haskell-session)))
;;     (switch-to-buffer (get-buffer-create (format "*%s:all-types*"
;;                                                  (haskell-session-name (haskell-session)))))
;;     (setq haskell-session session)
;;     (cd (haskell-session-current-dir session))
;;     (let ((inhibit-read-only t))
;;       (erase-buffer)
;;       (let ((haskell-process-log nil))
;;         (insert (haskell-process-queue-sync-request (haskell-process) ":all-types")))
;;       (unless (eq major-mode  'compilation-mode)
;;         (compilation-mode)
;;         (setq compilation-error-regexp-alist
;;               haskell-compilation-error-regexp-alist)))))

;; (defun haskell-process-toggle-import-suggestions ()
;;   (interactive)
;;   (setq haskell-process-suggest-remove-import-lines (not haskell-process-suggest-remove-import-lines))
;;   (message "Import suggestions are now %s." (if haskell-process-suggest-remove-import-lines
;;                                                 "enabled"
;;                                               "disabled")))

;; (defvar haskell-stack-commands
;;   '("build"
;;     "update"
;;     "test"
;;     "bench"
;;     "install")
;;   "Stack commands.")

;;;###autoload
;; (defun haskell-process-stack-build ()
;;   "Build the Stack project."
;;   (interactive)
;;   (haskell-process-do-stack "build")
;;   (haskell-process-add-cabal-autogen))

;;;###autoload
;; (defun haskell-process-stack (p)
;;   "Prompts for a Stack command to run."
;;   (interactive "P")
;;   (if p
;;       (haskell-process-do-stack
;;        (read-from-minibuffer "Stack command (e.g. install): "))
;;     (haskell-process-do-stack
;;      (funcall haskell-completing-read-function "Stack command: "
;;               (append haskell-stack-commands
;;                       (list "build --ghc-options=-fforce-recomp")
;;                       (list "build --ghc-options=-O0"))))))

;; (defun haskell-process-do-stack (command)
;;   "Run a Cabal command."
;;   (let ((process (haskell-interactive-process)))
;;     (cond
;;      ((let ((child (haskell-process-process process)))
;;         (not (equal 'run (process-status child))))
;;       (message "Process is not running, so running directly.")
;;       (shell-command (concat "stack " command)
;;                      (get-buffer-create "*haskell-process-log*")
;;                      (get-buffer-create "*haskell-process-log*"))
;;       (switch-to-buffer-other-window (get-buffer "*haskell-process-log*")))
;;      (t (haskell-process-queue-command
;;          process
;;          (make-haskell-command
;;           :state (list (haskell-interactive-session) process command 0)

;;           :go
;;           (lambda (state)
;;             (haskell-process-send-string
;;              (cadr state)
;;              (format ":!stack %s"
;;                      (cl-caddr state))))

;;           :live
;;           (lambda (state buffer)
;;             (let ((cmd (replace-regexp-in-string "^\\([a-z]+\\).*"
;;                                                  "\\1"
;;                                                  (cl-caddr state))))
;;               (cond ((or (string= cmd "build")
;;                          (string= cmd "install"))
;;                      (haskell-process-live-build (cadr state) buffer t))
;;                     (t
;;                      (haskell-process-cabal-live state buffer)))))

;;           :complete
;;           (lambda (state response)
;;             (let* ((process (cadr state))
;;                    (session (haskell-process-session process))
;;                    (message-count 0)
;;                    (cursor (haskell-process-response-cursor process)))
;;               (haskell-process-set-response-cursor process 0)
;;               (while (haskell-process-errors-warnings session process response)
;;                 (setq message-count (1+ message-count)))
;;               (haskell-process-set-response-cursor process cursor)
;;               (let ((msg (format "Complete: cabal %s (%s compiler messages)"
;;                                  (cl-caddr state)
;;                                  message-count)))
;;                 (haskell-interactive-mode-echo session msg)
;;                 (when (= message-count 0)
;;                   (haskell-interactive-mode-echo
;;                    session
;;                    "No compiler messages, dumping complete output:")
;;                   (haskell-interactive-mode-echo session response))
;;                 (haskell-mode-message-line msg)
;;                 (when (and haskell-notify-p
;;                            (fboundp 'notifications-notify))
;;                   (notifications-notify
;;                    :title (format "*%s*" (haskell-session-name (car state)))
;;                    :body msg
;;                    :app-name (cl-ecase (haskell-process-type)
;;                                ('ghci haskell-process-path-cabal)
;;                                ('cabal-repl haskell-process-path-cabal)
;;                                ('cabal-ghci haskell-process-path-cabal))
;;                    :app-icon haskell-process-logo)))))))))))

;; (define-key interactive-haskell-mode-map (kbd "C-c C-c") 'haskell-process-stack-build)
;; (define-key interactive-haskell-mode-map (kbd "C-c c") 'haskell-process-stack)

;; (setq flycheck-check-syntax-automatically '(save idle-change new-line mode-enabled))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defun haskell-capitalize-module (m)
;;   ;; FIXME:
;;   (with-temp-buffer
;;     (insert m)
;;     (upcase-initials-region (point-min) (point-max))
;;     (buffer-string)))

;; (defvar haskell-fast-module-list
;;   (list)
;;   "A list of modules.")

;; (defun haskell-fast-modules-save ()
;;   (interactive))

;; (defun haskell-fast-modules-load ()
;;   (interactive))

;; (defun haskell-modules-list ()
;;   (let* ((stack-root (intero-project-root))
;;          (modules
;;           (split-string
;;            (concat (shell-command-to-string (format "find %s -name '*.cabal' | for i in $(cat /dev/stdin/); do cabal-info --cabal-file $i exposed-modules; done" stack-root))
;;                    (shell-command-to-string "cat ~/.haskell-modules.hs")
;;                    )
;;            "\n" t)))
;;     modules))

;; (defun haskell-fast-get-import (custom)
;;   (if custom
;;       (let* ((module (haskell-capitalize-module (read-from-minibuffer "Module: " ""))))
;;         (shell-command-to-string (format "echo %S >> ~/.haskell-modules.hs" module))
;;         module)
;;     (let ((module (haskell-capitalize-module
;;                    (haskell-complete-module-read
;;                     "Module: "
;;                     (append (mapcar #'car haskell-import-mapping)
;;                             (haskell-modules-list))))))
;;       (unless (member module haskell-fast-module-list)
;;         (add-to-list 'haskell-fast-module-list module)
;;         (haskell-fast-modules-save))
;;       module)))

;; (defun haskell-fast-add-import (custom)
;;   "Add an import to the import list.  Sorts and aligns imports,
;; unless `haskell-stylish-on-save' is set, in which case we defer
;; to stylish-haskell."
;;   (interactive "P")
;;   (save-excursion
;;     (goto-char (point-max))
;;     (haskell-navigate-imports)
;;     (let* ((chosen (haskell-fast-get-import custom))
;;            (module (let ((mapping (assoc chosen haskell-import-mapping)))
;;                      (if mapping
;;                          (cdr mapping)
;;                        (concat "import " chosen "\n")))))
;;       (insert module))
;;     (haskell-sort-imports)
;;     (haskell-align-imports)))

;; (define-key haskell-mode-map (kbd "C-i") 'haskell-fast-add-import)

;; (define-key intero-mode-map [f12] 'intero-devel-reload)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Expression watching support for intero

;; (defvar intero-watch-expression "parseFunction \"\\\\x -> if 5>=x then 0 else 1\"")
;; (defun intero-watch-expression (string)
;;   (interactive "sEnter an expression: ")
;;   (setq intero-watch-expression string)
;;   (flycheck-buffer))
;; (defun intero-watch-expression-hook ()
;;   (interactive)
;;   (when intero-watch-expression
;;     (run-with-idle-timer
;;      0.0
;;      nil
;;      (lambda ()
;;        (when (eq major-mode 'haskell-mode)
;;          (let* ((result
;;                  (replace-regexp-in-string "\n$" ""  (intero-fontify-expression
;;                                                       (intero-blocking-call 'backend intero-watch-expression))))
;;                 (msg
;;                  (format
;;                   "> %s\n\n%s"
;;                   (intero-fontify-expression intero-watch-expression)
;;                   result)))
;;            (unless (string-match "<interactive>:[0-9]+:[0-9]+: Not in scope: " result)
;;              (with-current-buffer (get-buffer-create "*Intero-Watch*")
;;                (erase-buffer)
;;                (insert msg)
;;                (goto-char (point-min))))))))))
;; (remove-hook 'flycheck-after-syntax-check-hook 'intero-watch-expression-hook)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; (define-key flycheck-mode-map (kbd "C-v C-v") 'flycheck-buffer)


;; (define-key haskell-mode-map [f6] (lambda () (interactive) (compile "stack test")))

;; (haskell-fast-modules-load)

;; (define-key purescript-mode-map [f5]
;;   (lambda ()
;;     (interactive)
;;     (compile "cd .. && stack exec purify")))


;; (add-hook 'purescript-mode 'psc-ide-mode)
;; (define-key shm-map (kbd "C-i") 'haskell-fast-add-import)
;; (define-key shm-map (kbd "<tab>") 'shm/tab)
;; (define-key haskell-mode-map (kbd "C-c C-d") 'haskell-w3m-open-haddock)
;; (define-key shm-repl-map (kbd "TAB") 'shm-repl-tab)
;; (define-key shm-map (kbd "C-c C-p") 'shm/expand-pattern)
;; (define-key shm-map (kbd ",") 'shm-comma-god)
;; (define-key shm-map (kbd "C-c C-s") 'shm/case-split)
;; (define-key shm-map (kbd "SPC") 'shm-contextual-space)
;; (define-key shm-map (kbd "C-\\") 'shm/goto-last-point)
;; (define-key shm-map (kbd "C-c C-f") 'shm-fold-toggle-decl)
;; (define-key shm-map (kbd "C-c i") 'shm-reformat-decl)

;; (define-key ide-backend-mode-map [f5] 'ide-backend-mode-load)
;; (setq ide-backend-mode-cmd "cabal")
;; (define-key haskell-mode-map (kbd "C-<return>") 'haskell-simple-indent-newline-indent)
;; (define-key haskell-mode-map (kbd "C-<right>") 'haskell-move-right)
;; (define-key haskell-mode-map (kbd "C-<left>") 'haskell-move-left)
;; (define-key highlight-uses-mode-map (kbd "C-t") 'highlight-uses-mode-replace)

;; (define-key ghci-script-mode-map (kbd "C-`") 'haskell-interactive-bring)
;; (define-key ghci-script-mode-map (kbd "C-c C-l") 'ghci-script-mode-load)
;; (define-key ghci-script-mode-map [f5] 'ghci-script-mode-load)
;; (define-key ghci-script-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;; (define-key ghci-script-mode-map (kbd "C-c c") 'haskell-process-cabal)

;; (define-key interactive-haskell-mode-map [f5] 'haskell-process-load-or-reload)
;; (define-key interactive-haskell-mode-map [f12] 'turbo-devel-reload)
;; (define-key interactive-haskell-mode-map [f12] 'haskell-process-cabal-build-and-restart)


;; GOOD: ?
;; (define-key interactive-haskell-mode-map (kbd "M-,") 'haskell-who-calls)
;; (define-key interactive-haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
;; (define-key interactive-haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
;; (define-key interactive-haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
;; (define-key interactive-haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
;; (define-key interactive-haskell-mode-map (kbd "M-.") 'haskell-mode-goto-loc)
;; (define-key interactive-haskell-mode-map (kbd "C-?") 'haskell-mode-find-uses)
;; (define-key interactive-haskell-mode-map (kbd "C-c C-t") 'haskell-mode-show-type-at)

















;; (custom-set-variables
;;  '(haskell-process-type 'cabal-repl)
;;  '(haskell-process-args-ghci '())
;;  '(haskell-notify-p t)
;;  '(haskell-stylish-on-save t)
;;  '(haskell-process-reload-with-fbytecode nil)
;;  '(haskell-process-use-presentation-mode t)
;;  '(haskell-interactive-mode-include-file-name nil)
;;  '(haskell-interactive-mode-eval-pretty nil)
;;  '(haskell-process-do-cabal-format-string ":!cd %s && unset GHC_PACKAGE_PATH && %s")
;;  '(haskell-process-show-debug-tips nil)
;;  '(hindent-style "chris-done"))
