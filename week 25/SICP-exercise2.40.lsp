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
; ******

; Practicing writing and understanding accumulate. 
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

; **** Boiler plate for solving prime-sum-pairs

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
; **** 

; Called easy way, this is merely extracting out and naming the prior procedure. Can we do better? 
(define (unique-pairs-easy-way n)
  (flatmap
   (lambda (i)
     (map (lambda (j) (list i j))
          (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs-easy-way n))))

(prime-sum-pairs 6)

; Boiler plate in an attempt to use permutations. 
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

; generate interval.
; generate all possible pairs. 
; filter to only the unique pairs. Can I come up with a way to keep the uniqued list and compare that with the filter?
; for the uniqueness, order matters...hmmm. 
(define (unique-pairs-ideal-way n)
  (map (lambda(i) (list (car i) (cadr i)))
       (permutations (enumerate-interval 1 n))))

(unique-pairs-ideal-way 5)

