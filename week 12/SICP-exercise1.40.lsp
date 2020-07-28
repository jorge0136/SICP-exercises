#lang racket

(require racket/trace)
;; 1 Exercise.40: Define a procedure cubic that can be used together with the newtons-method
;; procedure in expressions of the form

;; (newtons-method (cubic a b c) 1)

;; to approximate zeros of the cubic x3+ax2+bx+c.

(define tolerance 0.00001)
(define dx 0.00001)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (newton-transform g)
  (lambda (x)
    (newline)
    (display x)
    (- x (/ (g x) ((deriv g) x)))))


(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (newtons-method g guess)
  (fixed-point (newton-transform g)
               guess))

;; this way of defining it produces the same result it's just a different way of employing cubic

;(define (cubic a b c)
 ; (lambda (x) 
    ; (+ (* x x x) (* a (* x x)) (* b x) c)))

; (newtons-method (cubic 3 -2.4 6) 1)

(define (cubic a b c)
  (newtons-method
   (lambda (x)
      (+ (* x x x) (* a x x) (* b x) c))
   1))

(cubic 3 -2.4 6)




  
