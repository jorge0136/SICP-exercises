; Exercise 2.28: Write a procedure fringe that takes as argument a tree (represented as a list) and
; returns a list whose elements are all the leaves of the tree arranged in left-to-right order. For
; example,

; (define x (list (list 1 2) (list 3 4)))

; (fringe x) (1 2 3 4)

; (fringe (list x x)) (1 2 3 4 1 2 3 4)
#lang sicp

; We could use flatmap or reduce(accumulate) to do this but these procedures are defined later in the
; chapter.

(define (fringe x)
  (if (or (null? x) (not (pair? (car x)))) x
      (append (fringe (car x)) (fringe (cdr x)))))

(define x
  (list (list 1 2) (list 3 4 7)))

(fringe x)
;(1 2 3 4)

(fringe (list x x))
;(1 2 3 4 1 2 3 4)