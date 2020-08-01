#lang sicp
;; Exercise 1.44: The idea of smoothing a function is an important concept in signal processing. If
;; f is a function and dx is some small number, then the smoothed version of f is the function whose
;; value at a point x is the average of f(x−dx), f(x), and f(x+dx). Write a procedure smooth that
;; takes as input a procedure that computes f and returns a procedure that computes the smoothed f.
;; It is sometimes valuable to repeatedly smooth a function (that is, smooth the smoothed function,
;; and so on) to obtain the n-fold smoothed function. Show how to generate the n-fold smoothed
;; function of any given function using smooth and repeated from Exercise 1.43.


(define (compose f g)
  (lambda (x)
    (f (g x)))) 

(define (repeated f n)
  (if (= n 1)
      f
  (compose f (repeated f (- n 1)))))

(define (average a b c)
  (/ (+ a b c)
     3))

;; How to get handle around the argument `x` to `f`? Use a lambda. 
(define (smooth f)
   (define dx 0.00001)
   (lambda (x)
     (average (f (- x dx))
              (f x)
              (f (+ x dx)))))

(define (n-fold-smooth f n)
  ((repeated smooth n) f))

;; Stealing testing code from http://wiki.drewhess.com/wiki/SICP_exercise_1.44

(define (impulse-maker a y)
  (lambda (x)
    (if (= x a)
        y
        0)))

(define my-impulse-function
  (impulse-maker 0 6))

(my-impulse-function -1)
(my-impulse-function 0)(newline)

((smooth my-impulse-function) 0)
((smooth (smooth my-impulse-function)) 0)
((smooth (smooth (smooth my-impulse-function))) 0)
((n-fold-smooth my-impulse-function 3) 0)