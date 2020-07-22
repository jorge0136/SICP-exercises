#lang sicp

(define (cont-frac n d k)
  (if (= k 0) 0
   (/ (n k)
      (+ (d k)
         (cont-frac n d (- k 1))))))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           11) ;=> 0.6180555555555556
; 11

(define (cont-frac n d k)
  (define (cont-frac-iter i result)
    (if (= i k) result
        (cont-frac-iter (+ i 1) (/ (n i) (+ (d i) result)))))
  (cont-frac-iter 0 0))

