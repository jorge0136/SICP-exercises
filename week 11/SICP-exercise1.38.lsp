#lang racket
(require racket/trace)

;; Exercise 1.38: In 1737, the Swiss mathematician Leonhard Euler published a memoir De Fractionibus
;; Continuis, which included a continued fraction expansion for e-2, where e is the base of the
;; natural logarithms. In this fraction, the Ni are all 1, and the Di are successively 1, 2, 1, 1,
;; 4, 1, 1, 6, 1, 1, 8, .... Write a program that uses your cont-frac procedure from Exercise 1.37
;; to approximate e, based on Euler’s expansion.



;; index = 0 1 2 3 4 5 6 7 8 9 10
;; value = 1 2 1 1 4 1 1 6 1 1 8

(define (d i)
   (if (not (= 0 (remainder (+ i 1) 3)))
       1
       (* 2 (/ (+ i 1) 3))))
(trace d)

(d 8)

(define (cont-frac n d k)
  (define (frac i)
    (if ( < i k)
        (/ (n i)(+ (d i) (frac (+ i 1))))
        (/ (n i)(d i))))
 (frac 1))

(cont-frac 1
           (d 5)
           5)
