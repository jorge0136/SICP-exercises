#lang sicp
;; Exercise 2.1.  Define a better version of make-rat that handles both positive and
;; negative arguments. Make-rat should normalize the sign so that if the rational
;; number is positive, both the numerator and denominator are positive, and if the
;; rational number is negative, only the numerator is negative.

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

;; if either numerator or denominator are negative, make denominator negative.
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cond ((and (negative? n) (negative? d)) (cons (/ n g) (/ (- d) g)))
      ((and (positive? n) (negative? d)) (cons (/ (- n) g) (/ (- d) g)))
      ((and (negative? n) (positive? d)) (cons (/ n g) (/ d g)))
      (else (cons (/ n g) (/ d g))))))

(define one-third (make-rat 1 3))
(print-rat one-third)

(define negative-one-third (make-rat 1 -3))
(print-rat negative-one-third)

(print-rat (add-rat negative-one-third negative-one-third))