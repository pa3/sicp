(load-file "2_68.el")

(defun adjoin-set (x set)
  (cond ((not set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (t (cons (car set)
                 (adjoin-set x (cdr set))))))

(defun make-leaf-set (pairs)
  (if (not pairs)
      '()
    (let ((pair (car pairs)))
      (adjoin-set (make-leaf (car pair) 
                             (cadr pair))
                  (make-leaf-set (cdr pairs))))))

(defun generate-huffman-tree (pairs)
  (successive-merge (make-leaf-set pairs)))

(defun successive-merge (leaf-set)
  "Succesively merges the smallest-weight elements of the set until there is only one element left."
  (let ((first (car leaf-set))
        (second (cadr leaf-set))
        (rest (cddr leaf-set)))
    (if (not second)
        first
      (successive-merge (adjoin-set (make-code-tree first second) rest)))))
