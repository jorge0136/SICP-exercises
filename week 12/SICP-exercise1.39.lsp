#lang sicp
;; Exercise 1.39.  A continued fraction representation of the tangent function was published in
;; 1770 by the German mathematician J.H. Lambert:

;; where x is in radians. Define a procedure (tan-cf x k) that computes an approximation to the
;; tangent function based on Lambert's formula. K specifies the number of terms to compute,
;; as in exercise 1.37.

(define (cont-frac-recursive n d k)
  (define (iter k i)
          (if (= k i)
                (/ (n i) (d i))
                (/ (n i)
                   (+ (d i) (iter k (+ i 1))))))
  (iter k 1))

(define (square x) (* x x))

(define (d i)
        (define x 3.0)
        (if (= i 1) x (- (square x))))

(newline) (display "Testing d with arbitrary x") (newline)
(d 1)
(d 2)
(d 3)
(d 4)
(d 5)
(d 6)
(d 7)
(d 8)
(d 9)


;; Originally had ` (if (odd? i) i)`
(define (n i)
        (- (* 2.0 i) 1))

(newline) (display "Testing n") (newline)
(n 1)
(n 2)
(n 3)
(n 4)
(n 5)
(n 6)
(n 7)
(n 8)
(n 9)

(define (tan-cf x k)
  (define (n i)
          (if (= i 1) x (- (square x))))
  (define (d i)
          (- (* 2.0 i) 1))
  (cont-frac-recursive n d k))


(newline) (display "testing tan-cf") (newline)
(define x 1)
(tan-cf x 15)
(tan x)

(newline)
(define y 1.2)
(tan-cf y 15)
(tan y)