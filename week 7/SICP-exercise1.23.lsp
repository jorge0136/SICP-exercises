#lang sicp
;; Exercise 1.23: The smallest-divisor procedure shown at the start of this section does lots of 
;; needless testing: After it checks to see if the number is divisible by 2 there is no point in 
;; checking to see if it is divisible by any larger even numbers. This suggests that the values used
;; for test-divisor should not be 2, 3, 4, 5, 6, …, but rather 2, 3, 5, 7, 9, …. 
;; To implement this change, define a procedure next that returns 3 if its input is equal to 2 and 
;;otherwise returns its input plus 2. Modify the smallest-divisor procedure to use (next test-divisor)
;; instead of (+ test-divisor 1). With timed-prime-test incorporating this modified version of smallest-divisor,
;;  run the test for each of the 12 primes found in Exercise 1.22.
;; Since this modification halves the number of test steps, 
;; you should expect it to run about twice as fast. Is this expectation confirmed?
;; If not, what is the observed ratio of the speeds of the two algorithms, and how do you explain
;; the fact that it is different from 2?

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

(display "We expect the runtime of this algorithim to grow at about square-root(n) / 2")
(newline)
(display "n in this case is the magnitude of the numbers, not the range.")
(newline)
(display "AKA 1,000 vs. 10,000 is a 10x increase in n.")
(newline)
(display "Note that square-root(10)/2 = 1.58113883008")
(newline)
(display "This growth in runtime from group to group is between 2x and 3x.")
(newline)
(display "Comparing the overall numbers from 1.23 vs. 1.22 it is approximately 1/2 faster")
(newline)
(display "It is a little less than twice as fast, I suspect this is because we still have to evaluate the 2 case.")

; Capturing the output of 1.22 for comparision.

  ;; The Primes between 1,000 and 1,020
  ;; 1009 *** 4
  ;; 1013 *** 3
  ;; 1019 *** 3
  ;; 1021 *** 3

  ;; The Primes between 10,000 and 10,050
  ;; 10007 *** 7
  ;; 10009 *** 9
  ;; 10037 *** 8
  ;; 10039 *** 8

  ;; The Primes between 100,000 and 100,050
  ;; 100003 *** 24
  ;; 100019 *** 24
  ;; 100043 *** 24
  ;; 100049 *** 24

  ;; The Primes between 1,000,000 and 1,000,050
  ;; 1000003 *** 76
  ;; 1000033 *** 74
  ;; 1000037 *** 74
  ;; 1000039 *** 75

  ;; We expect the runtime of this algorithim to grow at about square-root(n)
  ;; n in this case is the magnitude of the numbers, not the range. AKA 1,000 vs. 10,000 is a 10x increaseNote that square-root(10) = 3.16227766017
  ;; This growth in runtime between the groups is close to ~3*. 