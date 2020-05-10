#lang sicp
;; *Exercise 1.6
;; Alyssa P. Hacker doesn’t see why `if` needs to
;; be provided as a special form. “Why can’t I just define it as
;; an ordinary procedure in terms of cond?” she asks. Alyssa’s
;; friend Eva Lu Ator claims this can indeed be done, and she
;; defines a new version of if:
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
;; Eva demonstrates the program for Alyssa:
;; (new-if (= 2 3) 0 5)
;;  --> 5
;; (new-if (= 1 1) 0 5)
;;  --> 0
;; Delighted, Alyssa uses new-if to rewrite the square-root
;; program:
;; (define (sqrt-iter guess x)
;; (new-if (good-enough? guess x)
;;                guess
;; (sqrt-iter (improve guess x) x)))
;; What happens when Alyssa attempts to use this to compute
;; square roots? Explain

    ;; First let's replay the above examples. 
    (new-if (= 2 3) 0 5)
    ;; Let's assume that this is evaluated in applicate order. 
    ;;First we **evaluate the arguments**, then we **evaluate the predicate**.     
    (cond ((= 2 3) 0)
          (else 5))
    ;; First we evaluate 0, then 5. After that we evaluate the predicate, which is false, thus 
    ;; the alternative returns. 

    (new-if (= 1 1) 0 5)
    (cond ((= 1 1) 0)
          (else 5))
    ;; predicate is true, thus the consequent returns. 

  ;; let's put the whole problem in code, I think this should be a thought exercise but I am finding
  ;; it useful to write it out. 

  (define ( square x ) (* x x))

  (define (average x y)
    (/ (+ x y) 2))

  (define (improve guess x)
    (average guess (/ x guess)))

  (define (good-enough? guess x)
    (< (abs (- (square guess) x))0.001))

  (define (sqrt-iter guess x)
    (new-if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x) x)))

  (define (sqrt x)
    (sqrt-iter 1.0 x))

  (sqrt 5)

  ;; In applicative order the **arguments to the new-if are evaluated first**. The application 
  ;; rules for the special forms `cond` or `if` are to evaluate the predicate first. Only after the 
  ;; predicate returns true or false are the arguments evaluated. 