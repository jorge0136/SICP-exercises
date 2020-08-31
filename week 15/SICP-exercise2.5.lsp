#lang racket
; Exercise 2.5: Show that we can represent pairs of nonnegative integers using only numbers and
; arithmetic operations if we represent the pair a and b as the integer that is the product 2a3b.
; Give the corresponding definitions of the procedures cons, car, and cdr.

(define (^ base exponent)
   (define (*^ exponent acc)
       (if (= exponent 0)
           acc
           (*^ (- exponent 1) (* acc base))))
   (*^ exponent 1))

; find the number of times each value is divisible 
(define (num-divs n d)
  (define (iter x result)
    (if (= 0 (remainder x d))
        (iter (/ x d) (+ 1 result))
        result))
  (iter n 0))


(define (cons a b)
  (* (^ 2 a)(^ 3 b)))

(define (car z) 
  (num-divs z 2))

(define (cdr z)
  (num-divs z 3))


(car (cons 5 4))
(cdr (cons 5 4))




  



