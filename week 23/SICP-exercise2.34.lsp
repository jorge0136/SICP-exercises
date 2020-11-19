#lang sicp

; Exercise 2.34: Evaluating a polynomial in x at a given value of x can be formulated as an
; accumulation. We evaluate the polynomial

; anxn+an−1xn−1+⋯+a1x+a0
; using a well-known algorithm called Horner’s rule, which structures the computation as
; (…(anx+an−1)x+⋯+a1)x+a0.
; In other words, we start with an, multiply by x, add an−1, multiply by x, and so on, until we
; reach a0.82

; Fill in the following template to produce a procedure that evaluates a polynomial using Horner’s
; rule. Assume that the coefficients of the polynomial are arranged in a sequence, from a0 through
; an.

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))
; abstraction version
(define
  (horner-eval x coefficient-sequence)
  (accumulate
   (lambda (this-coeff higher-terms)
      (+ this-coeff (* x higher-terms)))
   0
   coefficient-sequence))

; non-abstracted

(define (horner-eval-v2 x coefficient-sequence)
  (if (null? coefficient-sequence)
  0
  (+ (car coefficient-sequence)
      (* (horner-eval-v2 x (cdr coefficient-sequence))))))


; For example, to compute 1+3x+5x3+x5 at x=2 you would evaluate

(horner-eval 2 (list 1 3 0 5 0 1))
