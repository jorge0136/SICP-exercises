#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (ajoin-set number set)
  (cond ((element-of-set? number set) set)
        ((null? set) (list number))
        ((< number (car set)) (cons number set))
        ((< (car set) number) (cons (car set) (ajoin-set number (cdr set))))
        ))

(ajoin-set 2 '(2 3 4)) ;=> (2 3 4)
(ajoin-set 1 '(2 3 4)) ;=> (1 2 3 4)
(ajoin-set 2 '(1 3 4)) ;=> (1 2 3 4)
(ajoin-set 4 '(1 2 3)) ;=> (1 2 3 4)
