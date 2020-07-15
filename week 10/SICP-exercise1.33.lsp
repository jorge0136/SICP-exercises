#lang racket
(require racket/trace)
;; Exercise 1.33: You can obtain an even more general version of accumulate (Exercise 1.32) by
;; introducing the notion of a filter on the terms to be combined. That is, combine only those terms
;; derived from values in the range that satisfy a specified condition. The resulting
;; filtered-accumulate abstraction takes the same arguments as accumulate, together with an
;; additional predicate of one argument that specifies the filter. Write filtered-accumulate as a
;; procedure. Show how to express the following using filtered-accumulate:

(define ( square x ) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        ; Here is what is different for this problem. 
        ((even? test-divisor) (find-divisor n (+ test-divisor 1)) )
        (else (find-divisor n (+ test-divisor 2)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (filter-accumulate filter-predicate combiner null-value term a next b)
  (if (> a b)
       null-value
       (if (filter-predicate a)
           (combiner (term a)
                     (filter-accumulate filter-predicate combiner null-value term (next a) next b))
           (filter-accumulate filter-predicate combiner null-value term (next a) next b))))

(define (inc x) (+ x 1))

(define (sum-of-primes a b)
  (filter-accumulate prime? + 0 (lambda (x) x) a inc b))

(sum-of-primes 1 5) ;=> 11

;; 1. the sum of the squares of the prime numbers in the interval a to b (assuming that you have a
;; prime? predicate already written)

(define (sum-square-primes a b)
  (filter-accumulate prime? + 0 square a inc b))

(sum-square-primes 1 5) ; => 39

;; 2. the product of all the positive integers less than n that are relatively prime to n (i.e.,
;; all positive integers i<n such that GCD(i,n)=1).

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (relative-prime? a b)
  (= 1 (gcd a b)))

(define (product-relative-primes a b)
  (filter-accumulate (lambda (x) (relative-prime? x b)) * 1 (lambda (x) (display x) x) a inc b))

(product-relative-primes 1 3) ; => 2 is only relative prime. 
(product-relative-primes 2 4) ; => 3 is only relative prime. 
(product-relative-primes 2 5) ; => 2 * 3 * 4 = 24
(product-relative-primes 2 6) ; => 5 is only relative prime. 
