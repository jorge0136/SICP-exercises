#lang sicp
;; Exercise 1.33: You can obtain an even more general version of accumulate (Exercise 1.32) by
;; introducing the notion of a filter on the terms to be combined. That is, combine only those terms
;; derived from values in the range that satisfy a specified condition. The resulting
;; filtered-accumulate abstraction takes the same arguments as accumulate, together with an
;; additional predicate of one argument that specifies the filter. Write filtered-accumulate as a
;; procedure. Show how to express the following using filtered-accumulate:

;; 1. the sum of the squares of the prime numbers in the interval a to b (assuming that you have a
;; prime? predicate already written)

(define (filtered-accumulate filter combiner null-value term a next b)
  (if (> a b)
      null-value
      (if (filter a)      
            (combiner (term a)
                      (filtered-accumulate filter combiner null-value term (next a) next b))
            (filtered-accumulate filter combiner null-value term a next b))))


(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
               n
               (+ test-divisor 1)))))


(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (sum-of-prime-squares a)
   (define (sum x y)
    (+ x y)
   (define (prime? x)
     (= n (smallest-divisor n)))
   (define (inc a)
     (+ a 1))
  (filter-accumulate prime sum 0 square 1 inc a)))

(sum-of-prime-squares 11)




;; 2. the product of all the positive integers less than n that are relatively prime to n (i.e.,
;; all positive integers i<n such that GCD(i,n)=1).
