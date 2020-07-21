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
;; (Note that y = (1/2)(y + x/y) is a simple transformation of the equation y = x/y; to derive it,
;; add y to both sides of the equation and divide by 2.)

;; TODO: Give the damping procedure a name, it's a bit of a mess. 
(define (damped_x_to_x_equals_1000_solver)
  (fixed-point (lambda (x) (/ (+ x
                                (/ (log 1000) (log x)))
                               2))
               2.0))
(newline)
(damped_x_to_x_equals_1000_solver)
