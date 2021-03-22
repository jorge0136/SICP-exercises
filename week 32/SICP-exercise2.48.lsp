#lang scheme
(define (make-vect x y)
  (cons x y))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (make-segment start end)
  (cons start end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define start-vect (make-vect 0 0))

(define end-vect (make-vect 3 4))

(define segment (make-segment start-vect end-vect))
(start-segment segment) ; => (0 . 0)
(end-segment segment) ; => (3 . 4)