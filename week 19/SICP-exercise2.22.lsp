#lang sicp

; Exercise 2.22: Louis Reasoner tries to rewrite the first square-list procedure of Exercise 2.21
; so that it evolves an iterative process:

(define (square x)
  (* x x))

(define (square-list items)
  (define (iter things answer)
    (display answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))

(square-list (list 1 2 3 4))


; display for answer (1)(4 1)(9 4 1)(16 9 4 1)

; This implementation appends the end of the list to the next element by having answer as the second argument.


; Unfortunately, defining square-list this way produces the answer list in the reverse order of the
; one desired. Why?

; Louis then tries to fix his bug by interchanging the arguments to cons:

(define (square-list-2 items)
  (define (iter things answer)
    (display answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square
                     (car things))))))
  (iter items nil))
; This doesn’t work either. Explain.

(square-list-2 (list 1 2 3 4))

; ()(() . 1)((() . 1) . 4)(((() . 1) . 4) . 9)((((() . 1) . 4) . 9) . 16)
; I think this is a result of instantiating the list with nil?