#lang sicp
; Exercise 2.45.  Right-split and up-split can be expressed as instances of a general splitting
; operation. Define a procedure split with the property that evaluating

; (define right-split (split beside below)) (define up-split (split below beside))

; produces procedures right-split and up-split with the same behaviors as the ones already defined.

; We did a simple switch of `below` and `beside` in 2.44. This shows us how to take the common code and give it a name, just passing the differences through.
; This problem is also about how to return a higher order procedure that calls recursively on itself.
; The undeclared depedencies (painter, n) is kinda crazy. 
(define (split painter-transform1 painter-transform2)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split painter-transform1 painter-transform2) painter (- n 1))))
             (painter-transform1 painter (painter-transform2 smaller smaller))))))
