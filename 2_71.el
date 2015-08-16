; The tree for the n = 5 will look like that:
;
;            31
;           /  \
;         15    16
;        /  \
;       7    8
;      / \
;     3   4
;    / \
;   1   2
;
; The tree for the n = 10 looks alike just higher.
; To encode the most frequent symbol given the tree like
; that (namely the symbol with the frequency 2^(n-1)) always
; just one bit needed, because collective frequencey of all
; 2^(n-2) previous symbols is equal 2^(n-1) - 1.
