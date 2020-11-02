#lang sicp
; Exercise 2.30: Define a procedure square-tree analogous to the square-list procedure of Exercise
; 2.21. That is, square-tree should behave as follows:

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (square-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree))
         (* tree tree))
        (else
         (cons (square-tree (car tree))
               (square-tree (cdr tree))))))

(define (square-map-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-map-tree sub-tree)
             (* sub-tree sub-tree)))
       tree))


(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

(square-map-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
; (1 (4 (9 16) 25) (36 49))
; Define square-tree both directly (i.e., without using any higher-order procedures) and also by
; using map and recursion.
