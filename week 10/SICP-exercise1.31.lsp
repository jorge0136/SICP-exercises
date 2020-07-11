;; 1.31
;; 1. The sum procedure is only the simplest of a vast number of similar abstractions that can be
;; captured as higher-order procedures. Write an analogous procedure called product that returns
;; the product of the values of a function at points over a given range. Show how to define
;; factorial in terms of product. Also use product to compute approximations to π using the
;; formula.

;;  π/4 = 2⋅4⋅4⋅6⋅6⋅8⋅⋯ / 3⋅3⋅5⋅5⋅7⋅7⋅⋯

;; If your product procedure generates a recursive process, write one that generates an iterative
;; process. If it generates an iterative process, write one that generates a recursive process.

;; Factorial

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (inc n) (+ n 1))

(define (identity n) n)

(define (factorial n)
  (product identity 1 inc n))

(factorial 7) ;=> 5040

;; Approximate PI
(define (numerator-seq n)
  (if (odd? n) (+ 1.0 n)
      (+ n 2.0)))

(define (denominator-seq n)
  (if (odd? n) (+ 2.0 n)
      (+ 1.0 n)))
(define (pi-fraction n)
  (/
   (numerator-seq n)
   (denominator-seq n)))

(define (approx-pi n)
  (product pi-fraction 1 inc n))

(approx-pi 100) ;=> 0.7892575441137911

;; Product Iterative
(define (product term a next b)
  (define (product-iter n result)
    (if (> n b)
        result
        (product-iter (next n) (* result (term n)))))
  (product-iter a 1))
