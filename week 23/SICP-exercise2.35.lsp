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
      (+ accumulator 1))
     )
   0
   list)
)

(define x (cons (list 1 2) (list 3 4)))
(define y (list 1 (list 2 3) (cons (list 4 5) (list 6 7))))
(count-leaves x) ;4
(count-leaves (list x y)) ;11
