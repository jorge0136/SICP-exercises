#lang sicp
;; Exercise 2.21.  The procedure square-list takes a list of numbers as argument and returns a list of the squares of those numbers.

;; (square-list (list 1 2 3 4))
;; (1 4 9 16)

;; Here are two different definitions of square-list. Complete both of them by filling in the missing expressions:

(define (square x) (* x x))

(define (square-list items) 
   (if (null? items) 
       nil 
       (cons (square (car items)) 
             (square-list (cdr items))))) 

(square-list (list 1 2 3 4 5 6 7))

 (define (square-list-2 items)
   (map square items))

(square-list-2 (list 1 2 3 4 5 6 7))