#lang sicp
;; Exercise 1.27.  Demonstrate that the Carmichael numbers listed in footnote
;; 47 really do fool the Fermat test. That is, write a procedure that takes an
;; integer `n` and tests whether `a^n` is congruent to `a%n` for every `a<n`, and
;; try your procedure on the given Carmichael numbers.

;; https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/congruence-modulo

  (define ( square x ) (* x x))

  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
          (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
          (remainder (* base (expmod base (- exp 1) m))
                      m))))

  (define (congruence-modulo-tester n)
    (display n)
    (newline)
    (newline)
    (congruence-modulo-tester-iter n 1)
    (newline)
  )

  (define (print-true-result n a)
    (display "a: ")
    (display a)
    (display " True " )
    (display n)
    (display "^")
    (display a)
    (display " ≡ ")
    (display a)
    (display " (mod ")
    (display n)
    (display ")")
    (newline)
    (display (expmod a n n))
    (display "=")
    (display (remainder a n))
    (newline)
    ;; Better way to call this?
    (congruence-modulo-tester-iter n (+ a 1)))

  (define (print-false-result n a)
    (display "a: ")
    (display a)
    (display " False ")
    (display n)
    (display "^")
    (display a)
    (display " != ")
    (display a)
    (display " (mod ")
    (display n)
    (display ")")
    (newline)
    (display (expmod a n n))
    (display "!=")
    (display (remainder a n))
    (newline)
    ;; Better way to call this?
    (congruence-modulo-tester-iter n (+ a 1)))

  (define (congruence-modulo-tester-iter n a)
    (cond ((= n a) 1)
          ((= (expmod a n n) (remainder a n))
            (print-true-result n a))
          (else
            (print-false-result n a))))

(congruence-modulo-tester 3)
(congruence-modulo-tester 4)
(congruence-modulo-tester 561)
(congruence-modulo-tester 1105)
(congruence-modulo-tester 1729)
(congruence-modulo-tester 2465)
(congruence-modulo-tester 2821)
(congruence-modulo-tester 6601)
