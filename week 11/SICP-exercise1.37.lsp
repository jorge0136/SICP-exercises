#lang racket
(require racket/trace)
;; Exercise 1.37.  a. An infinite continued fraction is an expression of the form

;; f = n1 / d1 + n2/ d2 + n3 / d3 + n4 / d4 + n5

;; As an example, one can show that the infinite continued fraction expansion with the Ni and the Di all equal to 1 produces 1/, where  is the golden ratio (described in section 1.2.2). One way to approximate an infinite continued fraction is to truncate the expansion after a given number of terms. Such a truncation -- a so-called k-term finite continued fraction -- has the form


;; Suppose that n and d are procedures of one argument (the term index i) that return the Ni and Di of the terms of the continued fraction. Define a procedure cont-frac such that evaluating (cont-frac n d k) computes the value of the k-term finite continued fraction. Check your procedure by approximating 1/ using

;; (cont-frac (lambda (i) 1.0)
;;            (lambda (i) 1.0)
;;            k)

;; for successive values of k. How large must you make k in order to get an approximation that is accurate to 4 decimal places?

;; b. If your cont-frac procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

;; (n1) / (d1 + n2/ d2) + (n1 / d1)

;;kn is the number of times we loop.
;; d is a procedure to apply.
;; n is a procedure to apply.
(define (cont-frac n d k)
  (cond ((= k 1) (/ (n k) (d k)))
  (/ (n k)
     (+ (d k)
        (cont-frac n d (- k 1))))))

(trace cont-frac)

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           5)
