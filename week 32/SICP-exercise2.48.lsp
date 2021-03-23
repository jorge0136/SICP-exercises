#lang sicp
; Exercise 2.48.  A directed line segment in the plane can be represented as a pair of vectors --
; the vector running from the origin to the start-point of the segment, and the vector running from
; the origin to the end-point of the segment. Use your vector representation from exercise 2.46 to
; define a representation for segments with a constructor make-segment and selectors start-segment
; and end-segment.

(define (make-vect x y) (cons x y))

(define (make-segment start-vector end-vector)
  (list start-vector end-vector))

(define (start-segment segment) (car segment))
(define (end-segment segment) (cadr segment))

(define example-start-vector (make-vect .1 .1))
(define example-end-vector (make-vect .75 .75))

(define example-segment (make-segment example-start-vector example-end-vector))
example-segment
(start-segment example-segment)
(end-segment example-segment)
