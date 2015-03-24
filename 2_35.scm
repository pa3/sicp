(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 0 (map 
		   (lambda (item)
		     (if (not (pair? item)) 
			 1
			 (count-leaves item))) t)))
