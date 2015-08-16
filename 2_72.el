;; Given n symbols with the frequences distreduted as was described in
;; ex. 2_71 the encoding tree looks like that:
;;
;;            2^n - 1
;;            /      \
;;        2^(n-1)-1   2^(n-1)
;;          /     \
;;    2^(n-2)-1    2^(n-2)
;;      /   \
;;    ...    2^(n-3)
;;    /
;;   1
;;
;; Encoding the most frequent symbol with the algorithm designed as a
;; solution for ex. 2_68 will always result in (n-1) + 1 = n steps,
;; because it will first check left branch of the tree for the
;; presence of the symbol (and it will not be there) and then the left
;; branch (at it will be the only symbol in that branch). Now it's
;; clear that it can be improved to use only one step by switching
;; conditions in cond special form.
;;
;; Encoding least freaquent symbold takes:
;; (n-1) + (n-2) + (n-3) + ... + 1 steps to check for the presence of
;; given symbol in left sub-trees. There are total of n checks wich
;; gives us n*n + C steps. Wich is O(n^2) order of growth.
;;
;; So, encoding algoritm have O(n^2) order of growth in running time.
;;
