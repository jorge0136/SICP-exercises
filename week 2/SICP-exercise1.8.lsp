#lang sicp
;; Exercise 1.8: Newton's method for cube roots is based on the fact that if y is an approximation
;; to the cube root of x, then a better approximation is given by the value
;; ;; x / y square + 2y all over 3.
;; Use this formula to implement a cube-root procedure analogous to the square-root procedure.


(define (square x)
  (* x x))

(define (cube x)
  (* (square x) x))


(define (improve guess x)
  ( /
    ( + ( / x (square guess)) ( * 2 guess))
    3))

(define (good-enough? guess x)
  (< (abs ( - (cube guess) x)) 0.001))

(define (cuber guess x)
  (if (good-enough? guess x)
      guess
      (cuber (improve guess x) x)))

(define (cube-rt x)
  (cuber 1.0 x))

(cube-rt 3)
