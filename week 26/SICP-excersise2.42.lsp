#lang sicp

#lang sicp

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low
            (enumerate-interval
             (+ low 1)
             high))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate
                       (cdr sequence))))
        (else  (filter predicate
                       (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

;---------------------------------------------------------------------

(define (make-position row col)
  (cons row col))

(define (get-position-row position)
  (car position))

(define (get-position-col position)
  (cdr position))

(define empty-board nil)

(define (any? collection)
  (accumulate (lambda (a b) (or a b)) #f collection) )

(define (safe? k positions)
  (let* ((kth-queen (car positions))
         (rest-queens (cdr positions)))
    (not (any? (map
                (lambda (attacker) (attack? kth-queen attacker))
                rest-queens)))))

(define (attack? pos1 pos2)
  (or
   (= (get-position-row pos1) (get-position-row pos2))
   (=
    (abs (- (get-position-row pos1) (get-position-row pos2)))
    (abs (- (get-position-col pos1) (get-position-col pos2))))))

(define (adjoin-position row col rest)
  (cons (make-position row col) rest))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row
                    k
                    rest-of-queens))
                 (enumerate-interval  1  board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(queens 4)





