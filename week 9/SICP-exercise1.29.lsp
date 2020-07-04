#lang sicp
;; Exercise 1.29.  Simpson's Rule is a more accurate method of numerical integration
;; than the method illustrated above. Using Simpson's Rule, the integral of a
;; function f between a and b is approximated as

;; (h / 3)[ y₍0₎ + 4y₁ + 2y₂ + 4y₃ + 2y₄ + ... + 2y₍n₋₂₎ + 4y₍n₋₁₎ + y₍n₎]

;; where h = (b - a)/n, for some even integer n, and yk = f(a + kh).
;; (Increasing n increases the accuracy of the approximation.)
;; Define a procedure that takes as arguments f, a, b, and n and returns the
;; value of the integral, computed using Simpson's Rule.
;; Use your procedure to integrate cube between 0 and 1 (with n = 100 and n = 1000),
;;  and compare the results to those of the integral procedure shown above.

#lang sicp

(define (cube n) (* n n n))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))


(define (simpsons-integral f a b n)

  (define (inc n) (+ n 1))

  (define h (/ (- b a) n))

  (define (coeff k)
    (cond
      ((or (= k 0) (= k n)) 1)
      ((odd? k) 4 )
      (else 2 )))

  (define (y k) (f (+ a (* k h))))

  (define (term k)
    (*
      (coeff k)
      (y k)))

  (*
   (sum term 0 inc n)
   (/ h 3)))


(simpsons-integral cube 0 1.0 100) ;-> 0.24999999999999992
(simpsons-integral cube 0 1.0 1000) ;-> 0.2500000000000003

;Boom!
