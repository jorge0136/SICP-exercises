#lang racket/base
(require racket/trace)

; Exercise 1.22: Most Lisp implementations include a primitive called runtime that returns an integer that specifies the amount of time the system has been running (measured, for example, in microseconds). The following timed-prime-test procedure, when called with an integer n, prints n and checks to see if n is prime. If n is prime, the procedure prints three asterisks followed by the amount of time used in performing the test.

 (define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test (- (* n 10) 1) n n (runtime) 0))

(define (runtime)
  (current-milliseconds))


 (define (report-prime n elapsed-time)
  (display " *** ")
  (display " prime number: ")
  (display n)
  (display " elapsed-time: ")
  (display elapsed-time))

; Using this procedure, write a procedure search-for-primes that checks the primality of consecutive odd integers in a specified range. Use your procedure to find the three smallest primes larger than 1000; larger than 10,000; larger than 100,000; larger than 1,000,000. Note the time needed to test each prime. Since the testing algorithm has order of growth of Θ(n⎯⎯√), you should expect that testing for primes around 10,000 should take about 10⎯⎯⎯⎯√ times as long as testing for primes around 1000. Do your timing data bear this out? How well do the data for 100,000 and 1,000,000 support the Θ(n⎯⎯√) prediction? Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?


 (define (start-prime-test upper lower n start-time prime-count)
  (cond ((and (prime? n) (< prime-count 3))
         (report-prime n (- (runtime) start-time))
         (start-prime-test upper lower (+ n 1) start-time (+ prime-count 1)))
        ((and (>= n lower)
              (<= n upper)
                (start-prime-test upper lower (+ n 1) start-time prime-count)))
       (else (display " end of range "))))


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


(timed-prime-test 1000)

; 1000 - 1009, 1013, 1019
; 100000 - 100003, 100019, 100043
; 1000000 - 10000019, 10000079, 10000103






