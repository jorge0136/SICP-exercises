#lang sicp
; Exercise 2.4: Here is an alternative procedural representation of pairs. For this
; representation, verify that (car (cons x y)) yields x for any objects x and y.

 (define (cons x y)
   (lambda (m) (m x y)))

 (define (car z) (z (lambda (p q) p)))

; What is the corresponding definition of cdr? (Hint: To
; verify that this works, make use of the substitution model of 1.1.5.)

(define (cdr z) (z (lambda (p q) q)))

(define a (cons 1 2))
(car a)
(cdr a)

(newline)

(define b (cons 1 (cons 2 3)))
(car b)
(car (cdr b))
(cdr (cdr b))


; Let's do substitution representation for `a`
; (define a (cons 1 2))
;   (define (cons 1 2)
;     (lambda (m) (m 1 2)))

; (car a)
;    (define (car a) (a (lambda (p q) p)))
;        (define (car (1 2)) ((1 2) (lambda (1 2) 2)))
