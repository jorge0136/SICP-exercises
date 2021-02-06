#lang sicp

; Exercise 2.42. Long solution, I am skipping the problem description. 

; Utility functions needed for solution.
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (append list1 list2)
  (cons (car list1) (append (cdr list1) list2)))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

; Constructor, getters
(define (cons-position row col)
   (cons row col))

(define (position-row position)
   (car position))

(define (position-col position)
   (cdr position))

; Using empty list as an empty board.
(define (empty-board)
  nil)

(define (adjoin-position row col positions)
   (append positions (list (cons-position row col))))

; Is there a queen in the same column? Hmm, adding one queen at a time, I don't think we have to check the column. 
; Is there a queen in the same row?
; Is there a queen in the left diagonal?
; Is there a queen in the right diagonal? 
(define (safe? k positions)
  ; I wish I had binding.pry here.
  positions
  )

; How would this be refactored to use `collect`? 
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(queens 4)
