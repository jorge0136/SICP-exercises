#lang sicp
;; Exercise 1.35: Show that the golden ratio φ (1.2.2) is a fixed point of the transformation
;; x↦1+1/x, and use this fact to compute φ by means of the fixed-point procedure.


(define (golden-ratio x)
  (fixed-point
   (lambda (y)(+ 1.0 (/ 1.0 y))) 10))


(define tolerance 0.00001)

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

(golden-ratio 9)
(golden-ratio 250)

;; both of the above produce the same result 1.618036.....
