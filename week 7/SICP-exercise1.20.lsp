#lang racket
(require racket/trace)
;; Exercise 1.20: The process that a procedure generates is of course dependent on the rules used by
;; the interpreter. As an example, consider the iterative gcd procedure given above. Suppose we were
;; to interpret this procedure using normal-order evaluation, as discussed in 1.1.5.
;; (The normal-order-evaluation rule for if is described in Exercise 1.5.) Using the substitution
;; method (for normal order), illustrate the process generated in evaluating (gcd 206 40) and
;; indicate the remainder operations that are actually performed.

;; How many remainder operations are
;; actually performed in the normal-order evaluation of (gcd 206 40)? In the applicative-order
;; evaluation?

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(trace gcd)
(gcd 206 40)

;; Applicative Order

;A  (gcd 206 40)
;   (remainder 206 40) == 6 ; 1 remainder

;B  (gcd 40 6)
;   (remainder 40 6) == 4 ; 2 remainder

;C  (gcd 6 4)
;   (remainder 6 4) == 2 ; 3 remainder

;D  (gcd 4 2)
;   (remainder 4 2) == 0 ; 4 remainder

;F  (gcd 2 0)
; > 2

; Using Applicative Order evaluation, remainder is called 4 times.

;; Normal Order

;A  (gcd 206 40)
;   if (= 40 0)

;B  (gcd 40
;        (remainder 206 40))
;   if (= (remainder 206 40) 0) ;; 1 more `remainder`  evaluation while assessing b. 1 total
;   if (= 6 0)

;C  gcd((remainder 206 40)
;       (remainder 40 (remainder 206 40)))
;   if(= (remainder 40 ( remainder 206 40)) 0);; 2 more `remainder` evaluations while assessing b. 3 total
;   if (= 4 0)

;D  gcd((remainder 40 (remainder 206 40))
;       (remainder( (remainder 206 40) (remainder 40 (remainder 206 40)))))
;   if(= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0);; 4 more `remainder` evaluations while assessing b. 7 total
;   if (= 2 0)

;E  gcd((remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
;       (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
;   if(= (remainder (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))) 0) ;; 7 extra `remainder` evaluations while assessing b. 14 total
;   if (= 0 0)
;   (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) ;; 4 more `remainder` evaluations while assessing a. 18 total
; > 2

; Using Normal Order evaluation, remainder is called 18 times.
