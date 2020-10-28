#lang sicp
;Exercise 2.27.  Modify your reverse procedure of exercise 2.18 to produce a deep-reverse procedure that takes a
; list as argument and returns as its value the list with its elements reversed and with all sublists deep-reversed as well. For example,
;
;(define x (list (list 1 2) (list 3 4)))
;
;x
;((1 2) (3 4))
;
;(reverse x)
;((3 4) (1 2))
;
;(deep-reverse x)
;((4 3) (2 1))

(define (reverse items)
 (define (reverse-iter items reversed-list)
    (if (null? items)
        reversed-list
        (reverse-iter (cdr items)
                      (append (list (car items))
                              reversed-list))))
  (reverse-iter items '()))

(define (deep-reverse items)
 (define (deep-reverse-iter items reversed-list)
    (if (null? items)
        reversed-list
        (deep-reverse-iter (cdr items)
                      ; Worth splitting single members vs. pairs? Works to send all to reverse. 
                      (append (list (reverse (car items)))
                              reversed-list))))
  (deep-reverse-iter items '()))

(define x (list (list 1 2) (list 3 4)))
;(reverse x)
; --> ((3 4) (1 2))

(deep-reverse x)
; --> ((4 3) (2 1))