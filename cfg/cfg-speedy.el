;; https://www.youtube.com/watch?v=ygE01sOhzz0

;; this is so juicy

(defun rename-server (name)
  "Restart the emacs server listening on a new socket based on the name in ~/.emacs.d/.switch-to-socket
  For use with a freshly restored CRIU image of a clean-slate emacs --daemon process."
  (setq server-name name)
  (message server-name)
  (server-start nil t))

(defun kill-emacs-when-last-frame-is-deleted (frame)
  "Each time a frame is deleted, if there are no more frames, kill emacs."
  (when (null (frame-list)) (kill-emacs)))

(add-to-list 'delete-frame-functions #'kill-emacs-when-last-frame-is-deleted)

;; since that is only called when a frame is deleted
;; it will not kill emacs when launched with --daemon for a CRIU checkpoint
