
(defun sh-eval-region-and-comment
    ()
  (interactive)
  (let ((whatever (shell-command-to-string (buffer-substring-no-properties (mark) (point)))))
    (insert "\n: '''\n")
    (insert whatever)
    (insert "\n'''")))

(defun sh-eval-line-and-comment
    ()
  (interactive)
  (message (thing-at-point 'line t))
  (let ((whatever (shell-command-to-string (thing-at-point 'line t))))
    (insert "\n: '''")
    (insert whatever)
    (insert "\n'''")))

(defun sh-eval-line
    ()
  (interactive)
  (message (thing-at-point 'line t))
  (let ((whatever (shell-command-to-string (thing-at-point 'line t))))
    (message whatever)))

(general-define-key
 :keymaps 'sh-mode-map
 "s-\\ s-\\" 'sh-eval-line
 "s-j" 'sh-eval-line-and-comment
 )
