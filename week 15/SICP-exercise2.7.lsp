; Exercise 2.7: Alyssa’s program is incomplete because she has not specified the implementation of
; the interval abstraction. Here is a definition of the interval constructor:

; (define (make-interval a b) (cons a b))
; Define selectors upper-bound and lower-bound to complete the implementation.

#lang sicp

(define (make-interval a b) (cons a b))

; Lower bound selector returns the first element of the interval.
(define (lower-bound interval)
  (car interval))

; Upper bound selector returns the second element of the interval.
(define (upper-bound interval)
  (cdr interval))

(define (add-interval x y)
  (make-interval (+ (lower-bound x)
                    (lower-bound y))
                 (+ (upper-bound x)
                    (upper-bound y))))

(define x (make-interval 1 10))
(define y (make-interval 2 20))

(add-interval x y) ; => (3 . 30)
