#lang sicp

(define (square x) (* x x))

(define (square-tree node)
  (if (not (pair? node)) (square node)
      (map square-tree node)))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
;(1 (4 (9 16) 25) (36 49))
