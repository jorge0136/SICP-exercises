#lang sicp
; Exercise 2.30.  Define a procedure square-tree analogous to the square-list procedure of exercise 2.21.
; That is, square-list should behave as follows:

; (square-tree
;  (list 1
;        (list 2 (list 3 4) 5)
;        (list 6 7)))
; (1 (4 (9 16) 25) (36 49))

; Define square-tree both directly (i.e., without using any higher-order procedures) and also by using map and recursion.

(define (square x) (* x x))

; Attempt to convert `fringe` into `square-tree`. `fringe` returns a flat list. :( 
(define (square-flatten tree)
  (cond ((null? tree) nil)
        ((pair? tree) (append (square-flatten (car tree))
                              (square-flatten (cdr tree))))
        (else (list (square tree)))))

(define test_list (list 1 (list 2 (list 3 4) 5) (list 6 7)))

 (define (square-tree tree) 
   (cond ((null? tree) nil) 
         ((not (pair? tree)) (square tree))
         ; cons over list here to get the right `tree` shape. 
         (else (cons (square-tree (car tree)) 
                     (square-tree (cdr tree)))))) 

(square-tree test_list)

 (define (square-tree-by-map tree) 
   (map (lambda (x) 
          (cond ((null? x) nil) 
                ((not (pair? x)) (square x)) 
                (else (square-tree-by-map x)))) 
        tree))

(square-tree-by-map test_list)