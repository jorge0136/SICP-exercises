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
 
 (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
 (if (prime? n)
     (report-prime (- (runtime)
                      start-time) 
                    n)))
(define (report-prime elapsed-time n)
  (newline)
  (display n)
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

(define (search-for-odd-primes possible-prime n)
  (if (>= possible-prime n)
          possible-prime
          (timed-prime-test possible-prime))
  (cond ((even? possible-prime) (search-for-odd-primes (+ 1 possible-prime) n ))
        ((< possible-prime n) (search-for-odd-primes (+ 2 possible-prime) n ))))

(define (report-odd-primes a n)
  (display "The Primes between ")
  (display a)
  (display " and ")
  (display n)
  (search-for-odd-primes a n)
  (newline)
  (newline))

(report-odd-primes 1000 1020)
(report-odd-primes 10000 10038)
(report-odd-primes 100000 100045)
(report-odd-primes 1000000 1000038)

(display "We expect the runtime of this algorithim to grow at about square-root(n)")
(newline)
(display "n in this case is the magnitude of the numbers, not the range. AKA 1,000 vs. 10,000 is a 10x increase")
(display "Note that square-root(10) = 3.16227766017")
(newline)
(display "This growth in runtime between the groups is ~3* for numbers 10,00 or larger.")
(display "This growth in runtime between 1000 and 10,000 is ~2*.")
