; Exercise 1.16: Design a procedure that evolves an iterative exponentiation process that uses successive squaring and uses a logarithmic number of steps, as does fast-expt. (Hint: Using the observation that (bn/2)2=(b2)n/2, keep, along with the exponent n and the base b, an additional state variable a, and define the state transformation in such a way that the product abn is unchanged from state to state. At the beginning of the process a is taken to be 1, and the answer is given by the value of a at the end of the process. In general, the technique of defining an invariant quantity that remains unchanged from state to state is a powerful way to think about the design of iterative algorithms.)

; Iterative exponentiation O(log(n))
;
; b = 2
; n = 11
;
; a   b     n
; --------------------
; 1 * 2   ^ 11 =  2048
; 2 * 2   ^ 10 =  2048
; 2 * 4   ^ 5  =  2048
; 8 * 4   ^ 4  =  2048
; 8 * 16  ^ 2  =  2048
; 8 * 256 ^ 1  =  2048
;
; even = {
;          b = b²
;          n = n / 2
;          a = a
;        }
; odd = {
;         b = b
;         n = n - 1
;         a = a * b
;       }
;

#lang sicp

(define (square n) (* n  n))

(define (even? n)
  (= (remainder n 2) 0))

(define (fast-expt b n)
  (fast-expt-iter b n 1))

(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
        ((even? n)
         (ifast-expt-iter (square b) (/ n 2) a))
        (else (ifast-expt-iter b (- n 1) (* b a)))))

(fast-expt 23 245)
