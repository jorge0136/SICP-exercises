#lang sicp
;; Exercise 2.3.  Implement a representation for rectangles in a plane.
;; (Hint: You may want to make use of exercise 2.2.) In terms of your constructors and
;; selectors, create procedures that compute the perimeter and the area of a given
;; rectangle. Now implement a different representation for rectangles.
;; Can you design your system with suitable abstraction barriers, so that the same
;; perimeter and area procedures will work using either representation?

(define (make-point x y)
  (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (make-line point-a point-b)
  (cons point-a point-b))
(define (start line) (car line))
(define (end line) (cdr line))

(define (square x) (* x x))
(define (length point-a point-b)
  (sqrt(+ (square (- (x-point point-a) (x-point point-b)))
          (square (- (y-point point-a) (y-point point-b))))))

(define (perimeter point-a point-b point-c)
  (* (+ (length point-a point-b) (length point-a point-c))
     2))

(define (area a b c)
  (* (length a b) (length a c)))
; a -- b
; |    |
; c -- d
(define a (make-point 0 4))
(define b (make-point 4 4))
(define c (make-point 0 0))
(define d (make-point 4 0))

(perimeter a b c)
(area a b c)

; l -- m
; |    |
; n -- o

(define l (make-point 0 6))
(define m (make-point 10 6))
(define n (make-point 0 0))
(define o (make-point 10 0))

(perimeter l m n)
(area l m n)

; How to represent rectangles?
; four lines.
; Vertical lines set and a horiztonal line set

; Parallel lines: a-b, c-d.
; a -- b

; c -- d
(define (make-rectangle-by-line point-a point-b point-c point-d)
        (cons (make-line point-a point-b) (make-line point-c point-d)))

(define parallel-rectangle (make-rectangle-by-line a b c d))
(define (line-a-b rectangle) (car rectangle))
(define (line-c-d rectangle) (cdr rectangle))
(define (rectangle-by-line-area rectangle)
        (area (start (line-a-b rectangle)) (end (line-a-b rectangle)) (start (line-c-d rectangle))))

(define (perimeter-by-line-area rectangle)
        (perimeter (start (line-a-b rectangle)) (end (line-a-b rectangle)) (start (line-c-d rectangle))))

(rectangle-by-line-area parallel-rectangle)
(perimeter-by-line-area parallel-rectangle)

; Diaganol lines
; a-d, b-c
; a   b
;  \ /
;   x
;  / \
; c   d
(define (make-rectangle-by-diaganol point-a point-b point-c point-d)
        (cons (make-line point-a point-d) (make-line point-b point-c)))

(define diaganol-rectangle (make-rectangle-by-diaganol a b c d))
(define (line-a-d rectangle) (car rectangle))
(define (line-b-c rectangle) (cdr rectangle))
(define (rectangle-by-diaganol-area rectangle)
        (area (start (line-a-d rectangle)) (start (line-b-c rectangle)) (end (line-b-c rectangle))))

(define (perimeter-by-diaganol-area rectangle)
        (perimeter (start (line-a-d rectangle)) (start (line-b-c rectangle)) (end (line-b-c rectangle))))

(rectangle-by-diaganol-area diaganol-rectangle)
(perimeter-by-diaganol-area diaganol-rectangle)