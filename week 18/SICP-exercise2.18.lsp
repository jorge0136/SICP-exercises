#lang sicp

; Exercise 2.18: Define a procedure reverse that takes a list as argument and returns a list of the
; same elements in reverse order:

(define (append list1 list2)
  (if (null? list1)
  list2
  (cons (car list1)
        (append (cdr list1)
        list2))))

(define (last-pair items)
  (if (null? (cdr items))
    (car items)
    (last-pair (cdr items))))

(define (length items)
  (if (null? items)
      0
      (+ 1 (length (cdr items)))))


(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items)
                (- n 1))))


(define (reverse items)
  (let ((items-length (length items))
        (last-item (last-pair items)))
  (define (reverse-iter items count))
    (if (= 0 count)
      (cdr items)
      (cons (last-item)
             (reverse-iter items (- 1 count)))
    )
)
(reverse (list 1 4 9 16 25))
