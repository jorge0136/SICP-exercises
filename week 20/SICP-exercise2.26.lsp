#lang sicp
; Exercise 2.26: Suppose we define x and y to be two lists:

(define x (list 1 2 3))
(define y (list 4 5 6))
; What result is printed by the interpreter in response to evaluating each of the following
; expressions:

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1)
            (append (cdr list1)
                    list2))))

; (append x y)
; (1, 2, 3, 4, 5, 6)

(cons x y)
; ((1 2 3) 4 5 6)
; (( 1 . 2) . 3) . nil))) . 4) . 5) . 6)))
(display "******")

(display (car (cons x y)))
(newline)

(define a (cons 2 3))
(define b (cons 4 5))
(define c (cons a b))
(display c)
(newline)
(display (car c))


; (list x y)
; ((1 2 3) (4 5 6))
