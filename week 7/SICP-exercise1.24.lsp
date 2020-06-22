#lang sicp
;; Exercise 1.24: Modify the timed-prime-test procedure of Exercise 1.22 to use fast-prime? 
;; (the Fermat method), and test each of the 12 primes you found in that exercise.
;; Since the Fermat test has Θ(logn) growth, how would you expect the time to test primes near 
;; 1,000,000 to compare with the time needed to test primes near 1000? Do your data bear this out?
;; Can you explain any discrepancy you find?

(define ( square x ) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m)))) 

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test n)
 (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
 (if (fast-prime? n 1)
     (report-prime (- (runtime)
                      start-time) 
                    n)))
(define (report-prime elapsed-time n)
  (newline)
  (display n)
  (display " *** ")
  (display elapsed-time))

(define (search-for-odd-primes a b)
  (search-for-odd-prime-iter b a)
  (newline)
)

(define (search-for-odd-prime-iter n current-possible-prime)
  (timed-prime-test current-possible-prime)
  (cond ((even? current-possible-prime) (search-for-odd-prime-iter n (+ 1 current-possible-prime)))
        ((>= current-possible-prime n) current-possible-prime)
        ((< current-possible-prime n) (search-for-odd-prime-iter n (+ 2 current-possible-prime)))))

(display "The Primes between 1,000 and 1,020")
(search-for-odd-primes 1000 1020)
(newline)
(display "The Primes between 10,000 and 10,050")
(search-for-odd-primes 10000 10050)
(newline)
(display "The Primes between 100,000 and 100,050")
(search-for-odd-primes 100000 100050)
(newline)
(display "The Primes between 1,000,000 and 1,000,050")
(search-for-odd-primes 1000000 1000050)
(newline)
(display "We expect the runtime of this algorithim to grow at about square-root(n)")
(newline)
(display "n in this case is the magnitude of the numbers, not the range. AKA 1,000 vs. 10,000 is a 10x increase")
(display "Note that square-root(10) = 3.16227766017")
(newline)
(display "This growth in runtime between the groups is ~3* for numbers 10,00 or larger.")
(display "This growth in runtime between 1000 and 10,000 is ~2*.")