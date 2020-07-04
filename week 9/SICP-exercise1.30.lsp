#lang sicp
;; Exercise 1.30.  The sum procedure above generates a linear recursion.
;; The procedure can be rewritten so that the sum is performed iteratively.
;; Show how to do this by filling in the missing expressions in the following definition:

;; (define (sum term a next b)
;;   (define (iter a result)
;;     (if <??>
;;         <??>
;;         (iter <??> <??>)))
;;   (iter <??> <??>))

#lang sicp

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a)))))
    (iter a 0))


(define (inc n) (+ n 1))

(define (square n) (* n n))

(define (sum-squares a b)
  (sum square a inc b))

(sum-squares 1 4) ; -> 30

