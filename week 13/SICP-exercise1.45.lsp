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
#lang sicp

(define tolerance 0.00001)

(define (compose f g)
  (lambda(x) (f (g x))))


(define (repeated f n)
  (if
   (= n 1) f
   (compose f (repeated f (- n 1)))))


(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average x y)
  (/ (+ x y) 2))

(define (pow x n)
  (if (= n 1) x
      (* (pow x (- n 1)) x)))

(define (average-damp f)
  (lambda (x)
    (average x (f x))))

(define (nth-root-damped x nth)
  (fixed-point
   ((repeated average-damp (floor (log nth 2)))
    (lambda(y) (/ x (pow y (- nth 1)))))
   1.0))

(nth-root-damped 27 256)
