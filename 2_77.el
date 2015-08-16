; The solution works, because calling (magnitude x) leads to two
; subsequent dynamic dispatches. The first is performed for type-tag
; 'complex and the second for either tag 'polar or 'rectangular, based
; of the actuall value of x. For example if x is '(complex rectangular
; 3 . 4) the following expansion sequence is happaning: 
; 
; (magnitude x)
; (magnitude '(complex rectangular 3 . 4))
; (apply-generic 'magnitude '(complex rectangular 3 . 4))
; (apply 'magnitude '(rectangular 3 . 4))
; (magnitude '(rectangular 3 . 4))
; (apply-generic 'magnitude '(rectangular 3 . 4))
; (apply (sqrt (+ (square (imag-part z)) (square (real-part z))))
;    '(rectangular 3 . 4)) 
; (sqrt (+ (square (imag-part '(rectangular 3 . 4))) (square
;    (real-part '(rectangular 3 . 4))))) 
; (sqrt (+ (square (apply-generic 'imag-part '(rectangular 3 . 4)))
;    (square (apply-generic 'real-part '(rectangular 3 . 4))))) 
; (sqrt (+ (square (apply (car z) '(3 . 4))) (square (apply (cdr z)
;    '(3 . 4))))) 
; (sqrt (+ (square (car '(3 . 4))) (square (cdr '(3 . 4)))))
; (sqrt (+ (square 3) (square 4)))
; (sqrt (+ 9 16))
; (sqrt 25)
; 5
; 
; Thus, there will 4 invokations of apply-generic: two for magnitude
; function, one for imag-part function and one for real-part. 
