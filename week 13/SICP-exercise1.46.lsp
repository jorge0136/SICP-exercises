#lang racket
;; Exercise 1.46: Several of the numerical methods described in this chapter are instances of an
;; extremely general computational strategy known as iterative improvement. Iterative improvement
;; says that, to compute something, we start with an initial guess for the answer, test if the guess
;; is good enough, and otherwise improve the guess and continue the process using the improved guess
;; as the new guess. Write a procedure iterative-improve that takes two procedures as arguments: a
;; method for telling whether a guess is good enough and a method for improving a guess.
;; Iterative-improve should return as its value a procedure that takes a guess as argument and keeps
;; improving the guess until it is good enough. Rewrite the sqrt procedure of 1.1.7 and the
;; fixed-point procedure of 1.3.3 in terms of iterative-improve.


;; From 1.1.7

(define (sqrt-iter guess x)
   (if (good-enough? guess x)
       guess
       (sqrt-iter (improve guess x)
                  x)))

(define (improve guess x)
   (average guess (/ x guess)))

(define (average x y)
   (/ (+ x y) 2))

(define (good-enough? guess x)
 (< (abs (- (square guess) x)) 0.001))

(define (square x) (* x x))


; fixed-point procedure from SICP 1.3.3

(define tolerance 0.00001)

(define (fixed-point-og f first-guess)
   (define (close-enough? v1 v2)
     (< (abs (- v1 v2)) tolerance))
   (define (try guess)
     (let ((next (f guess)))
       (if (close-enough? guess next)
           next
           (try next))))
   (try first-guess))


;; here's the helper function

(define (iterative-improve good-enough? improve)
  (define (iterate guess)
    (if (good-enough? guess)
        guess
        (iterate (improve guess))))
  iterate)

;; reimplementation of sqrt

(define (sqrt x)
  ((iterative-improve
    ;; first define the good enough lambda
    (lambda (guess)
       (< (abs (- (square guess) x)) tolerance))
    ;; next define the improve guess lambda
    (lambda (guess)
        (average guess (/ x guess))))
   ;; the 1.0 represents the initial guess
   1.0))


(sqrt 25)


;; reimplementation of fixed-point

(define (fixed-point f initial-guess)
  ((iterative-improve
     (lambda (guess)
       (< (abs (- (square guess) guess)) tolerance))
     (lambda (guess)
       (f guess)))
     initial-guess))

;; this seems to be getting stuck in a never ending loop. I think I might need to add average damp?

(fixed-point (lambda (y)(+ 1.0 (/ 1.0 y))) 2.0)


  






  
  
