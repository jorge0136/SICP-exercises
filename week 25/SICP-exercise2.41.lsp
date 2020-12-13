#lang sicp

; Exercise 2.41.  Write a procedure to find all ordered triples of distinct positive integers i, j,
; and k less than or equal to a given integer n that sum to a given integer s.

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

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))

(define (permutations s)
  (if (null? s)                    ; empty set?
      (list nil)                   ; sequence containing empty set
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p))
                      (permutations (remove x s))))
               s)))

; --------------- Implementation starts here -------------------

(define (unique l)
  (unique-iter l (list)))

(define (unique-iter l snowflakes)
   (cond ((null? l) snowflakes)
         ((member (car l) (cdr l))
          (unique-iter (cdr l)
                       snowflakes))
         (else (unique-iter (cdr l)
                            (append snowflakes (list(car l)))))))

;(unique (list 1 2 2 3))

(define (truncate-to-triplet sequence)
  (if (pair? sequence)
      (list (car sequence) (cadr sequence) (car (cdr (cdr sequence))))
      nil))

(define (unique-triples n)
  (unique (map truncate-to-triplet
                    (permutations (enumerate-interval 1 n)))))

(define (sum-equal-s? l s)
  (= s
     (accumulate + 0 l)))

(define (triplets-sum-s  n s) 
  (filter (lambda (triplet)
            (sum-equal-s? triplet s))
          (unique-triples n)))

(triplets-sum-s 3 6)
(triplets-sum-s 5 8)