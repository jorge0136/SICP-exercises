#lang sicp
;; Exercise 1.39.  A continued fraction representation of the tangent function was published in
;; 1770 by the German mathematician J.H. Lambert:


;; where x is in radians. Define a procedure (tan-cf x k) that computes an approximation to the
;; tangent function based on Lambert's formula. K specifies the number of terms to compute,
;; as in exercise 1.37.

(define (cont-frac-recursive n d k)
  (define (iter n d k i)
          (if (>= k i)
                 (/ (n i) (d i))
                 (/ (n i)
                    (+ (d i) (iter n d k (+ i 2))))))
  (iter n d k 1)) ;; Change the starting iterator back to 0? 

(define (square x) (* x x))

(define (even? n)(= (remainder n 2) 0))
(define (odd? n)(not(even? n)))


(define (d i)
        (cond ((= i 1) 2)
        ((odd? i) (square 3))))
(d 1)
(d 2)
(d 3)
(d 4)
(d 5)
(d 6)
(d 7)
(d 8)
(d 9)
(newline)
(display "end of d")
(newline)

(define (n i)
        (if (odd? i) i))

(n 1)
(n 2)
(n 3)
(n 4)
(n 5)
(n 6)
(n 7)
(n 8)
(n 9)
;; Note that only odd i's produce anything. 

(define (lambert x)
  (define (d i)
    (if (= i 1) x)
    (if (odd? i) (square x)))
  (define (n i)
    (if (odd? i) i))
  (cont-frac-recursive n d 50))

(define (pi) 3.14159265359)

;(lambert 0) --> Divide by zero error. 
(lambert (/ (pi) 6)) ;; --> Should be 0.577350269
(lambert (pi)) ;; --> 0.
;; Can we just ignore the even x's? Do I need to change the way I produce the series from n? 