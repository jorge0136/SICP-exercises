#lang sicp
;; Exercise 1.32

;; 1. Show that sum and product (Exercise 1.31) are both special cases of a still more general notion
;; called accumulate that combines a collection of terms, using some general accumulation function:


;; Accumulate takes as arguments the same term and range specifications as sum and product,
;; together with a combiner procedure (of two arguments) that specifies how the current term is to
;; be combined with the accumulation of the preceding terms and a null-value that specifies what
;; base value to use when the terms run out. Write accumulate and show how sum and product can both
;; be defined as simple calls to accumulate.

(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
         (accumulate combiner null-value term (next a) next b))))

  (define (square a)
    (* a a))
  (define (inc a)
    (+ a 1))

(define (sum x y)
    (+ x y))

(accumulate sum 0 square 1 inc 5)





;; 2. If your accumulate procedure generates a recursive process, write one that generates an
;; iterative process. If it generates an iterative process, write one that generates a recursive
;; process

(define (accumulate-iter combiner non-null term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a non-null))
