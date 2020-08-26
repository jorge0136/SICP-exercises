#lang sicp
;; Exercise 2.2.  Consider the problem of representing line segments in a plane.
;; Each segment is represented as a pair of points: a starting point and an ending
;; point. Define a constructor make-segment and selectors start-segment and
;; end-segment that define the representation of segments in terms of points.
;; Furthermore, a point can be represented as a pair of numbers: the x coordinate
;; and the y coordinate. Accordingly, specify a constructor make-point and selectors
;; x-point and y-point that define this representation. Finally, using your selectors
;; and constructors, define a procedure midpoint-segment that takes a line segment as
;; argument and returns its midpoint (the point whose coordinates are the average of
;; the coordinates of the endpoints).
;; To try your procedures, you'll need a way to print points:

; points, x and y.
; lines, start and end.
; midpoint is start + end / 2
; midpoint(a b) make-point(x(a) + x(b) /2, y(a) + y(b) /2)

(define (midpoint line)
  (make-point (/ (+ (x-point (start line)) (x-point (end line))) 2)
              (/ (+ (y-point (start line)) (y-point (end line))) 2)))

(define (make-point x y)
  (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (make-line point-a point-b)
  (cons point-a point-b))
(define (start line) (car line))
(define (end line) (cdr line))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

(define a (make-point 1 3))
(define b (make-point 3 3))
(print-point a)

(define line-a (make-line a b))
(print-point (midpoint line-a))