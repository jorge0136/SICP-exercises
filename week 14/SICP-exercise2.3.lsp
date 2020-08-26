; Exercise 2.3: Implement a representation for rectangles in a plane. (Hint: You may want to make
; use of Exercise 2.2.) In terms of your constructors and selectors, create procedures that compute
; the perimeter and the area of a given rectangle. Now implement a different representation for
; rectangles. Can you design your system with suitable abstraction barriers, so that the same
; perimeter and area procedures will work using either representation?

#lang sicp

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (make-segment start-point end-point)
  (cons start-point end-point))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (square x) (* x x))

(define (get-length segment)
  (let ((start-x (x-point (start-segment segment)))
        (start-y (y-point (start-segment segment)))
        (end-x (x-point (end-segment segment)))
        (end-y (y-point (end-segment segment))))
    (sqrt (+ (square (- end-x start-x)) (square (- end-y start-y))))
    ))

(define (make-rectangle left top)
  (cons left top))

(define (get-length-rect rectangle)
  (get-length (car rectangle)))

(define (get-width-rect rectangle)
  (get-length (cdr rectangle)))


(define (perimeter rectangle)
  (* 2
     (+ (get-length-rect rectangle)
        (get-width-rect rectangle))))

(define (area rectangle)
  (* (get-length-rect rectangle)
     (get-width-rect rectangle)))

(define left (make-segment (make-point 0 0) (make-point 0 5)))
(define top (make-segment (make-point 0 0) (make-point 6 0)))

(define rectangle (make-rectangle left top))

(area rectangle) ; => 30
(perimeter rectangle) ; => 22

----------------------------------------------------
#lang sicp

(define (make-point x y)
  (cons x y))

(define (make-rectangle point width height)
  (cons point  (cons width height)))

(define (get-length-rect rectangle)
  (car (cdr rectangle)))

(define (get-width-rect rectangle)
   (cdr (cdr rectangle)))


(define (perimeter rectangle)
  (* 2
     (+ (get-length-rect rectangle)
        (get-width-rect rectangle))))

(define (area rectangle)
  (* (get-length-rect rectangle)
     (get-width-rect rectangle)))

(define rectangle (make-rectangle (make-point 0 0) 5 6))

(area rectangle) ; => 30
(perimeter rectangle) ; => 22
