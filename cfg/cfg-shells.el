(defun launch-sql-shell
    (product connection)
  (setq sql-product product)
  (sql-connect connection))

(defun sql-iris-prod () (interactive) (launch-sql-shell 'mysql 'iris-prod))

(general-define-key
 :states '(normal)
 :prefix ","
 "sp" 'sql-iris-prod)
