;; Exercise 1.33: You can obtain an even more general version of accumulate (Exercise 1.32) by
;; introducing the notion of a filter on the terms to be combined. That is, combine only those terms
;; derived from values in the range that satisfy a specified condition. The resulting
;; filtered-accumulate abstraction takes the same arguments as accumulate, together with an
;; additional predicate of one argument that specifies the filter. Write filtered-accumulate as a
;; procedure. Show how to express the following using filtered-accumulate:

;; 1. the sum of the squares of the prime numbers in the interval a to b (assuming that you have a
;; prime? predicate already written)

;; 2. the product of all the positive integers less than n that are relatively prime to n (i.e.,
;; all positive integers i<n such that GCD(i,n)=1).

(define (inc n) (+ n 1))

(define (identity n) n)

(define (factorial n)
  (product identity 1 inc n))

(factorial 7)

(define (smallest-divisor n)
  (find-divisor n 2))
(define (square n) (* n n))
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

(define (filter-accumulate
 filter combiner null-value term a next b)
  (define (accumulate-iter n result)
    (if (> n b)
      result
      (if (filter n)
          (accumulate-iter (next n) (combiner result (term n)))
          (accumulate-iter (next n) result))))

  (accumulate-iter a null-value))

(define (sum-of-squares a b)
  (filter-accumulate prime? + 0 square 1 inc 8))

(sum-of-squares 1 8) ; => 88

;;; Relative Primes
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (relative-prime-product n)
  (define (relative-prime i)
    (= (gcd n i) 1))
  (filter-accumulate relative-prime * 1 identity 1 inc n))

(relative-prime-product 8) ;; => 105
