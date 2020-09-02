#lang racket
; Exercise 2.8: Using reasoning analogous to Alyssa’s, describe how the difference of two
; intervals may be computed. Define a corresponding subtraction procedure, called sub-interval.

(define (make-interval a b) (cons a b))

(define (upper-bound interval)
  (car interval))

(define (lower-bound interval)
  (cdr interval))

(upper-bound (make-interval 5 4))

(define (sub-interval first-interval second-interval)
  (make-interval
   (- (upper-bound first-interval)(upper-bound second-interval))
   (- (lower-bound first-interval)(lower-bound second-interval))))

(sub-interval (make-interval 5 4) (make-interval 6 7))