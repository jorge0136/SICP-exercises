#lang sicp
; Exercise 2.32.  We can represent a set as a list of distinct elements, and we can represent the
; set of all subsets of the set as a list of lists. For example, if the set is (1 2 3), then the
; set of all subsets is (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)).
; Complete the following definition of a procedure that generates the set of subsets of a set
; and give a clear explanation of why it works:

(define (subsets-including-head a b)(cons (car a) b))

(define (subsets s)
  ; base case
  (if (null? s)
      (list nil)
      ; recursive case (subsets excluding head)
      (let ((all-the-rest (subsets (cdr s))))
        (append all-the-rest
                (map (lambda (one-of-the-rest) (subsets-including-head s one-of-the-rest)) all-the-rest)))))

(define test-list (list 1 2 3))
(display test-list)

(subsets test-list)

; To get our subsets we need to combine two lists. subsets excluding head and the subsets including head.
; In this problem we are finding the `Power Set`. https://en.wikipedia.org/wiki/Power_set#:~:text=In%20mathematics%2C%20the%20power%20set,of%20two%20elements%2C%202S.