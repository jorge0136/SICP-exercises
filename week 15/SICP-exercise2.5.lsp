; Exercise 2.5: Show that we can represent pairs of nonnegative integers using only numbers and
; arithmetic operations if we represent the pair a and b as the integer that is the product 2a3b.
; Give the corresponding definitions of the procedures cons, car, and cdr.

#lang sicp

; Observation:
; 2 to the power of any number is even
; 3 to the power of any number is odd

(define (cons x y)
  (* (expt 2 x) (expt 3 y)))

; Divide by 2 until the number is odd, the `car` is the number of times we recursed.
(define (car x)
  (define (div number index)
    (if (odd? number)
        index
        (div (/ number 2) (+ index 1))))
  (div x 0))

; Remove the exponentiated first number from x so that we're left with only the exponentiated second
; number, the `cdr` is how many times 3 will go into that number.
(define (cdr x)
  (let ((exponentiated-last-number (/ x (expt 2 (car x)))))
    (inexact->exact (log exponentiated-last-number 3))
    ))

(car (cons 33 56)) ;=> 33
(car (cons 12 13)) ;=> 12

(cdr (cons 5 6)) ; => 6
(cdr (cons 23 48)) ; => 48
