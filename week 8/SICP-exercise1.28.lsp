#lang racket
(require racket/trace)

; Exercise 1.28: One variant of the Fermat test that cannot be fooled is called the Miller-Rabin
; test (Miller 1976; Rabin 1980). This starts from an alternate form of Fermat’s Little Theorem,
; which states that if n is a prime number and a is any positive integer less than n, then a raised
; to the (n−1)-st power is congruent to 1 modulo n. To test the primality of a number n by the
; Miller-Rabin test, we pick a random number a<n and raise a to the (n−1)-st power modulo n using
; the expmod procedure. However, whenever we perform the squaring step in expmod, we check to see
; if we have discovered a “nontrivial square root of 1 modulo n,” that is, a number not equal to 1
; or n−1 whose square is equal to 1 modulo n. It is possible to prove that if such a nontrivial
; square root of 1 exists, then n is not prime. It is also possible to prove that if n is an odd
; number that is not prime, then, for at least half the numbers a<n, computing an−1 in this way
; will reveal a nontrivial square root of 1 modulo n. (This is why the Miller-Rabin test cannot be
; fooled.) Modify the expmod procedure to signal if it discovers a nontrivial square root of 1, and
; use this to implement the Miller-Rabin test with a procedure analogous to fermat-test. Check your
; procedure by testing various known primes and non-primes. Hint: One convenient way to make expmod
; signal is to have it return 0.


(define (miller-rabin-tries? n times)
  (cond ((= times 0) #t)
        ((fermat-test n)
         (miller-rabin-tries? n (- times 1)))
        (else #f)))



(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))


(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
           (non-trivial-sqrt (expmod base (/ exp 2) m) m))
        (else
         (remainder
          (* base (expmod base (- exp 1) m))
          m))))


(define (non-trivial-sqrt expmod_value m)
  (if (and (not (or (= expmod_value 1)
                    (= expmod_value (- m 1))))
           (= (remainder (* expmod_value expmod_value) m) 1))
      0
      (remainder (square expmod_value) m)))



(define (square x)
  (* x x))

; all of the below return false
(display 561) (display " result: ") (miller-rabin-tries? 561 10)
(display 1105) (display " result: ")(miller-rabin-tries? 1105 10)
(display 1729) (display " result: ")(miller-rabin-tries? 1729 10)
(display 2465) (display " result: ")(miller-rabin-tries? 2465 10)
(display 2821) (display " result: ")(miller-rabin-tries? 2821 10)
(display 6601) (display " result: ")(miller-rabin-tries? 6601 10)

; trying some primes

(display 13) (display " result: ")(miller-rabin-tries? 13 10)

; You need to test the miller-rabin test multiple times otherwise the results are varied

; 561 result: #f
; 1105 result: #f
; 1729 result: #f
; 2465 result: #f
; 2821 result: #f
; 6601 result: #f
; 13 result: #t
