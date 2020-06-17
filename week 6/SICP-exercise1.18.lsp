#lang racket
(require racket/trace)
; Using the results of Exercise 1.16 and Exercise 1.17, 
; devise a procedure that generates an iterative process for multiplying two integers in terms of 
; adding, doubling, and halving and uses a logarithmic number of steps.

  (define (double x) (* x 2))
  (define (halve x) (/ x 2))
  (define (even? n)(= (remainder n 2) 0))

  (define (faster* a b)
    (faster*-iter a b 0))

  ; Is there an invariant quantity in this case?
  (define (faster*-iter a b product)
    (display a)
    (display "\n")
    (display b)
    (display "\n")
    (display product)
    (display "\n")
    (display "\n")
      (cond ((= b 0) product)
          ((even? b) (faster*-iter (double a) (halve b) product))
          (else (faster*-iter  a (- b 1)  (+ a product) ))))

  (trace faster*)
  (eq? 4 (faster* 2 2))
  (eq? 8 (faster* 4 2))
  (eq? 16 (faster* 4 4))
  (eq? 24 (faster* 4 6))
  (eq? 8100 (faster* 450 18))
  (eq? 20000 (faster* 20 1000))

  ;; Useful debug printing block to show internal state of variables between recursive calls. 
