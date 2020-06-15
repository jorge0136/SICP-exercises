#lang racket
(require racket/trace)
; Exercise 1.16: Design a procedure that evolves an iteratively exponentiation process 
; that uses successive squaring and uses a logarithmic number of steps, as does fast-expt.
; (Hint: Using the observation that (bn/2)2=(b2)n/2, keep, along with the exponent n and the base b,
;  an additional state variable a, and define the state transformation in such a way that the 
; product ab^n is unchanged from state to state. 
; At the beginning of the process a is taken to be 1, and the answer is given by the value of a at the end of the process. 
; In general, the technique of defining an invariant quantity that remains unchanged from state to state is a powerful way to think about the design of iteratively algorithms.)

(define (even? n)(= (remainder n 2) 0))
(define ( square x ) (* x x))

(define (fast-expt-iteratively b n)
  (fast-expt-iter b n 1))

;; b is the base
;; n is the exponent or `counter`
;; a is the product which holds the state between iterations. 
(define (fast-expt-iter b n a)
(cond ((= n 0) a)
      ((even? n) (fast-expt-iter (square b) (/ n 2) a))
      (else (fast-expt-iter b (- n 1) (* b a)))))

(trace fast-expt-iter)
(eq? 4 (fast-expt-iteratively 2 2))
(eq? 81 (fast-expt-iteratively 3 4))
(eq? 256 (fast-expt-iteratively 4 4))
(eq? 1024 (fast-expt-iteratively 4 5))
(eq? 4096 (fast-expt-iteratively 4 6))
(eq? 16384 (fast-expt-iteratively 4 7))
(eq? 4096 (fast-expt-iteratively 16 3))

;; Notes: 
  ;; ab^n is the invariant in this case.  