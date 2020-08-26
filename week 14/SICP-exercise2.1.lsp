; Exercise 2.1: Define a better version of make-rat that handles both positive and negative
; arguments. Make-rat should normalize the sign so that if the rational number is positive, both
; the numerator and denominator are positive, and if the rational number is negative, only the
; numerator is negative.


#lang sicp

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (sign n)
  (cond ((negative? n) -1)
        ((positive? n) 1)
        (else 0)))

(define (make-rat n d)
  (let ((g (gcd n d))
        (num-sign (if (= (sign n) (sign d)) + -)))
    (cons (num-sign (abs (/ n g)))
          (abs (/ d g)))))

(print-rat (make-rat 2 3)) ;=> 2/3
(print-rat (make-rat -2 3)) ;=> -2/3
(print-rat (make-rat 2 -3)) ;=> -2/3
(print-rat (make-rat -2 -3)) ;=> 2/3


