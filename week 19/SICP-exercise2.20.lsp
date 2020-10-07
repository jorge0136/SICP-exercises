; Use this notation to write a procedure same-parity that takes one or more integers and returns a
; list of all the arguments that have the same even-odd parity as the first argument. For example,

#lang sicp

(define (filter predicate list)
  (reverse (filter-iter predicate list '())))

(define (filter-iter predicate old-list new-list)
  (if (null? old-list) new-list
      (let* (
             (filtered (predicate (car old-list)))
             (revised-list (if filtered
                               (cons (car old-list) new-list )
                               new-list)))
        (filter-iter predicate (cdr old-list) revised-list))))

(define (same-parity x . y)
  (if (even? x)
      (filter even? y)
      (filter odd? y)
      ))

(same-parity 2 2 3 4) ; => (2 4)
