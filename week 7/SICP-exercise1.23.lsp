; Exercise 1.23: The smallest-divisor procedure shown at the start of this section does lots of needless testing: After it checks to see if the number is divisible by 2 there is no point in checking to see if it is divisible by any larger even numbers. This suggests that the values used for test-divisor should not be 2, 3, 4, 5, 6, …, but rather 2, 3, 5, 7, 9, …. To implement this change, define a procedure next that returns 3 if its input is equal to 2 and otherwise returns its input plus 2. Modify the smallest-divisor procedure to use (next test-divisor) instead of (+ test-divisor 1). With timed-prime-test incorporating this modified version of smallest-divisor, run the test for each of the 12 primes found in Exercise 1.22. Since this modification halves the number of test steps, you should expect it to run about twice as fast. Is this expectation confirmed? If not, what is the observed ratio of the speeds of the two algorithms, and how do you explain the fact that it is different from 2?
#lang sicp

(define (even? n)
  (= (remainder n 2) 0))

(define (next n)
  (if (= n 2) 3
      (+ n 2)))

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

(define (square n) n * n)

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n)
         n)
        ((divides? test-divisor n)
         test-divisor)
        (else (find-divisor
               n
               (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))


(define (search-for-primes start end )
  (cond
    ((>= start end)  (newline) (display "done"))
    ((even? start) (search-for-primes (+ start 1) end))
      (else
       (timed-prime-test (+ start 2))
       (search-for-primes (+ start 2) end)
      )))

(search-for-primes 1000 1020)
(search-for-primes 10000 10080)
(search-for-primes 100000 100080)


; Prime    New     Old      % better
; 1009 *** 39      62       158
; 1013 *** 39      62       158
; 1019 *** 39      63       161
; 10007 *** 408    606      148
; 10009 *** 369    604      163
; 10037 *** 370    607      164
; 100003 *** 3726  6098     163
; 100019 *** 3674  5923     161
; 100043 *** 3667   5878    160

; We've cut the number of steps in half but added more work with the next procedure.
