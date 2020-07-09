#lang racket
(require racket/trace)

;; Exercise 1.29.  Simpson's Rule is a more accurate method of numerical integration
;; than the method illustrated above. Using Simpson's Rule, the integral of a
;; function f between a and b is approximated as

;; h[ y₍0₎ + 4y₁ + 2y₂ + 4y₃ + 2y₄ + ... + 2y₍n₋₂₎ + 4y₍n₋₁₎ + y₍n₎]/3

;; where h = (b - a)/n, for some even integer n, and yk = f(a + kh).
;; (Increasing n increases the accuracy of the approximation.)
;; Define a procedure that takes as arguments f, a, b, and n and returns the
;; value of the integral, computed using Simpson's Rule.
;; Use your procedure to integrate cube between 0 and 1 (with n = 100 and n = 1000),
;;  and compare the results to those of the integral procedure shown above.


;; each seperate piece

;;(define (simpsons f a b n)
;;  (/ (* h (sum term 0 inc n))3))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (cube x) (* x x x))



(define (simpsons f a b n)
  ;; first we need to find the value of h
  (define h (/ (- b a) n))
  ;; then we need to know the value of y of k
  (define (y k) (f ( + a (* k h))))
  ;; to find k we use the coefficient definition after finding k we can find the the single term we need to sum
  (define (term k)
    (*  (cond ((odd? k) 4)
            ((or (= k 0) (= k n)) 1)
            ((even? k) 2))
      (y k)))
   (define (inc x) (+ x 1))
   ;; putting it all together
   (* (/ h 3)(sum term 0 inc n)))

(simpsons cube 0 1.0 1000)

;; the whole thing put together

;;(define (simpson f a b n)
;;  (define h (/ (- b a) n))
;;  (define (inc x) (+ x 1))
;;  (define (y k)
;;    (f (+ a (* k h))))
;;  (define (term k)
;;    (* (cond ((odd? k) 4)
;;             ((or (= k 0) (= k n)) 1)
;;             ((even? k) 2))
;;       (y k)))
;;  (/ (* h (sum term 0 inc n)) 3))
