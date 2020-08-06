#lang sicp

;; Exercise 1.46: Several of the numerical methods described in this chapter are instances of an
;; extremely general computational strategy known as iterative improvement. Iterative improvement
;; says that, to compute something, we start with an initial guess for the answer, test if the guess
;; is good enough, and otherwise improve the guess and continue the process using the improved guess
;; as the new guess. Write a procedure iterative-improve that takes two procedures as arguments: a
;; method for telling whether a guess is good enough and a method for improving a guess.
;; Iterative-improve should return as its value a procedure that takes a guess as argument and keeps
;; improving the guess until it is good enough. Rewrite the sqrt procedure of 1.1.7 and the
;; fixed-point procedure of 1.3.3 in terms of iterative-improve.

(define (square x) (* x x))
(define(halve x) (/ x 2))
(define (average x y) (halve ( + x y)))

;; Returns a procedure that takes a guess.
(define (iterative-improve good-enough? improve) 
  (lambda (guess) 
    (if (good-enough? guess) 
        guess 
        ((iterative-improve good-enough? improve) (improve guess))))) 

(define (close-enough? a b)
  (< (abs (- a b)) 0.00001)) 
  
(define (fixed-point f first-guess) 
  ((iterative-improve 
    (lambda (x) (close-enough? x (f x))) 
    f) 
   first-guess)) 
  
(define (sqrt x) 
  ((iterative-improve 
    (lambda (y) 
      (< (abs (- (square y) x)) 
         0.0001)) 
    (lambda (y) 
      (average y (/ x y)))) 
   1.0))

(sqrt 9) 

