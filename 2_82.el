;; Following strategy is not sufficiently general because it will fail
;; to perform operation even when there is possibility to do
;; so. It will happen because algorithm will try the first existing
;; possible coercion and not all of them. For instance if we have
;; operation defined only for '(type1 type1) and we have both coercion
;; operations from type1 to type2 and from type2 to type1 then when
;; this operation is invoked with arguments of '(type2 type1)
;; algorithm will convert both to type2 and will try to invoke
;; operation with it which will fail. 

(load-file "2_77_generic_arithmetic.el")

(defun coerce (item type)
  (let ((item-type (type-tag item)))
    (if (eq item-type type)
        item
      (funcall (get-coercion item-type type) item))))

(defun coerce-all (items type)
  (mapcar (lambda (i) (coerce i type)) items))

(defun find-type-to-coerce-to (types)
  (car (remove-if 'null 
                  (mapcar (lambda (type) (if (can-be-coerced? types type) type nil))
                          types))))

(defun can-be-coerced? (types coerce-to)
  (not (memq nil
             (mapcar (lambda (type) (or (eq type coerce-to) (get-coercion type coerce-to)))
                     types))))

(defun all-equal? (list)
  (remove-if-not (lambda (i) (equal (car list) i)) (cdr list)))

(defun apply-generic (op &rest args)
  (let* ((type-tags (mapcar 'type-tag args))
         (proc (get-proc op type-tags)))
    (if proc
        (apply proc (mapcar 'contents args))
      (let ((type (find-type-to-coerce-to type-tags)))
        (if (and type (not (all-equal? type-tags)))
            (apply 'apply-generic op (coerce-all args type))
          (error "No method for these types %S" (list op type-tags)))))))
