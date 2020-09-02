#lang racket
; Exercise 2.7: Alyssa’s program is incomplete because she has not specified the implementation of
; the interval abstraction. Here is a definition of the interval constructor:

(define (make-interval a b) (cons a b))
; Define selectors upper-bound and lower-bound to complete the implementation.

(define (upper-bound interval)
  (car interval))

(define (lower-bound interval)
  (cdr interval))

(upper-bound (make-interval 5 4))
