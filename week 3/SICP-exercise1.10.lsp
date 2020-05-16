#lang racket
(require racket/trace)
;; Exercise 1.10.  The following procedure computes a mathematical function called Ackermann's function.

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

;; What are the values of the following expressions?

;; Here is a visualization of this happening: https://gfredericks.com/things/arith/ackermann
(trace A)
(A 1 10)
  ;; (A 0 (A 1 9))
  ;; (A 0 (A 1 (A 1 8)))
  ;; (A 0 (A 1 (A 1 (A 1 7))))
  ;; (A 0 (A 1 (A 1 (A 1 (A 1 6)))))
  ;; (A 0 (A 1 (A 1 (A 1 (A 1 (A 1 5))))))
  ;; (A 0 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 4)))))))
  ;; (A 0 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 3))))))))
  ;; (A 0 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 2)))))))))
  ;; (A 0 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 1))))))))))
  ;; (A 0 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 2)))))))))
  ;; (A 0 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 (A 1 1))))))))))

;; (A 2 4)

;; (A 3 3)

;; Consider the following procedures, where A is the procedure defined above:

;; (define (f n) (A 0 n))

;; (define (g n) (A 1 n))

;; (define (h n) (A 2 n))

;; (define (k n) (* 5 n n))

;; Give concise mathematical definitions for the functions computed by the procedures f, g, and h for positive integer values of n.
;; For example, (k n) computes 5n^2.

;; MY NOTES: 

  ;; There is a function called A. It takes as formal parameters `x`, `y`. 
  ;; This function returns 0 if y == 0. Else if x = 0, it returns 2y. If y == 1, it returns 2. 
  ;; If none of those predicates are true it returns A(x - 1 A(x (y - 1)))
    ;; Which is to say that it recurses twice if x != 0, y != 0 or y != 1. 
