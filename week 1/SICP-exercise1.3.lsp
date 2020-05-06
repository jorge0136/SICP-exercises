#lang sicp
;; Exercise 1.3
;; Define a procedure that takes three numbers as arguments and returns
;; the sum of the squares of the two larger numbers.

;;  function name, formal parameters, body. 
(define ( square x ) (* x x))
( =  (square 3) 9)

(define ( sum-square y z ) (+ ( square y ) ( square z)))
( =  (sum-square 3 2) 13)

(define ( sum-square-of-biggest-two a b c )
  (define smallest (min a b c))
  (cond ((= smallest c) (sum-square a b))
        ((= smallest b) (sum-square a c))
        ((= smallest a) (sum-square b c))
        (else -1))
)

(sum-square-of-biggest-two 2 2 3)
( =  (sum-square-of-biggest-two 2 2 3) 13)
