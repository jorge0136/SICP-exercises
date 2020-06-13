#lang racket

(require racket/trace)

(define (expt b n) 
  (invar-quant b n 1))

(define (invar-quant b n a)
  (cond ((= n 0) 
         a)
        ((even? n) 
         (invar-quant (* b b) (/ n 2) a))
        (else 
         (invar-quant b (- n 1) (* a b)))))

(trace invar-quant)

(expt 2 5)


