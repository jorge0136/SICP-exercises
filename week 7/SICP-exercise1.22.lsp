#lang sicp
;; Exercise 1.22: Most Lisp implementations include a primitive called `runtime` that returns an integer
;; that specifies the amount of time the system has been running (measured, for example, in microseconds).

;; The following timed-prime-test procedure, when called with an integer n, prints n and checks to
;; see if n is prime. If n is prime, the procedure prints three asterisks followed by the amount of
;; time used in performing the test.

(define ( square x ) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
 (newline)
 (display n)
 (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
 (if (prime? n)
     (report-prime (- (runtime)
                      start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

;; Using this procedure, write a procedure search-for-primes that checks the primality of consecutive
;; odd integers in a specified range. Use your procedure to find the three smallest primes:
;; * larger than 1000
;; * larger than 10,000
;; * larger than 100,000
;; * larger than 1,000,000

;; Note the time needed to test each prime. Since the testing algorithm has order of growth of Θ(n⎯⎯√),
;; you should expect that testing for primes around 10,000 should take about 10⎯⎯⎯⎯√ times as long as
;; testing for primes around 1000. Do your timing data bear this out? How well do the data for 100,000
;; and 1,000,000 support the Θ(n⎯⎯√) prediction? Is your result compatible with the notion that
;; programs on your machine run in time proportional to the number of steps required for the computation?

(define (search-for-odd-primes a b)
  (search-for-odd-prime-iter b a)
  (newline)
)

(define (search-for-odd-prime-iter n current-possible-prime)
  (timed-prime-test current-possible-prime)
  (cond ((even? current-possible-prime) (search-for-odd-prime-iter n (+ 1 current-possible-prime)))
        ((>= current-possible-prime n) current-possible-prime)
        ((< current-possible-prime n) (search-for-odd-prime-iter n (+ 2 current-possible-prime)))))

;(search-for-odd-primes 1000 1020)
;(search-for-odd-primes 10000 10050)
;(search-for-odd-primes 100000 100050)
(search-for-odd-primes 1000000 1000050)
