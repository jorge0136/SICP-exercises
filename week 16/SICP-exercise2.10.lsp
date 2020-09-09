#lang racket

; Exercise 2.10: Ben Bitdiddle, an expert systems programmer, looks over Alyssa’s shoulder and
; comments that it is not clear what it means to divide by an interval that spans zero. Modify
; Alyssa’s code to check for this condition and to signal an error if it occurs.

(define (make-interval a b) (cons a b))

(define (upper-bound interval)
  (car interval))

(define (lower-bound interval)
  (cdr interval))


(define (spans-zero? interval)
  (and (<= (lower-bound interval) 0)
       (>= (upper-bound interval) 0)))


(define (div-interval first-interval second-interval)
  (if (spans-zero? second-interval)
    (error "Error: The second interval cannot span 0.")
    (make-interval
      (/ (upper-bound first-interval)(upper-bound second-interval))
      (/ (lower-bound first-interval)(lower-bound second-interval)))))

(div-interval (make-interval 4 3) (make-interval 4 -2))
