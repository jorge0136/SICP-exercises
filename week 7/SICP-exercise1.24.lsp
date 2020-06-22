; Exercise 1.24: Modify the timed-prime-test procedure of Exercise 1.22 to use fast-prime? (the Fermat method), and test each of the 12 primes you found in that exercise. Since the Fermat test has Θ(logn) growth, how would you expect the time to test primes near 1,000,000 to compare with the time needed to test primes near 1000? Do your data bear this out? Can you explain any discrepancy you find?
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
  (if (fast-prime? n 100)
      (report-prime (- (runtime)
                       start-time))))
(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (fast-expt b n)
  (cond ((= n 0)
         1)
        ((even? n)
         (square (fast-expt b (/ n 2))))
        (else
         (* b (fast-expt b (- n 1))))))

(define (square n)
  (* n n))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))

;(define (expmod base exp m)
;  (remainder (fast-expt base exp) m))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n)
         (fast-prime? n (- times 1)))
        (else false)))




(define (search-for-primes start end )
  (cond
    ((>= start end)  (newline) (display "done"))
    ((even? start) (search-for-primes (+ start 1) end))
      (else
       (timed-prime-test (+ start 2))
       (search-for-primes (+ start 2) end)
      )))




; (search-for-primes 1000 1020)
; (search-for-primes 10000 10080)
; (search-for-primes 100000 100080)
; (search-for-primes 1000000 1000040)
; 1009 *** 188
; 1013 *** 199
; 1019 *** 207
; 1021 *** 197
; 10007 *** 235
; 10009 *** 229
; 10037 *** 229
; 100003 *** 265
; 100019 *** 271
; 100043 *** 285
; 1000003 *** 305
; 1000033 *** 302
; 1000037 *** 313
; 1000039 *** 321
; done

; I expected 1000000 to be slightly slower than 1000
