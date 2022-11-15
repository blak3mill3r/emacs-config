(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function 'browse-url-chrome)
 '(evil-collection-mode-list
   '(2048-game ag alchemist anaconda-mode apropos arc-mode auto-package-update beginend bm bookmark
               (buff-menu "buff-menu")
               calc calendar cider cmake-mode comint company compile consult
               (custom cus-edit)
               cus-theme dashboard daemons deadgrep debbugs debug devdocs dictionary diff-hl diff-mode dired dired-sidebar disk-usage distel doc-view docker ebib edbi edebug ediff eglot explain-pause-mode elfeed elisp-mode elisp-refs elisp-slime-nav embark emms epa ert eshell eval-sexp-fu evil-mc eww fanyi finder flycheck flymake free-keys geiser ggtags git-timemachine gnus go-mode grep guix hackernews helm help helpful hg-histedit hungry-delete ibuffer image image-dired image+ imenu imenu-list
               (indent "indent")
               indium info ivy js2-mode leetcode log-edit log-view lsp-ui-imenu lua-mode kotlin-mode macrostep man magit magit-todos markdown-mode minibuffer monky mpdel mu4e mu4e-conversation neotree newsticker notmuch nov
               (occur replace)
               omnisharp org-present osx-dictionary outline p4
               (package-menu package)
               pass
               (pdf pdf-view)
               popup proced
               (process-menu simple)
               prodigy profiler python quickrun racer racket-describe realgud reftex restclient rg ripgrep rjsx-mode robe rtags ruby-mode scroll-lock selectrum sh-script shortdoc simple slime sly speedbar tab-bar tablist tabulated-list tar-mode telega
               (term term ansi-term multi-term)
               tetris thread tide timer-list transmission trashed tuareg typescript-mode vc-annotate vc-dir vc-git vdiff vertico view vlf vterm w3m wdired wgrep which-key woman xref xwidget yaml-mode youtube-dl zmusic
               (ztree ztree-diff)))
 '(evil-undo-system 'undo-tree nil nil "Customized with use-package evil")
 '(inhibit-startup-screen t)
 '(safe-local-variable-values
   '((eval progn
           (make-variable-buffer-local 'cider-jack-in-nrepl-middlewares)
           (add-to-list 'cider-jack-in-nrepl-middlewares "shadow.cljs.devtools.server.nrepl/middleware"))
     (eval define-clojure-indent
           (codepoint-case 'defun))
     (org-hugo-auto-export-on-save . t)
     (intero-stack-yaml . "/home/blake/w/nerdvana/xmonadsrc/stack.yaml")
     (haskell-process-use-ghci . t)
     (intero-targets "xmonad-blak3mill3r:exe:xmonad")))
 '(warning-suppress-types '((comp) (comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 89)) (:foreground "#839496" :background "#002b36"
                                              :weight normal :height 220
                                              :family "Inconsolata")))))
