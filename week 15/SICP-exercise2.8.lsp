#lang sicp
; Exercise 2.8: Using reasoning analogous to Alyssa’s, describe how the difference of two
; intervals may be computed. Define a corresponding subtraction procedure, called sub-interval.

(define (make-interval lower upper) (cons lower upper))

(define (lower-bound interval)
  (car interval))
(define (upper-bound interval)
  (cdr interval))

(define foo (make-interval 2 3))
(define fiz (make-interval 1 1))

; I reason that the minimum value the difference could be is the difference of the two lower
; bounds and the maximum value it could be is the difference of the two upper bounds:
(define (sib-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(sib-interval foo fiz)
