#lang racket
; Exercise 1.21: Use the smallest-divisor procedure to find the smallest divisor of each of the
; following numbers: 199, 1999, 19999.

(define (smallest-divisor n)
  (find-divisor n 2))

(define (square x)
  (* x x))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
               n
               (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(smallest-divisor 19999)

(prime? 19999)

;; 1999 and 199 are both prime numbers
;; 19999 smallest divisor is 7 - it is not prime
