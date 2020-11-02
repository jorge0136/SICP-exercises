#lang sicp
; Exercise 2.31: Abstract your answer to Exercise 2.30 to produce a procedure tree-map with the
; property that square-tree could be defined as


(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))


(define (square x)
  (* x x))

(define (tree-map proc tree)
  (map (lambda (sub-tree)
        (if (pair? sub-tree)
            (tree-map square sub-tree)
            (square sub-tree)))
           tree))

(define (square-tree tree)
  (tree-map square tree))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
