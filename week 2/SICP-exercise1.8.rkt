#lang racket
(require racket/trace)
;; Exercise 1.8: Newton's method for cube roots is based on the fact that if y is an approximation
;; to the cube root of x, then a better approximation is given by the value
;; ;; x / guess squared + 2guess all over 3.
;; Use this formula to implement a cube-root procedure analogous to the square-root procedure.


  (define ( square x ) (* x x))

  (define ( cube x ) (* (square x)
                        x))

  (define (improve guess x)
    (/ (+ (* guess
             2.0)
          (/ x
             (square guess)))
       3.0))

  (define (improved-guess-delta old_guess x)
    (- (improve old_guess x)
        old_guess))

  (define (good-enough? guess x)
    (<
       (abs (improved-guess-delta guess x))
       (* guess 0.001)))

  (define (cube-root-iter guess x)
    (if (good-enough? guess x)
            guess
            (cube-root-iter (improve guess x) x)))

  (define (cube-root x)
    (cube-root-iter 1.0 x))

  (trace improve)
  (trace good-enough?)

;; Provide the cube root function for testing.
(provide cube-root)

