#lang racket

;; Exercise 1.39: A continued fraction representation of the tangent function was published in 1770
;; by the German mathematician J.H. Lambert: tanx=x1−x23−x25−…, where x is in radians. Define a
;; procedure (tan-cf x k) that computes an approximation to the tangent function based on Lambert’s
;; formula. k specifies the number of terms to compute, as in Exercise 1.37.



(define (square x)
  (* x x))


(define (tan-cf x k)
  (define (frac i)
    (if ( < i k)
        (/ (square x)(- (+ i 2) (frac (+ i 1))))
        (/ x 1)))
 (frac 1))


(tan-cf (/ pi 6) 5.0)

(tan (/ pi 6))