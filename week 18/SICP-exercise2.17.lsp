#lang sicp
; Exercise 2.17.  Define a procedure last-pair that returns the list that contains only the last
; element of a given (nonempty) list:
;
; (last-pair (list 23 72 149 34))
; (34)

(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))

(define (last-pair items)
  (define (last-pair-iter items pair)
    (if (null? items)
        pair
        (last-pair-iter (cdr items) (list (car (cdr pair))
                                          (car items)))))
  (if (<= 2 (length items))
      (last-pair-iter (cdr (cdr items))
                      (list (car items)
                            (car (cdr items))))
      (error "List is empty or only has one item")))

(define squares (list 1 4 9 16 25))
(last-pair squares)

(define tiny-list (list 1))
(last-pair tiny-list)
