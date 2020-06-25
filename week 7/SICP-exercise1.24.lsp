#lang sicp

; Exercise 1.24: Modify the timed-prime-test procedure of Exercise 1.22 to use fast-prime? (the
; Fermat method), and test each of the 12 primes you found in that exercise. Since the Fermat test
; has Θ(logn) growth, how would you expect the time to test primes near 1,000,000 to compare with
; the time needed to test primes near 1000? Do your data bear this out? Can you explain any
; discrepancy you find?

(define (square x)
  (* x x))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n times) (fast-prime? n (- times 1)))
        (else false)))

(define (fermat-test n start-time)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))


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

(define (timed-prime-test n start-time)
    (if (fast-prime? n 3)
        (report-prime n (- (runtime) start-time))))

 (define (report-prime n elapsed-time)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time))
    

(timed-prime-test 1009 (runtime))
 (timed-prime-test 1013 (runtime)) 
 (timed-prime-test 1019 (runtime))
 (timed-prime-test 10007 (runtime))
 (timed-prime-test 10009 (runtime))
 (timed-prime-test 10037 (runtime))
 (timed-prime-test 100003 (runtime)) 
 (timed-prime-test 100019 (runtime)) 
 (timed-prime-test 100043 (runtime)) 
 (timed-prime-test 1000003 (runtime))
 (timed-prime-test 1000033 (runtime)) 
 (timed-prime-test 1000037 (runtime)) 


(timed-prime-test 1000 (runtime))

; I'm not seeing any discernable pattern here.
; 1009 *** 119
; 1013 *** 8
; 1019 *** 4
; 10007 *** 6
; 10009 *** 4
; 10037 *** 5
; 100003 *** 5
; 100019 *** 6
; 100043 *** 6
; 1000003 *** 6
; 1000033 *** 6
; 1000037 *** 13
