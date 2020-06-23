#lang racket/base

; Exercise 1.23: The smallest-divisor procedure shown at the start of this section does lots of
; needless testing: After it checks to see if the number is divisible by 2 there is no point in
; checking to see if it is divisible by any larger even numbers. This suggests that the values used
; for test-divisor should not be 2, 3, 4, 5, 6, …, but rather 2, 3, 5, 7, 9, …. To implement this
; change, define a procedure next that returns 3 if its input is equal to 2 and otherwise returns
; its input plus 2. Modify the smallest-divisor procedure to use (next test-divisor) instead of (+
; test-divisor 1). With timed-prime-test incorporating this modified version of smallest-divisor,
; run the test for each of the 12 primes found in Exercise 1.22. Since this modification halves the
; number of test steps, you should expect it to run about twice as fast. Is this expectation
; confirmed? If not, what is the observed ratio of the speeds of the two algorithms, and how do you
; explain the fact that it is different from 2?

(define (smallest-divisor n)
  (find-divisor n 2 (runtime)))

(define (square x)
  (* x x))

(define (find-divisor n test-divisor start-time)
  (cond ((> (square test-divisor) n)
         (report-smallest-divisor n (- (runtime) start-time) start-time))
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor n (next test-divisor) start-time))))

(define (next test-divisor)
  (if (= test-divisor 2)
    3
  (+ test-divisor 2)))

(define (divides? a b)
  (= (remainder b a) 0))

(define (report-smallest-divisor n elapsed-time start-time)
  (display "prime number: ")
  (display n)
  (newline)
  (display "elapsed time: ")
  (display elapsed-time)
  (newline)
  (display "start time: ")
  (display start-time)
  (display " - current time: ")
  (display (runtime)))

(define (timed-smallest-divisor-test n)
  (newline)
  (display n)
  (newline)
  (smallest-divisor n))

(define (runtime)
  (current-milliseconds))

(timed-smallest-divisor-test 1009)
(timed-smallest-divisor-test 1013) 
(timed-smallest-divisor-test 1019) 
(timed-smallest-divisor-test 10007) 
(timed-smallest-divisor-test 10009) 
(timed-smallest-divisor-test 10037) 
(timed-smallest-divisor-test 100003) 
(timed-smallest-divisor-test 100019) 
(timed-smallest-divisor-test 100043) 
(timed-smallest-divisor-test 1000003) 
(timed-smallest-divisor-test 1000033)
(timed-smallest-divisor-test 1000037) 


; not seeing the time much faster as a result of the extra computation of the of the additional `next` process with a conditional?