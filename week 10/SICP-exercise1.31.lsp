;; 1.31
;; 1. The sum procedure is only the simplest of a vast number of similar abstractions that can be
;; captured as higher-order procedures. Write an analogous procedure called product that returns
;; the product of the values of a function at points over a given range. Show how to define
;; factorial in terms of product. Also use product to compute approximations to π using the
;; formula.

;;  π/4 = 2⋅4⋅4⋅6⋅6⋅8⋅⋯ / 3⋅3⋅5⋅5⋅7⋅7⋅⋯

#lang racket
(require racket/trace)


(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

 (define (factorial a)
  (define (next a) (+ a 1))
  (define (term a) a)
  (product term 1 next a))

(factorial 5)

(define (square x) (* x x))


(define (wallis-pi n)
  (define (term x)
    (/ (* 4 (square x)) (- (* 4 (square x)) 1)))
  (define (inc x) (+ x 1))
  (* 2.0 (product term 1 inc n)))

(wallis-pi 10)
    

    

;; If your product procedure generates a recursive process, write one that generates an iterative
;; process. If it generates an iterative process, write one that generates a recursive process.

(define (product-iterative term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))


 (define (factorial-iterative a)
  (define (next a) (+ a 1))
  (define (term a) a)
  (product-iterative term 1 next a))

(factorial-iterative 5)







