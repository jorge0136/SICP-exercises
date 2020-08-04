#lang sicp
;; Exercise 1.44: The idea of smoothing a function is an important concept in signal processing. If
;; f is a function and dx is some small number, then the smoothed version of f is the function whose
;; value at a point x is the average of f(x−dx), f(x), and f(x+dx). Write a procedure smooth that
;; takes as input a procedure that computes f and returns a procedure that computes the smoothed f.
;; It is sometimes valuable to repeatedly smooth a function (that is, smooth the smoothed function,
;; and so on) to obtain the n-fold smoothed function. Show how to generate the n-fold smoothed
;; function of any given function using smooth and repeated from Exercise 1.43.

(define (square x)
  (* x x))


(define dx 0.00001)

(define (smooth f)
  (lambda (x)
    (/ (+ (f x) (f (- x dx)) (f (+ x dx))) 3)))


((smooth square) 5)

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f int)
  (if (= int 1)
      f
      (compose f (repeated f (- int 1)))))


(define (n-smoothed f n)
   ((repeated smooth n) f))

((n-smoothed square 10) 5)
