(load-file "2_67.el")

(defun contains? (list element)
  (cond ((not list) nil)
        ((equal element (car list)) t)
        (t (contains? (cdr list) element))))

(defun encode-symbol (symbol tree)
  (defun present-in-branch? (branch-selector) (contains? (symbols (funcall branch-selector tree)) symbol))
  (defun rest-bits-from (branch-selector) (encode-symbol symbol (funcall branch-selector tree)))
  (cond ((leaf? tree) nil)
         ((present-in-branch? #'left-branch) (cons 0 (rest-bits-from #'left-branch)))
         ((present-in-branch? #'right-branch) (cons 1 (rest-bits-from #'right-branch)))
         (t (error "No such symbol in table"))))

(defun encode (message tree)
  (if (not message)
      '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))
