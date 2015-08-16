(defun entry (tree) (car tree))
(defun left-branch (tree) (cadr tree))
(defun right-branch (tree) (caddr tree))
(defun make-tree (entry left right)
  (list entry left right))
(defun tree->list (tree)
  (defun copy-to-list (tree result-list)
    (if (not tree)
        result-list
      (copy-to-list (left-branch tree)
                    (cons (entry tree)
                          (copy-to-list
                           (right-branch tree)
                           result-list)))))
  (copy-to-list tree '()))
(defun list->tree (elements)
  (car (partial-tree elements (length elements))))
(defun partial-tree (elts n)
  (if (= n 0)
      (cons '() elts)
    (let ((left-size (/ (- n 1) 2)))
      (let ((left-result
             (partial-tree elts left-size)))
        (let ((left-tree (car left-result))
              (non-left-elts (cdr left-result))
              (right-size (- n (+ left-size 1))))
          (let ((this-entry (car non-left-elts))
                (right-result
                 (partial-tree
                  (cdr non-left-elts)
                  right-size)))
            (let ((right-tree (car right-result))
                  (remaining-elts
                   (cdr right-result)))
              (cons (make-tree this-entry
                               left-tree
                               right-tree)
                    remaining-elts))))))))

(defun union-set (set1 set2)
  (defun union-lists (list1 list2)
    (cond ((not list1) list2)
          ((not list2) list1)
          ((= (car list1) (car list2)) (cons (car list1) (union-lists (cdr list1) (cdr list2))))
          ((< (car list1) (car list2)) (cons (car list1) (union-lists (cdr list1) list2)))
          ((> (car list1) (car list2)) (cons (car list2) (union-lists list1 (cdr list2))))))
  (let ((list1 (tree->list set1))
        (list2 (tree->list set2)))
    (list->tree (union-lists list1 list2))))


(defun intersection-set (set1 set2)
  (defun intersection-lists (list1 list2)
    
    (cond ((or (not list1) (not list2)) '())
          ((= (car list1) (car list2)) (cons (car list1) (intersection-lists (cdr list1) (cdr list2))))
          ((< (car list1) (car list2)) (intersection-lists (cdr list1) list2))
          ((> (car list1) (car list2)) (intersection-lists list1 (cdr list2)))))
  (let ((list1 (tree->list set1))
        (list2 (tree->list set2)))
    (list->tree (intersection-lists list1 list2))))
        
    
              
