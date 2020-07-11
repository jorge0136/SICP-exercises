;; Exercise 1.32

;; 1. Show that sum and product (Exercise 1.31) are both special cases of a still more general notion
;; called accumulate that combines a collection of terms, using some general accumulation function:

(accumulate
 combiner null-value term a next b)

;; Accumulate takes as arguments the same term and range specifications as sum and product,
;; together with a combiner procedure (of two arguments) that specifies how the current term is to
;; be combined with the accumulation of the preceding terms and a null-value that specifies what
;; base value to use when the terms run out. Write accumulate and show how sum and product can both
;; be defined as simple calls to accumulate.

;; 2. If your accumulate procedure generates a recursive process, write one that generates an
;; iterative process. If it generates an iterative process, write one that generates a recursive
;; process

;;Helpers
(define (identity n) n)
(define (inc n) (+ n 1))

;; Accumulate Recursive
(define (accumulate
 combiner null-value term a next b)
    (if (> a b)
      null-value
      (combiner (term a)
         (accumulate combiner null-value term (next a) next b))))

(accumulate * 1 identity 1 inc 7) ; => 5040

;; Accumulate Iterative
(define (accumulate
 combiner null-value term a next b)
  (define (accumulate-iter n result)
    (if (> n b)
      result
      (accumulate-iter (next n) (combiner result (term n)))))
  (accumulate-iter a null-value))

(accumulate * 1 identity 1 inc 7) ; => 5040
