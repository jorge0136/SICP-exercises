; Exercise 2.4: Here is an alternative procedural representation of pairs. For this
; representation, verify that (car (cons x y)) yields x for any objects x and y.

; (define (cons x y)
;   (lambda (m) (m x y)))

; (define (car z) (z (lambda (p q) p))) What is the corresponding definition of cdr? (Hint: To
; verify that this works, make use of the substitution model of 1.1.5.)


#lang sicp

(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define (cdr z)
  (z (lambda (p q) q)))

(car (cons 1 2))

(car (lambda (m) (m 1 2)))

((lambda (m) (m 1 2)) (lambda (p q) p))

((lambda (p q) p) 1 2) ;=> 1
