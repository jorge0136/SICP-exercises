#lang sicp

;; Exercise 1.45: We saw in 1.3.3 that attempting to compute square roots by naively finding a fixed
;; point of y↦x/y does not converge, and that this can be fixed by average damping. The same method
;; works for finding cube roots as fixed points of the average-damped y↦x/y2. Unfortunately, the
;; process does not work for fourth roots—a single average damp is not enough to make a fixed-point
;; search for y↦x/y3 converge. On the other hand, if we average damp twice (i.e., use the average
;; damp of the average damp of y↦x/y3) the fixed-point search does converge. Do some experiments to
;; determine how many average damps are required to compute nth roots as a fixed-point search based
;; upon repeated average damping of y↦x/yn−1. Use this to implement a simple procedure for computing
;; nth roots using fixed-point, average-damp, and the repeated procedure of Exercise 1.43. Assume
;; that any arithmetic operations you need are available as primitives.



(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define(halve x) (/ x 2))
(define (average x y) (halve ( + x y)))

;; y↦x/y
(define (square_root x)
  (fixed-point (lambda (y) (average y (/ x y)))
               1.0))
(square_root 9) ;; 3

;; y↦x/y^2
(define (square x) (* x x))
(define (cube_root x)
  (fixed-point (lambda (y) (average  y (/ x (square y))))
               1.0))

(cube_root 9) ;; 2.08008382305

(define (cube x) (* x x x))
;; y↦x/y^3
(define (fourth_root x)
  (fixed-point (lambda (y) (average y (average y (/ x (cube y)))))
               1.0))

(fourth_root 9) ;; 1.7320508076

(define (to_the_fourth x) (* x x x x))
;; y↦x/y^4
(define (fifth_root x)
  (fixed-point (lambda (y) (average y (average y (/ x (to_the_fourth y)))))
               1.0))

(fifth_root 9) ;; 1.55184557

(define (compose f g)
  (lambda (x)
    (f (g x)))) 

(define (repeated f n)
  (if (= n 1)
      f
  (compose f (repeated f (- n 1)))))
