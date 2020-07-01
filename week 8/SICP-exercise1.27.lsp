;; Exercise 1.27.  Demonstrate that the Carmichael numbers listed in footnote
;; 47 really do fool the Fermat test. That is, write a procedure that takes an
;; integer `n` and tests whether `a^n` is congruent to `a%n` for every `a<n`, and
;; try your procedure on the given Carmichael numbers.

(define (fast-expt b n)
  (cond ((= n 0)
         1)
        ((even? n)
         (square (fast-expt b (/ n 2))))
        (else
         (* b (fast-expt b (- n 1))))))

(define (square n) (* n n))

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

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (carmichael-number? n)
  (define (try-it n a)
    (cond ((= a 1) #t)
          ((not (= (expmod a n n) a)) #f)
          (else (try-it n (- a 1)))))
  (try-it n (- n 1)))


; (carmichael-number? 561) => t

; (carmichael-number? 1105) => t
; (carmichael-number? 1729) => t

; 561, 1105, 1729, 2465, 2821, and 6601
