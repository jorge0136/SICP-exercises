#lang racket
;; Exercise 2.3: Implement a representation for rectangles in a plane. (Hint: You may want to make
;; use of Exercise 2.2.) In terms of your constructors and selectors, create procedures that compute
;; the perimeter and the area of a given rectangle. Now implement a different representation for
;; rectangles. Can you design your system with suitable abstraction barriers, so that the same
;; perimeter and area procedures will work using either representation?

(define (make-segment start end)
  (cons start end))

(define (start-segment x)
  (car x))

(define (end-segment x)
  (cdr x))

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (midpoint segment)
  (let ((start (start-segment segment))
        (end (end-segment segment)))
       (make-point (/ (+ (x-point start)(x-point end) 2))
              (/ (+ (y-point start) (y-point end)) 2))))

(define (perimeter segment_1 segment_2 segment_3)
  (+ (* 2 (abs (- (x-point(start-segment segment_1)) (x-point(start-segment segment_2)))))
     (* 2 (abs (- (y-point(start-segment segment_1)) (y-point(start-segment segment_3)))))
     ))

(define (area segment_1 segment_2 segment_3)
  (* (abs (- (x-point(start-segment segment_1)) (x-point(start-segment segment_2))))
     (abs (- (y-point(start-segment segment_1)) (y-point(start-segment segment_3))))
     ))
     


(define first-point (make-point 1 3))
(define second-point (make-point 6 3))
(define third-point (make-point 1 1))
(define fourth-point (make-point 6 1))

(define line_1 (make-segment first-point second-point))
(define line_2 (make-segment second-point fourth-point))
(define line_3 (make-segment third-point fourth-point))




(perimeter line_1 line_2 line_3)
(area line_1 line_2 line_3)

