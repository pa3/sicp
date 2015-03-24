;; a
;;
;;(define (cont-frac n d k)
;;  (define (do-cont-frac i)
;;    (if (= i k)
;;	  (/ (n i) (d i))
;;	  (/ (n i) (+ (d i) (do-cont-frac (+ i 1))))))
;;   (do-cont-frac 1))

;; b

(define (cont-frac n d k)
  (define (do-cont-frac k result)
    (if (= 0 k)
	  result
	  (do-cont-frac (- k 1) (/ (n k) (+ (d k) result)))))
   (do-cont-frac k 0))


(cont-frac (lambda (i) 1.0)
	   (lambda (i) 1.0)
	   11)
