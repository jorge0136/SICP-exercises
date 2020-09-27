#lang sicp
; Exercise 2.18.  Define a procedure reverse that takes a list as argument and returns a list of
; the same elements in reverse order:

; (reverse (list 1 4 9 16 25))
; (25 16 9 4 1)


(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (reverse items)
 (define (reverse-iter items reversed-list)
    (if (null? items)
        reversed-list
        (reverse-iter (cdr items)
                      (append (list (car items))
                              reversed-list))))
  (reverse-iter items '()))

(define squares (list 1 4 9 16 25))
(reverse squares)
