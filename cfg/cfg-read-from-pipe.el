(defun mkfifo (fifo-name)
  (call-process "mkfifo" nil nil nil fifo-name))

(defun ensure-fifo (fifo-name)
  (when (not (file-exists-p fifo-name))
    (mkfifo fifo-name)))

(defun fifo-for-pid (pid)
  (let ((dir (concat user-emacs-directory ".pipe-into-emacs/pipes/")))
    (make-directory dir t)
    (expand-file-name (concat dir (number-to-string pid)))))

(defun fifo-for-pid-ack (pid)
  (let ((dir (concat user-emacs-directory ".pipe-into-emacs/pipes/")))
    (make-directory dir t)
    (expand-file-name (concat dir (number-to-string pid) "-ack"))))

(defun read-fifo (pid)
  "Read from the named pipe for pid, and return a string"
  (let ((fifo (fifo-for-pid pid)))
    ;; alternative from https://groups.google.com/forum/#!topic/gnu.emacs.help/UCv3pCRqtlw
    ;; (call-process "/bin/cat" fifo t t)
    (with-temp-buffer
      (insert-file-contents (fifo-for-pid pid))
      (buffer-string))))



(defun eval-read-fifo (pid)
  (condition-case nil
      (let ((s (read-fifo pid)))
        ;; (set-buffer "shit")
        ;; (end-of-buffer)
        ;; (insert s)
        (message "Received ELISP to read & eval:")
        (message s)
        (eval (read s)))
    ((debug error) nil)
    ;; (error (ack (emacs-pid) ":fail\n"))
    ))

(defun ack (emacs-pid response)
  (with-temp-buffer
    (insert response)
    (append-to-file (point-min) (point-max) (fifo-for-pid-ack emacs-pid))))

(defun eval-read-fifo-for-my-pid ()
  "Read elisp from the named pipe for this emacs instance's pid, and eval it"
  (interactive)
  (eval-read-fifo (emacs-pid))
  (ack (emacs-pid) ":ok\n"))

(ensure-fifo (fifo-for-pid     (emacs-pid)))
(ensure-fifo (fifo-for-pid-ack (emacs-pid)))
(define-key special-event-map [sigusr1] #'eval-read-fifo-for-my-pid)
