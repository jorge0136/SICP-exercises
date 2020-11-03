#lang sicp

(define (square x) (* x x))

(define (tree-map fn tree)
  (if (not (pair? tree)) (fn tree)
      (map (lambda (t) (tree-map fn t)) tree)))

(define (square-tree tree)
  (tree-map square tree))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
;(1 (4 (9 16) 25) (36 49))
