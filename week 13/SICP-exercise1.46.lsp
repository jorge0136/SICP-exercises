;; Exercise 1.46: Several of the numerical methods described in this chapter are instances of an
;; extremely general computational strategy known as iterative improvement. Iterative improvement
;; says that, to compute something, we start with an initial guess for the answer, test if the guess
;; is good enough, and otherwise improve the guess and continue the process using the improved guess
;; as the new guess. Write a procedure iterative-improve that takes two procedures as arguments: a
;; method for telling whether a guess is good enough and a method for improving a guess.
;; Iterative-improve should return as its value a procedure that takes a guess as argument and keeps
;; improving the guess until it is good enough. Rewrite the sqrt procedure of 1.1.7 and the
;; fixed-point procedure of 1.3.3 in terms of iterative-improve.
#lang sicp
(define (square x) (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (iterative-improve good-enough? improve)
  (lambda (first-guess)
   (define (try guess)
    (let ((next (improve guess)))
      (if (good-enough? guess next)
          next
          (try next))))
  (try first-guess)))

(define (sqrt x)
  ((iterative-improve (lambda(guess next) (< (abs (- (square next) x)) 0.001))
                      (lambda(guess) (average guess (/ x guess))))
   1.0
  ))

(sqrt 9) ; => 3.00009155413138

(define (fixed-point f first-guess)
  ((iterative-improve (lambda (x y) (< (abs (- x y)) 0.001))
                      (lambda (guess) (f guess)))
  1.0
  ))

(fixed-point cos 1.0) ; => 5.000023178253949
