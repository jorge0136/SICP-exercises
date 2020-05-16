#lang racket
(require racket/trace)

;; Exercise 1.9. Trace

;; Note in racket the `inc` and `dec` were replaced with `add1` and `sub1`. 
(define (recursive-sum a b)
  (if (= a 0)
      b
      (add1 (recursive-sum (sub1 a) b))))

(trace recursive-sum)
(recursive-sum 4 5)

(define (iterative-sum a b)
  (if (= a 0)
      b
      (iterative-sum (sub1 a) (add1 b))))

(trace iterative-sum)
(iterative-sum 4 5)
