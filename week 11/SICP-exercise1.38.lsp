#lang sicp

(define (cont-frac n d k)
  (define (cont-frac-iter i result)
    (if (= i 0) result
        (cont-frac-iter (- i 1) (/ (n i) (+ (d i) result)))))
  (cont-frac-iter k 0))

(define (euler-seq x)
  (if (= (modulo x 3) 2) (* 2 (ceiling (/ x 3)))
      1))

(define (approximate-e)
  (+ (cont-frac (lambda (i) 1.0)
                euler-seq
                100)
     2))

(approximate-e) ;=> 2.7182818284590455 A.K.A Close enough.
