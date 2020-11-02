#lang sicp
;Exercise 2.28.  Write a procedure fringe that takes as argument a tree (represented as a list) and returns
; a list whose elements are all the leaves of the tree arranged in left-to-right order. For example,
;
;(define x (list (list 1 2) (list 3 4)))
;
;(fringe x)
;(1 2 3 4)
;
;(fringe (list x x))
;(1 2 3 4 1 2 3 4)

; Preorder.

; is the item a pair of single numbers? 
; return the car, then cdr of the pair.

; Go to next pair.

(define (fringe tree)
 (define (fringe-iter tree leaves)
    (if (null? tree)
        leaves
        (fringe-iter (cdr tree)
                      (append (list (car tree))
                              leaves))))
  (fringe-iter tree '()))

