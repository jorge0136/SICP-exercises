#lang racket
; Exercise 2.9: The width of an interval is half of the difference between its upper and lower
; bounds. The width is a measure of the uncertainty of the number specified by the interval. For
; some arithmetic operations the width of the result of combining two intervals is a function only
; of the widths of the argument intervals, whereas for others the width of the combination is not a
; function of the widths of the argument intervals. Show that the width of the sum (or difference)
; of two intervals is a function only of the widths of the intervals being added (or subtracted).
; Give examples to show that this is not true for multiplication or division.

(define (make-interval a b) (cons a b))

(define (upper-bound interval)
  (car interval))

(define (lower-bound interval)
  (cdr interval))

(define (sub-interval first-interval second-interval)
  (make-interval
   (- (upper-bound first-interval)(upper-bound second-interval))
   (- (lower-bound first-interval)(lower-bound second-interval))))

(define (add-interval first-interval second-interval)
  (make-interval
   (+ (upper-bound first-interval)(upper-bound second-interval))
   (+ (lower-bound first-interval)(lower-bound second-interval))))

(define (width interval)
  (/ (- (upper-bound interval) (lower-bound interval)) 2))

(define (mult-interval first-interval second-interval)
  (make-interval
   (* (upper-bound first-interval)(upper-bound second-interval))
   (* (lower-bound first-interval)(lower-bound second-interval))))



(define a (make-interval 9 3))
(define b (make-interval 18 10))

(display "width a= ") (width a)
(display "width b= ") (width b)

(display "add width= ") (width (add-interval a b))
(display "subtract width= ") (width (sub-interval a b))

(display "multiplication width= " ) (width (mult-interval a b))

