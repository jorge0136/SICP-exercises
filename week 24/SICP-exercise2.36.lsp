#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate
             op
             init
             (accumulate
              (lambda (item accumulator)
                (cons (car item) accumulator))
              '() seqs ))
            (accumulate-n
             op
             init
             (accumulate
              (lambda (item accumulator) (cons (cdr item) accumulator))
              '()
              seqs)))))

(accumulate-n + 0 '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))

;(22 26 30)
