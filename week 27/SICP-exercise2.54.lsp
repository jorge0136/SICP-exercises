#lang sicp

;Exercise 2.54.  Two lists are said to be equal? if they contain equal elements arranged in the same order. For example,

;(equal? '(this is a list) '(this is a list))

; is true, but

; (equal? '(this is a list) '(this (is a) list))

; is false. To be more precise, we can define equal? recursively in terms of the basic eq? equality of symbols
; by saying that a and b are equal? if they are both symbols and the symbols are eq?, or if they are both lists such
; that (car a) is equal? to (car b) and (cdr a) is equal? to (cdr b). Using this idea, implement equal? as a procedure.36


; if both are lists --> recursively check each pair.
; if one is a list and the other is not --> return false. 
; If not, compare the two symbols and return.

(define (either-null? a b)
  (or  (null? b)
       (null? a)))

(define (both-null? a b)
  (and (null? b)
       (null? a)))

(define (either-a-list? a b)
    (or (list? b)
        (list? a)))

 (define (equal? list1 list2) 
   (cond ((both-null? list1 list2) #t) ; base case
         ((either-null? list1 list2) #f) ; base case
         ((not (eq? (car list1)
                    (car list2))) #f) ; base case 
         (else (equal? (cdr list1) (cdr list2))))) ; recursive case 

(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this (is a) list))