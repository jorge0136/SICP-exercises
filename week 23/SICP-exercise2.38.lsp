#lang sicp

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op
                      initial
                      (cdr sequence)))))


(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(fold-right / 1 (list 1 2 3)) ; 1 1/2
(fold-left  / 1 (list 1 2 3)) ; 1 1/6
(fold-right list nil (list 1 2 3)) ; (1 (2 (3 ())))

(fold-left  list nil (list 1 2 3)) ; (((() 1) 2) 3)

(fold-left + 0 '(1 2 3)) ;6
(fold-right + 0 '(1 2 3)) ;6
