;; In case of new operations being added there is no changes have to
;; be made in exisiting code written in explicit-dispatch-style. For
;; data-directed-style new code have to be added to the each function
;; which installs type specific operations, namely one `put'
;; invocation and one corresponding internal function for each type.
;; And for message-passing-style new clause have to be added in cond
;; expressions of all existing type constructors.
;;
;; On the other hand, if new type is added no changes have to be made
;; to the existing code written either in message-passing-syle or in
;; data-directed-style, but programmer have to touch every function
;; written in explictit-dispatch-style and add new cond clause to it.
;;
;; Thus, explicit-dispatch-style is preferable in systems where new
;; operations must often be added and one of data-directed-style or
;; message-passing-style is preferable in systems with often added new
;; types. 
