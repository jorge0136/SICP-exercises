#lang sicp
;Exercise 2.33.  Fill in the missing expressions to complete the following definitions of some basic list-manipulation operations as
; accumulations:

(define (square x)(* x x))

(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence)
                 (accumulate operation initial (cdr sequence)))))

;(accumulate + 0 (list 1 2 3 4 5))
;15
;(accumulate * 1 (list 1 2 3 4 5))
;120
;(accumulate cons nil (list 1 2 3 4 5))

(define (new-map p sequence)
  (accumulate (lambda (sequence-item accumulator) (cons (p sequence-item) accumulator))
              nil
              sequence))

(define (square-list-2 items)
  (new-map square items))

(define one-seven (list 1 2 3 4 5 6 7))
(square-list-2 one-seven)

(define (append seq1 seq2)
  (accumulate cons seq1 seq2))

(append one-seven
        (square-list-2 one-seven))

(define (length sequence)
  (accumulate (lambda (_ accumulator) (+ 1 accumulator))
              0
              sequence))

(length one-seven)