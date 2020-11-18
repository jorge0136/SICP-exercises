#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))

(define (count-leaves list)
  (accumulate
   (lambda (item accumulator)
     (if
      (pair? item) (+ accumulator (count-leaves item))
      (+ accumulator item))
     )
   0
   list)
)

(count-leaves (list 1 (list 2 (list 3 4))))
; 10
