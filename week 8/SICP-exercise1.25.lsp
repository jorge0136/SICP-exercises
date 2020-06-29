#lang sicp
;; Exercise 1.25.  Alyssa P. Hacker complains that we went to a lot of extra work
;; in writing expmod. After all, she says, since we already know how to compute
;; exponentials, we could have simply written

;; (define (expmod base exp m)
;;   (remainder (fast-expt base exp) m))

;; Is she correct? Would this procedure serve as well for our fast prime tester?
;; Explain.

  ;; `fast-prime` has Θ(logn) growth.
  ;; `fast-expt` too has Θ(logn) growth.

  ;; This question ends up asking us what is the big Θ of the original expmod procedure.
  ;; Here is the original implementation.

  ;; (define (expmod base exp m)
  ;;   (cond ((= exp 0) 1)
  ;;         ((even? exp)
  ;;         (remainder (square (expmod base (/ exp 2) m))
  ;;                     m))
  ;;         (else
  ;;         (remainder (* base (expmod base (- exp 1) m))
  ;;                     m))))

  ;; Here is a summarized difference for fast-expt

;;   (define (expmod base exp m)
;;    (remainder (fast-expt base exp) m))

;; (define (fast-expt b n)
;;    (cond ((= n 0) 1)
;;          ((even? n) (square (fast-expt b (/ n 2))))
;;          (else (* b (fast-expt b (- n 1))))))

  ;; The results are fasicnating. The `fast-expt` use in expmod appears to slow it down by at least
  ;; an order of magnitude. I believe this has to be in the way the the recursion chain builds up the
  ;; square and other simple arthimetic. Looking up others solution, indeed there is an answer to this:

  ;; https://billthelizard.blogspot.com/2010/02/sicp-exercise-125-closer-look-at-expmod.html

  ;; The answer is buried in a footnote to the expmod code (#46).
  ;; The reduction steps in the cases where the exponent e is greater than 1 are based on the fact that,
  ;; for any integers x, y, and m, we can find the remainder of x times y modulo m by computing
  ;; separately the remainders of x modulo m and y modulo m, multiplying these, and then taking the
  ;; remainder of the result modulo m. For instance, in the case where e is even, we compute the
  ;; remainder of be/2 modulo m, square this, and take the remainder modulo m. This technique is useful
  ;; because it means we can perform our computation without ever having to deal with numbers much
  ;; larger than m.

  ;; Phrased another way we can say that squaring the number prior to finding it's remainder means
  ;; that the number becomes much larger and we must do significantly more work when finding the
  ;; remainder of a very large number, as opposed to doing a modulo several times.

  ;;;; Below is executable to compare the two results. The proposed solution proves to be much slower.

  (define ( square x ) (* x x))

  ;; My implementation of fast-expt. I am taking my linear iterative way of doing it.
  (define (fast-expt b n)
    (cond ((= n 0) 1)
          ((even? n) (square (fast-expt b (/ n 2))))
          (else (* b (fast-expt b (- n 1))))))

  (define (fast-expmod base exp m)
    (remainder (fast-expt base exp) m))

  (define (fast-fermat-test n)
  (define (try-it a)
    (= (fast-expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

  (define (fast-fast-prime? n times)
  (cond ((= times 0) true)
        ((fast-fermat-test n) (fast-fast-prime? n (- times 1)))
        (else false)))

  (define (fast-timed-prime-test n)
  (start-fast-prime-test n (runtime)))
  (define (start-fast-prime-test n start-time)
  (if (fast-fast-prime? n 1)
      (fast-report-prime (- (runtime)
                        start-time)
                      n)))
  (define (fast-report-prime elapsed-time n)
    (newline)
    (display n)
    (display " ***FAST?*** ")
    (display elapsed-time))

  (define (fast-search-for-odd-primes possible-prime n)
    (if (>= possible-prime n)
            possible-prime
            (fast-timed-prime-test possible-prime))
    (cond ((even? possible-prime) (fast-search-for-odd-primes (+ 1 possible-prime) n ))
          ((< possible-prime n) (fast-search-for-odd-primes (+ 2 possible-prime) n ))))

  (define (report-fast-odd-primes a n)
    (display "Implementation with alternative expmod ")
    (display "The Primes between ")
    (display a)
    (display " and ")
    (display n)
    (fast-search-for-odd-primes a n)
    (newline)
    (newline))

  (report-fast-odd-primes 1000 1020)
  (report-fast-odd-primes 10000 10038)
  (report-fast-odd-primes 100000 100045)
  (report-fast-odd-primes 1000000 1000038)

;;;;;;;; 1.24 implementation of fermat below

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

(define (search-for-odd-primes possible-prime n)
  (if (>= possible-prime n)
          possible-prime
          (timed-prime-test possible-prime))
  (cond ((even? possible-prime) (search-for-odd-primes (+ 1 possible-prime) n ))
        ((< possible-prime n) (search-for-odd-primes (+ 2 possible-prime) n ))))

(define (report-odd-primes a n)
  (display "Original implementation!")
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
