#lang sicp
; Exercise 2.31.  Abstract your answer to exercise 2.30 to produce a procedure tree-map with the property
;  that square-tree could be defined as

; (define (square-tree tree) (tree-map square tree))

(define (square x) (* x x))

(define (tree-map procedure tree) 
  (map (lambda (x) 
         (cond ((null? x) nil) 
               ((not (pair? x)) (procedure x)) 
               (else (tree-map procedure x)))) 
       tree))

(define (square-tree tree) (tree-map square tree))

(define test_list (list 1 (list 2 (list 3 4) 5) (list 6 7)))
(square-tree test_list)
