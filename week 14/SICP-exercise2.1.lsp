#lang racket

;; Exercise 2.1: Define a better version of make-rat that handles both positive and negative
;; arguments. Make-rat should normalize the sign so that if the rational number is positive, both
;; the numerator and denominator are positive, and if the rational number is negative, only the
;; numerator is negative.


(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))


(define (make-rat n d)
   (let ((sign (if (or (and (< n 0) (< d 0))
                        (and (> n 0) (> d 0)))
                     +
                     -))
         (g (gcd n d)))
  (cons (sign (/ (abs n) g)) (/ (abs d) g))))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (numer x) (car x))
(define (denom x) (cdr x))


(print-rat (make-rat 2 -4))
