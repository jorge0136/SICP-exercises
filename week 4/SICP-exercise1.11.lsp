#lang racket
(require racket/trace)
;; Exercise 1.11.  A function f is defined by the rule that f(n) = n if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3) if n> 3. Write a procedure that computes f by means of a recursive process.
;; Write a procedure that computes f by means of an iterative process.

(define (f_recursive n)
  (if (< n 3)
      n
      (+ (f_recursive (- n 1))
         (* 2 (f_recursive (- n 2)))
         (* 3 (f_recursive (- n 3))))))

(f_recursive 0)
(f_recursive 2)
(f_recursive 3)
 ;; 2 + 2 * 1 + 2 * 0 --> 4
(trace f_recursive)
(f_recursive 4)
 ;; (f_recursive 3) + 2 * (f_recursive 2) + 3 * (f_recursive 1) == 11

(define (f_iterative n)
  (if (< n 3)
    n
    (f_iterator 2  1  0  n)))

(define (f_iterator n  two_times_n  three_times_n  count)
  (if ( < count 3)
    n
    (f_iterator (+  n (* 2 two_times_n) (* 3 three_times_n)) n two_times_n (- count 1))))

(f_iterative 0)
(f_iterative 2)
(f_iterative 3)
(trace f_iterative)
(f_iterative 4)
