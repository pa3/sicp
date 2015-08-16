; complex numbers installation
((lambda ()
   ; ... some other complex numbers related code
   (defun project-complex (n) (real-part n))
   (put-proc 'project '(complex) #'project-complex)))

; real numbers installation
((lambda ()
   ; ... 
   (defun project-real (n) (real->rational 10))
   (defun real->rational (real &optional max-steps)
     (let* ((int-part (floor real))
            (float-part (- real int-part))
            (steps (or max-steps 10)))
       (if (or (< (abs (- real int-part)) 0.0000001)
               (= steps 0))
           (make-rational-number int-part 1)
         (add (make-rational-number int-part 1)
              (div (make-rational-number 1 1)
                   (real->rational (/ 1.0 float-part) (1- steps)))))))
   (put-proc 'project '(real) #'project-real)))

; rational numbers installation
((lambda ()
   ; ...
   (defun project-rational (n) (round (/ (numer n) (denom n))))
   (put-proc 'project '(raional) #'project-rational)))

; rational numbers installation
((lambda ()
   ; ...
   (defun project-rational (n) (round (/ (numer n) (denom n))))
   (put-proc 'project '(raional) #'project-rational)))

(defun project (n) (apply-generic 'project n))
(defun can-be-projected? (n) (get-proc 'project (list (type-tag n))))

(defun drop (n)
  (if (and (can-be-projected? n)
           (equ? n (raise (project n))))
      (drop (project n))
    n))

(defun apply-generic (op &rest args)
  (let* ((type-tags (mapcar 'type-tag args))
         (proc (get-proc op type-tags)))
    (if proc
        (drop (apply proc (mapcar 'contents args)))
      (if (not (all-equal? type-tags))
          (apply 'apply-generic op (coerce-all-to-single args))
        (error "No method for these types %S" (list op type-tags))))))
