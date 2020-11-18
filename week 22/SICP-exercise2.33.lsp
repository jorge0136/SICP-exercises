#lang sicp

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map
                      (lambda (x) (cons (car s) x))
                      rest)))))

(subsets '(1 2 3))

; As we progress through the recursion rest becomes
; subsets-1st (2 3)
; subsets-2nd (3)
; subsets-3rd (()) ; (list nil)

; The third subset becomes our base list with an empty list at it's head.
; Unwinding back through the recursion we get car of s, 3, mapped to an empty list so cons of 3 and () => (3) appended to our base list (() (3))
; Next car s is 2 so 2 cons with an empty list (2) and 2 cons with 3 (2 3), apended we have (() (3) (2) (2 3))
; Then the last car of s is 1 so we have cons 1 and (), cons of 1 and 3, cons of 1 and 2, and cons of 1 and (2 3)
; This gives us (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
