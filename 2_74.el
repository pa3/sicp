;; initial files of two divisions

(defvar file1 '(
                (tom 100 "Tom str. 10")
                (bob 200 "Bob str. 20")
                ))

(defvar file2 '(
                ((name jack) (salary 100) (address "Jack str. 10"))
                ((name john) (salary 200) (address "John str. 20"))
                ))

;; a.
;; Code that should be added by first division to support generic
;; `get-record' operation.

(defun install-file1-interface ()
  (defun get-record-f1 (name)
    (let ((records file1)
          found-record)
      (while (and (not found-record) records)
        (if (equal (caar records) name)
            (setq found-record (car records))
          (setq records (cdr records))))
      found-record))
  (put 'get-record 'file1 'get-record-f1))

;; Code that should be added by second division.

(defun install-file2-interface ()
  (defun name-f2 (record) (cadr (assoc 'name record)))
  (defun get-record-f2 (name)
    (let ((records file2)
          found-record)
      (while (and (not found-record) records)
        (if (equal (name-f2 (car records)) name)
            (setq found-record (car records))
          (setq records (cdr records))))
      found-record))
  (put 'get-record 'file2 'get-record-f2))


;; Code that should be used by headquarters to get record of specific
;; employee.

(install-file1-interface)
(install-file2-interface)
(defun get-record (file employee)
  (funcall (get 'get-record file) employee))


;; b.

;; Code in first division's files.

(defun install-file1-get-salary-query ()
  (defun salary-f1 (record)
    (cadr record))
  (defun get-salary-f1 (employee)
    (salary-f1 (get-record 'file1 employee)))
  (put 'get-salary 'file1 'get-salary-f1))

;; Code in second division's files.
(defun install-file2-get-salary-query ()
  (defun salary-f2 (record)
    (cadr (assoc 'salary record)))
  (defun get-salary-f2 (employee)
    (salary-f2 (get-record 'file2 employee)))
  (put 'get-salary 'file2 'get-salary-f2))

;; HQ code.

(install-file1-get-salary-query)
(install-file2-get-salary-query)
(defun get-salary (file employee)
  (funcall (get 'get-salary file) employee))

;; c.

(defun find-employee-record (files employee)
  (when files
    (or (get-record (car files) employee)
        (find-employee-record (cdr files) employee))))


;; d.
;; No changes to already writen code should be made. The only thing to
;; do is to add `get-salary' and `get-record' specific to incorporated
;; company.  



