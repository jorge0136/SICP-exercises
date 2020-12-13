#lang sicp

; Exercise 2.40.  Define a procedure unique-pairs that, given an integer n, generates the sequence of pairs (i,j)
; with 1 <= j < i<= n. Use unique-pairs to simplify the definition of prime-sum-pairs given above. See book for more.

; Translating the requirements, we need to create procedure that takes one argument n.
; We should return a list of lists that are all of the unique pairs of numbers from 1 --> n. 

; ****** `prime?` boiler plate. ****** 
(define ( square x ) (* x x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        ; Here is what is different for this problem. 
        ((even? test-divisor) (find-divisor n (+ test-divisor 1)) )
        (else (find-divisor n (+ test-divisor 2)))))
(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

; ****** accumulate and flatmap implementation boiler plate.

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

; **** Boiler plate for solving prime-sum-pairs

(define (permutations s)
  (if (null? s)                    ; empty set?
      (list nil)                   ; sequence containing empty set
      (flatmap (lambda (x)
                 (map (lambda (p) (cons x p)) ; loop over the inner list. 
                      (permutations (remove x s))))
               s)))

(define (remove item sequence)
  (filter (lambda (x) (not (= x item)))
          sequence))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

; **** Actual problem code

; Note I reimplemented this problem after solving 2.41
; `unique` makes this problem much, much simpler.

(define (unique l)
  (unique-iter l '() ))

(define (unique-iter l snowflakes)
   (cond ((null? l) snowflakes)
         ((member (car l) (cdr l))
          (unique-iter (cdr l)
                       snowflakes))
         (else (unique-iter (cdr l)
                            (append snowflakes (list(car l)))))))

(define (truncate-to-pair l)
  (list (car l) (cadr l)))

(define (unique-pairs n)
  (unique (map truncate-to-pair
               (permutations (enumerate-interval 1 n)))))

;(unique-pairs 5)
;(unique-pairs 3)

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))

(prime-sum-pairs 6)