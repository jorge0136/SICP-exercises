#lang racket

; Exercise 2.4: Here is an alternative procedural representation of pairs. For this
; representation, verify that (car (cons x y)) yields x for any objects x and y.

 (define (cons x y)
   (lambda (m) (m x y)))

 (define (car z)
    (z (lambda (p q) p)))

(define pair (cons 5 4))

(car pair)

; What is the corresponding definition of cdr? (Hint: To
; verify that this works, make use of the substitution model of 1.1.5.)

(define (cdr z)
  (z (lambda (p q) q)))

(cdr pair)


; substitution method from https://billthelizard.blogspot.com/2010/10/sicp-24-implementing-cons-car-and-cdr.html

; (cdr (lambda (m) (m x y)))
; ((z (lambda (p q) q) (lambda (m) (m x y)))
; ((lambda (m) (m x y))(lambda (p q) q))
; in place of the parameter m we substitue in (lambda (p q) q))
; ((lambda (p q) p) x y)

  

