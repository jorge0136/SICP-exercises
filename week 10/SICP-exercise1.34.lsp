#lang sicp
;; Exercise 1.34: Suppose we define the procedure

(define (f g) (g 2))

;; Then we have
(f (lambda(x) (* x x)))
4

(f (lambda (z) (* z (+ z 1))))
6

;; What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.

;; To evaluate a combination, do the following:
;; 1.  Evaluate the subexpressions of the combination.

;; 2.  Apply the procedure that is the value of the leftmost subexpression (the operator) to the arguments that are
;; the values of the other subexpressions (the operands).

;; It would produce a procedure that would produce a procedure of (g 2) Saying we are going to producue the (g(g 2)) doesn't make much sense 
;; TODO: Provide a deeper explination. Trace it? 