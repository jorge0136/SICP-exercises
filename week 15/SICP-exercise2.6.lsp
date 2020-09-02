#lang racket
; Exercise 2.6: In case representing pairs as procedures wasn’t mind-boggling enough, consider
; that, in a language that can manipulate procedures, we can get by without numbers (at least
; insofar as nonnegative integers are concerned) by implementing 0 and the operation of adding 1
; as

; a procedure that returns a procedure that takes an argument f which returns a procedure which
; takes an argument x

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
   (lambda (f) (lambda (x) (f ((n f) x)))))
; This representation is known as Church numerals, after its inventor, Alonzo Church, the logician
; who invented the λ-calculus.

; Define one and two directly (not in terms of zero and add-1). (Hint: Use substitution to
; evaluate (add-1 zero)). Give a direct definition of the addition procedure + (not in terms of
; repeated application of add-1).



; means of testing zero

(define (inc n)
  (+ n 1))

;; substitution method
(define zero (lambda (g) (lambda (y) y)))

(define (add-1 n)
   (lambda (f) (lambda (x) (f ((n f) x)))))

(add-1 zero)

;  this is from https://kendyck.com/2007/07/07/solution-to-sicp-26/

(lambda (f) (lambda(x) (f ((zero f)x))))
(lambda (f) (lambda(x) (f (((lambda(g)(lambda (y) y)) f)x))))
(lambda (f) (lambda(x) (f ((lambda (y) y ) x))))
(lambda (f) (lambda(x) (f (f (x)))))
