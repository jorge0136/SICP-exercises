#lang sicp

; Exercise 2.12: Define a constructor make-center-percent that takes a center and a percentage
; tolerance and produces the desired interval. You must also define a selector percent that
; produces the percentage tolerance for a given interval. The center selector is the same as the
; one shown above.


(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (lower-bound i) (car i))

(define (upper-bound i) (cdr i))

(define (make-interval a b) (cons a b))

;  Note that the percentage tolerance specifies the width of the interval. For example, using the
;  resistor example given in the text, "6.8 ohms with 10% tolerance" gives a width of 0.68 and an
;  interval of [6.12, 7.48].

(define (make-center-percent center-value tolerance)
  (let ((width (* center-value tolerance)))
    (make-center-width center-value width)))

(make-center-percent 2.5 .15)

(make-center-percent 6 .10)