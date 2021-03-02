#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y) (cons (p x) y))
              nil sequence))

(map inc '(1 2 3))
;(2 3 4)

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(append '(1 2 3) '(4 5 6))
'(1 2 3 4 5 6)

(define (length sequence)
  (accumulate (lambda (_ y) (inc y)) 0 sequence))

(length '(1 2 3 4 5))
; 5
