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
  (let ((items-length (length items)))
  (define (reverse-iter new_list og_list count)
    (if (= 0 count)
      new_list
     (reverse-iter (append new_list (list (list-ref og_list (- 1 count)))) og_list (- 1 count))))
  (reverse-iter (list (last-pair items)) items (- 1 items-length))))


(reverse (list 1 4 9 16 25))

; (list-ref (list 1 3) 1)

; (define items (list 1 2 3))

; (list (last-pair items))

