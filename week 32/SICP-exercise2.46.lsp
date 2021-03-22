#lang scheme

(define (make-vect x y)
  (cons x y))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (add-vect v1 v2)
  (make-vect (+ (xcor-vect v1) (xcor-vect v2))
               (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vect (- (xcor-vect v1) (xcor-vect v2))
               (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect v1 s)
  (make-vect (* (xcor-vect v1) s) (* (ycor-vect v1) s)))

(define vect1 (make-vect 3 3))
(define vect2 (make-vect 5 6))

(make-vect 2 3) ; => (2 . 3)

(xcor-vect vect1) ; => 2
(ycor-vect vect2) ; => 6

(add-vect vect1 vect2) ; => (8 . 9)
(sub-vect vect1 vect2) ; => (-2 .-3)
(scale-vect vect1 2) ; => (6 . 6)