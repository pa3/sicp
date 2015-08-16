;; a. the programm will loop forever, because it will try to
;; apply-generic on two complex numbers over and over again.

;; b. bacically apply-generic will work correctly if no one will
;; do what was done in section a. of this excersise, namely give a
;; coercion from the type to itself. As designers of library which
;; will be used by other developers it's nice to prevent this kind of
;; failure.

;; c. robust solution:

(load-file "2_77_generic_arithmetic.el")

(defun apply-generic (op &rest args)
  (let* ((type-tags (mapcar 'type-tag args))
         (proc (get-proc op type-tags)))
    (cond (proc (apply proc (mapcar 'contents args)))
          ((and (= (length args) 2) (not (eq (car type-tags) (cadr type-tags))))
            (let* ((type1 (car type-tags))
                   (type2 (cadr type-tags))
                   (a1 (car args))
                   (a2 (cadr args))
                   (t1->t2 (get-coercion type1 type2))
                   (t2->t1 (get-coercion type2 type1)))
              (cond (t1->t2
                     (apply-generic op (funcall t1->t2 a1) a2))
                    (t2->t1
                     (apply-generic op a1 (funcall t2->t1 a2)))
                    (t (error "No method for these types %S" (list op type-tags))))))
           (t (error "No method for these types %S" (list op type-tags))))))

(setq coercion-table (make-hash-table))

(defun get-coercion (type1 type2)
  (gethash type2 (gethash type1 coercion-table)))
(defun put-coercion (type1 type2 proc)
  (unless (gethash type1 coercion-table)
    (puthash type1 (make-hash-table :test 'equal) coercion-table))
  (puthash type2 proc (gethash type1 coercion-table))) 

(put-coercion 'complex 'complex (lambda (n) n))

(defun exp (x y) (apply-generic 'exp x y))
(put-proc 'exp '(lisp-number lisp-number) (lambda (x y) (cons 'lisp-number (expt x y))))
