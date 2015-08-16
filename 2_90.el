;;; -*-lexical-binding: t;-*-


(load-file "2_79.el")
(load-file "2_80.el")

(defun content (data) (cdr data))
(defun make-poly (variable term-list)
  (funcall (get-proc 'make 'polynomial) variable term-list))

;; install polynomial package
((lambda ()
   (defun -make-poly (variable term-list) (cons variable term-list))
   (defun -variable (p) (car p))
   (defun -term-list (p) (cdr p))
   (defun -add-poly (p1 p2)
     (if (equal (-variable p1) (-variable p2))
         (-make-poly (-variable p1)
                     (-add-terms (-term-list p1) (-term-list p2)))
       (error "Polys not in same var: ADD-POLY" (list p1 p2))))
   (defun -mul-poly (p1 p2)
     (if (equal (-variable p1) (-variable p2))
         (make-poly (-variable p1)
                    (-mul-terms (-term-list p1) (-term-list p2)))
       (error "Polys not in same var: MUL-POLY" (list p1 p2))))
   (defun -mul-terms (L1 L2)
     (if (empty-termlist? L1)
         (the-empty-termlist L1)
       (-add-terms (-mul-term-by-all-terms (first-term L1) L2)
                   (-mul-terms (rest-terms L1) L2))))
   (defun -mul-term-by-all-terms (t1 L)
     (if (empty-termlist? L)
         (the-empty-termlist L)
       (let ((t2 (first-term L)))
         (adjoin-term
          (make-term (+ (order t1) (order t2))
                     (mul (coeff t1) (coeff t2)))
          (-mul-term-by-all-terms t1 (rest-terms L))))))
   (defun -add-terms (L1 L2)
     (cond ((empty-termlist? L1) L2)
           ((empty-termlist? L2) L1)
           (t (let ((t1 (first-term L1))
                    (t2 (first-term L2)))
                (cond ((> (order t1) (order t2))
                       (adjoin-term
                        t1 (-add-terms (rest-terms L1) L2)))
                      ((< (order t1) (order t2))
                       (adjoin-term
                        t2 (-add-terms L1 (rest-terms L2))))
                      (t
                       (adjoin-term
                        (make-term (order t1)
                                   (add (coeff t1) (coeff t2)))
                        (-add-terms (rest-terms L1)
                                    (rest-terms L2)))))))))
   ;; interface to rest of the system
   (let ((tag (lambda (p) (cons 'polynomial p))))
     (put-proc 'add '(polynomial polynomial)
               (lambda (p1 p2) (funcall tag (-add-poly p1 p2))))
     (put-proc 'mul '(polynomial polynomial)
               (lambda (p1 p2) (funcall tag (-mul-poly p1 p2))))
     (put-proc 'make 'polynomial
               (lambda (var terms) (funcall tag (-make-poly var terms))))
     'done)))

;; term interface
(defun make-term (order coeff) (cons 'term (list order coeff)))
(defun order (term) (car term))
(defun coeff (term) (cadr term))

;; term-list interface
(defun adjoin-term (term term-list) (apply-generic 'adjoin-term term term-list))
(defun first-term (term-list) (apply-generic 'first-term term-list))
(defun the-empty-termlist (of-type) (apply-generic 'the-empty-termlist of-type))
(defun rest-terms (term-list) (apply-generic 'rest-terms term-list))
(defun empty-termlist? (term-list) (apply-generic 'empty-termlist? term-list))

;; install sparse polynomials package
((lambda ()
   (let ((tag (lambda (p) (cons 'sparse-polynomial p))))
     (put-proc 'adjoin-term '(term sparse-polynomial) (lambda (term term-list) (funcall tag
                                                                                   (if (=zero? (coeff term))
                                                                                       term-list
                                                                                     (cons (coef term) term-list)))))
     (put-proc 'first-term '(sparse-polynomial) (lambda (term-list) (car term-list)))
     (put-proc 'the-empty-termlist '(sparse-polynomial) (lambda (of-type) (funcall tag '())))
     (put-proc 'rest-terms '(sparse-polynomial) (lambda (term-list) (funcall tag (cdr term-list))))
     (put-proc 'empty-termlist? '(sparse-polynomial) (lambda (term-list) (null term-list))))))


(defun make-sparse-term-list (terms) (cons 'sparse-polynomial terms))
(defun make-dense-term-list (coeffs) (cons 'dense-polynomial coeffs))

;; install dense polynomials package
((lambda ()
   (defun untagged-adjoin (term term-list)
     (let ((order-of-term-list (max 0 (1- (length term-list)))))
       (cond ((> order-of-term-list (order term)) (cons (car term-list) (untagged-adjoin term (cdr term-list))))
             ((= order-of-term-list (order term)) (cons (coeff term) (cdr term-list)))
             ((< order-of-term-list (order term)) (untagged-adjoin term (cons 0 term-list))))))
   (let ((tag (lambda (p) (cons 'dense-polynomial p))))
     (put-proc 'adjoin-term '(term dense-polynomial) (lambda (term term-list) (funcall tag (untagged-adjoin term term-list))))
     (put-proc 'first-term  '(dense-polynomial) (lambda (term-list) (make-term (1- (length term-list)) (car term-list) )))
     (put-proc 'the-empty-termlist '(dense-polynomial) (lambda (of-type) (funcall tag '())))
     (put-proc 'rest-terms '(dense-polynomial) (lambda (term-list) (funcall tag (cdr term-list))))
     (put-proc 'empty-termlist? '(dense-polynomial) (lambda (term-list) (null term-list))))))

