#lang racket
(require racket/trace)


;Exercise 1.18: Using the results of Exercise 1.16 and Exercise 1.17, devise a procedure that generates an iterative process for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number of steps.40


(define (halve n)
  (/ n 2))

(define (double n)
  (* n 2))

(define (mulitply a b)
  (multiply-iter a b 0))

(define (multiply-iter a b product)
  (cond ((= b 0)
      product)
        ((even? b)
         (multiply-iter (double a) (halve b) product))
        (else
         (multiply-iter a (- b 1) (+ product a)))))

(trace multiply-iter)

(mulitply 17 19)

