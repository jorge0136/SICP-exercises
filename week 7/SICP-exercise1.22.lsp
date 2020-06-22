; Exercise 1.22: Most Lisp implementations include a primitive called runtime that returns an integer that specifies the amount of time the system has been running (measured, for example, in microseconds). The following timed-prime-test procedure, when called with an integer n, prints n and checks to see if n is prime. If n is prime, the procedure prints three asterisks followed by the amount of time used in performing the test.
;
; (define (timed-prime-test n)
;  (newline)
;  (display n)
;  (start-prime-test n (runtime)))
; (define (start-prime-test n start-time)
;  (if (prime? n)
;      (report-prime (- (runtime)
;                       start-time))))
; (define (report-prime elapsed-time)
;  (display " *** ")
;  (display elapsed-time))
; Using this procedure, write a procedure search-for-primes that checks the primality of consecutive odd integers in a specified range. Use your procedure to find the three smallest primes larger than 1000; larger than 10,000; larger than 100,000; larger than 1,000,000. Note the time needed to test each prime. Since the testing algorithm has order of growth of Θ(n⎯⎯√), you should expect that testing for primes around 10,000 should take about 10⎯⎯⎯⎯√ times as long as testing for primes around 1000. Do your timing data bear this out? How well do the data for 100,000 and 1,000,000 support the Θ(n⎯⎯√) prediction? Is your result compatible with the notion that programs on your machine run in time proportional to the number of steps required for the computation?

#lang sicp

(define (even? n)
  (= (remainder n 2) 0))

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
               (+ test-divisor 1)))))

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
(search-for-primes 10000 10039)
(search-for-primes 100000 100043)

; 1003
; 1005
; 1007
; 1009 *** 62
; 1011
; 1013 *** 62
; 1015
; 1017
; 1019 *** 63
; 1021 *** 63
; done

; 10003
; 10005
; 10007 *** 606
; 10009 *** 604
; ...
; 10037 *** 607
; 10039 *** 606
; done
; 100003 *** 6098
; 100005
; 100007
; 100009
; 100011
; 100013
; 100015
; 100017
; 100019 *** 5923
; ...
; 100043 *** 5878
; done
; 1000003 *** 62220
; 1000005
; 1000007
; 1000009
; 1000011
; 1000013
; 1000015
; 1000017
; 1000019
; 1000021
; 1000023
; 1000025
; 1000027
; 1000029
; 1000031
; 1000033 *** 60075
; 1000035
; 1000037 *** 64632
; 1000039 *** 60124
; 1000041
; done

; O(sqrt(n)) time does hold up here.
