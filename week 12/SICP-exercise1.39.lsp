;; Exercise 1.39.  A continued fraction representation of the tangent function was published in
;; 1770 by the German mathematician J.H. Lambert:


;; where x is in radians. Define a procedure (tan-cf x k) that computes an approximation to the
;; tangent function based on Lambert's formula. K specifies the number of terms to compute,
;; as in exercise 1.37.
#lang sicp

(define pi 3.14159265)
(define (square i) (* i i ))

(define (cont-frac n d k)
  (define (cont-frac-iter i result)
    (if (= i 0) result
        (cont-frac-iter (- i 1) (/ (n i) (+ (d i) result)))))
  (cont-frac-iter k 0))


(define (tan-cf x k)
  (cont-frac (lambda (i) (if (= i 1) x (- (square x))))
             (lambda (i) (- (* 2 i) 1.0))
             k))


(tan pi)    ; => -3.5897930298416118e-09
(tan-cf pi 20) ;=> -3.5897929852236682e-09
