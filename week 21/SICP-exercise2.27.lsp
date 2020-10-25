; Exercise 2.27: Modify your reverse procedure of Exercise 2.18 to produce a deep-reverse procedure
; that takes a list as argument and returns as its value the list with its elements reversed and
; with all sublists deep-reversed as well. For example,

; (define x (list (list 1 2) (list 3 4)))

; x ((1 2) (3 4))

; (reverse x) ((3 4) (1 2))

; (deep-reverse x) ((4 3) (2 1))
#lang sicp

(define (deep-reverse list)
  (define (reverse-iter item new-list)
    (cond ((null? item) new-list)
          ((not (pair? item)) item)
          (else
           (reverse-iter (cdr item) (cons (deep-reverse (car item)) new-list)))))
  (reverse-iter list nil))

:define x
  (list (list 1 2) (list 3 4)))

(deep-reverse x) ;((4 3) (2 1))
