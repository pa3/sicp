(load-file "2_69.el")


(defvar rock-tree (generate-huffman-tree '(
                                           (A 2)
                                           (GET 2)
                                           (SHA 3)
                                           (WAH 1)
                                           (BOOM 1)
                                           (JOB 2)
                                           (NA 16)
                                           (YIP 9)
                                           )))

(defvar rock-song '(GET A JOB
                        SHA NA NA NA NA NA NA NA NA
                        GET A JOB
                        SHA NA NA NA NA NA NA NA NA
                        WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
                        SHA BOOM))

(length (encode rock-song rock-tree)) ; => Song is encoded into 84
                                      ;    bits with the given tree

(* 3 (length rock-song))  ; => 108 bits is the length of the song given that each
                          ;    of 8 words is encoded with 3 bits

