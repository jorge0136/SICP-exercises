#lang sicp
;; Exercise 1.41: Define a procedure double that takes a procedure of one argument as argument and
;; returns a procedure that applies the original procedure twice. For example, if inc is a procedure
;; that adds 1 to its argument, then (double inc) should be a procedure that adds 2.

;; What value is
;; returned by `(((double (double double)) inc) 5)`?

(define (double f)
  (lambda (x)
    (f (f x)))) 

((double inc) 2)

;;    8              4
(((double (double double)) inc) 5)
;; Adds 16 instead of 1. 
;; Why 16 instead of 8? double doubled a second and then a third time is only 2 * 2 * 2. 