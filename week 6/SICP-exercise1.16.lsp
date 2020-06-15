#lang racket
(require racket/trace)
; Exercise 1.16: Design a procedure that evolves an iterative exponentiation process 
; that uses successive squaring and uses a logarithmic number of steps, as does fast-expt.
; (Hint: Using the observation that (bn/2)2=(b2)n/2, keep, along with the exponent n and the base b,
;  an additional state variable a, and define the state transformation in such a way that the 
; product ab^n is unchanged from state to state. 
; At the beginning of the process a is taken to be 1, and the answer is given by the value of a at the end of the process. 
; In general, the technique of defining an invariant quantity that remains unchanged from state to state is a powerful way to think about the design of iterative algorithms.)

(define (even? n)
  (= (remainder n 2) 0))

(define ( square x ) 
        (* x x))

(define (fast-expt-iterative b n)
  (fast-expt-iter b n 1))

(define (fast-expt-iter base counter product)
(cond ((= counter 1) product)
      ((even? counter) (fast-expt-iter base 
                        (/ counter 2)
                        (* (square base) product)))
      (else (fast-expt-iter base 
                        (- counter 1)
                        (* base product)))))

;(trace fast-expt-iter)
(fast-expt-iterative 2 2) ; 4
(fast-expt-iterative 3 4) ; 81
(fast-expt-iterative 4 4) ; 256
(fast-expt-iterative 4 6) ; 4096
(fast-expt-iterative 16 3) ; 4096