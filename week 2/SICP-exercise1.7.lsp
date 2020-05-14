#lang sicp

(define (square x) (* x x))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improved-good-enough? guess x)
  (< (abs (-  guess  (improve guess x) )) 0.001))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (sqrt-iter guess x)
  (if (improved-good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (sqrt x)
  (sqrt-iter 1.0 x))

(sqrt 10000000000000)

; Original good enough
; ________________________
; (sqrt 0.00002) => 0.03146283571116667  (actual) 0.004472135955

; (sqrt 0.0008) =>  0.03934452001945049 (actual) 0.028284271247462

; (sqrt 10000000000000) => endless loop

;  Improved good enough
; ________________________
; (sqrt 0.00002) => 0.005480229965657565 (actual) 0.004472135955

; (sqrt 0.0008) => 0.028324767875553304  (actual) 0.028284271247462

; (sqrt 10000000000000) => 3162277.6601683795 (actual) 3162277.660168379331999
