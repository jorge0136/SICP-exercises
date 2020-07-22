#lang sicp
;; Exercise 1.36.  Modify fixed-point so that it prints the sequence of approximations it generates,
;; using the newline and display primitives shown in exercise 1.22.
;; Then find a solution to x^x = 1000 by finding a fixed point of x -> log(1000)/log(x).
;; (Use Scheme's primitive log procedure, which computes natural logarithms.)
;; Compare the number of steps this takes with and without average damping.
;; (Note that you cannot start fixed-point with a guess of 1, as this would cause division by log(1) = 0.)

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (display guess)
      (newline)
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;; No damping. 
(define (x_to_x_equals_1000_solver)
  (fixed-point (lambda (x) ( / (log 1000) (log x))) 2.0))

(x_to_x_equals_1000_solver)

;; Average damping...
;; Add x to both sides of the equation and divide by 2.

;; TODO: Better name for x_1 in average_damp? Is there another more clean way to abstract it out? 
(define (damped_x_to_x_equals_1000_solver)
  (define(halve x) (/ x 2))
  (define (average_damp x x_1) (halve ( + x x_1)))
  (fixed-point (lambda (x) (average_damp x (/ (log 1000) (log x))))
               2.0))
(newline)
(damped_x_to_x_equals_1000_solver)
