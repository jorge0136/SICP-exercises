#lang sicp

(define (square i) (* i i ))

(define (cont-frac n d k)
  (define (cont-frac-iter i result)
    (if (= i 0) result
        (cont-frac-iter (- i 1) (/ (n i) (+ (d i) result)))))
  (cont-frac-iter k 0))


(define (tan-cf x k)
  (cont-frac (lambda (i) (if (= i 1) i (- (square i))))
             (lambda (i) (- (* i 2) 1.0))
             k))


(tan-cf 1 8)

(tan 1)
