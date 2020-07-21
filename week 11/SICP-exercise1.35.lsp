#lang sicp
;; Exercise 1.35.  Show that the golden ratio  (section 1.2.2) is a fixed point of the
;; transformation x -> 1 + 1/x, and use this fact to compute the golden ratio by means of the fixed-point procedure.

;; A number x is called a fixed point of a function f if x satisfies the equation f(x) = x.

;; For some functions f we can locate a fixed point by beginning with an initial guess and applying f repeatedly, until the value does not change very much.

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (sqrt x)
  (fixed-point (lambda (y) (/ x y))
               1.0))


(define (golden_ratio)
  (fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0))

(golden_ratio)
;; golden_ratio = 1 + sqrt(5)/2 = 1.6180 which satifies the equation
;;  golden_ratio ^2 = golden_ratio + 1

;; x^2 = x + 1
;; x^3 = x^2 + 1 -- Multiply by x
;; x^2 - x - 1 = 0 -- subtract x^2 and 1.
;; AKA (x - 1)*x - 1 = 0

;; Is my algebraic manipulation correct above? 
