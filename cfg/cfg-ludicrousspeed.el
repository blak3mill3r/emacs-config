;; https://www.youtube.com/watch?v=ygE01sOhzz0

;; this is so juicy

(defun rename-server (name)
  "Restart the emacs server listening on a new socket with the provided name.
  For use with a freshly restored CRIU image of a clean-slate emacs --daemon process."
  (setq server-name name)
  (message server-name)
  (server-start nil t))

(defun kill-emacs-when-last-frame-is-deleted (frame)
  "Each time a frame is deleted, if there are no more frames, kill emacs."
  ;; there is a "terminal frame" when started with --daemon
  ;; have to account for that... what I want is: if there are no more frames visible NOT including the terminal frame (which is really not visible)
  ;; then exit emacs gracefully cleaning up desktop lock files and so on...
  (when (= 1 (cl-count-if (lambda (f)
                            (not (null (frame-parameter f 'display))))
                          (visible-frame-list)))
    ;; for some reason if I immediately invoke kill-emacs
    ;; then I get dangling desktop lock files
    ;; regardless of the order of this fn in the delete-frame-functions list
    ;; but if I defer killing emacs with run-at-time, then it works
    (run-at-time "0.1" nil (lambda () (kill-emacs)))))

;; this is called by the ludicrousspeed/bin/clone-one script
(defun prepare-to-die ()
  (add-to-list 'delete-frame-functions #'kill-emacs-when-last-frame-is-deleted t))

;; since that is only called when a frame is deleted
;; it will not kill emacs when launched with --daemon for a CRIU checkpoint
