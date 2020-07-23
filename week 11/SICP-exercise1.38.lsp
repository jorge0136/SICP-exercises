#lang racket
(require racket/trace)
;; Exercise 1.38.  In 1737, the Swiss mathematician Leonhard Euler published a memoir De Fractionibus Continuis,
;; which included a continued fraction expansion for e - 2, where e is the base of the natural logarithms.
;; In this fraction, the Ni are all 1, and the Di are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ....
;; Write a program that uses your cont-frac procedure from exercise 1.37 to approximate e, based on Euler's expansion.

;;  Really asking to create the series 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, ....

(define (divides? a b)
  (= (remainder b a) 0))

;; d with cases statements to handle i of 0 or 1. 
;(define (d i)
;  (cond ((< i 2) 1)
;        ((divides? 3 i) (* 2 (/ i 3)))
;        (else 1)))

;; d with adding `1` to `i`. 
(define (d i)
  (let ((i_+_1 (+ i 1)))
    (if (divides? 3 i_+_1)
        (* 2 (/ i_+_1 3))
        1)))

;; Using this d, I am off by exactly 1.... what is that about? 
;(define (d i)
;    (if (divides? 3 i)
;        (* 2 (/ i 3))
;        1))

(define (cont-frac-recursive n d k)
  (define (iter n d k i)
          (if (= k i)
                 (/ (n i) (d i))
                 (/ (n i)
                    (+ (d i) (iter n d k (+ i 1))))))
  (iter n d k 1)) ;; Change the starting iterator back to 0? 

(d 1)
(d 2)
(d 3)
(d 4)
(d 5)
(d 6)
(d 7)
(d 8)
(d 9)

(define (eulers) (+ (cont-frac-recursive (lambda (i) 1.0)
                                         d
                                         12)
                    2))
(eulers)
;; e = 2.71828

