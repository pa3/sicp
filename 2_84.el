(defun raise-n-times (item times)
  (if (zerop times)
      item
    (raise-n-times (raise item) (-1 times))))

(defun level-from-top (type)
  (if (get-proc 'raise '(type))
      (1+ (level-from-top (raise type)))))

(defun coerce-all-to-single (args)
  (let* ((types (mapcar #'type-tag args))
         (levels-from-top (mapcar #'level-from-top types))
         (max-level (apply #'max level-from-top))
         (levels-to-raise (mapcar (lambda (n) (- n max-level)))))
    (mapcar* #'raise-n-times args levels-to-raise)))                          

(defun all-equal? (list)
  (remove-if-not (lambda (i) (equal (car list) i)) (cdr list)))

(defun apply-generic (op &rest args)
  (let* ((type-tags (mapcar 'type-tag args))
         (proc (get-proc op type-tags)))
    (if proc
        (apply proc (mapcar 'contents args))
      (if (not (all-equal? type-tags))
          (apply 'apply-generic op (coerce-all-to-single args))
        (error "No method for these types %S" (list op type-tags))))))
