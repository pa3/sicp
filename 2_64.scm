; a) partial-tree is a recursive algorithm wich performs following
; work at each step:
;  - if amount of elemnts to build tree from is equal to 0 then
;  returns pair with empty list and all the provided elements
;  - recursively builds left sub-tree from (n-1)/2 first elements of
;  provided ordered list
;  - peeks and removes element number n/2 from provided list
;  - recursively builds right sub-tree from (n-1)/2 subsequent
;  elements of input list
;  - combines left sub-tree, element number n/2 and right sub-tree
;  into a result tree   
;  - cons result tree and rest elements 
; For the list of (1 3 5 7 9 11) this algorithm will produce folliwing
; tree: 
;        5
;       / \
;      /   \
;     1     9 
;      \   / \
;       3 7  11
;
; b) given recursive alorithm takes at each iteration T(n) = 2*T(n/2)
; + O(1) amount of steps which is O(n) complexety.

