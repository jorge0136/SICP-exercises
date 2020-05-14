#lang sicp

(define (square x) (* x x))

(define (improved-good-enough? guess x)
  (< (abs (-  guess  (improve guess x) )) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/
                  (+
                   (/ x (square guess))
                   (* 2 guess))
                  3)))

(define (cube-root-iter guess x)
  (if (improved-good-enough? guess x)
      guess
      (cube-root-iter (improve guess x) x)))

(define (cube-root x)
  (cube-root-iter 1.0 x))


; (cube-root 10000) => 21.54601778725266  (actual) 21.544346900318837

; (cube-root 27) => 3.0018696341051916 (actual) 3

; (cube-root 100000000000) => 4641.5901769101965 (actual) 4,641.588833612778892

; (cube-root 0.00002) => 0.028948265142201245 (actual) 0.027144176165949
