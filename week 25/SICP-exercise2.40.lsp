#lang sicp

 (define (square x) (* x x))

 (define (smallest-divisor n)
   (find-divisor n 2))

 (define (find-divisor n test-divisor)
   (cond ((> (square test-divisor) n) n)
         ((divides? test-divisor n) test-divisor)
         (else (find-divisor n (+ test-divisor 1)))))

 (define (divides? a b)
   (= (remainder b a) 0))

 (define (prime? n)
   (= n (smallest-divisor n)))


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

(define (unique-pairs n)
  (flatmap (lambda (i)
         (map (lambda (j)
                (cons i (list j))
                )
              (enumerate-interval (+ i 1) n)
              )
          )
       (enumerate-interval 1 n)))

(unique-pairs 4) ; ((1 2) (1 3) (1 4) (2 3) (2 4) (3 4))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair)
        (cadr pair)
        (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter  prime-sum? (unique-pairs n))))

(prime-sum-pairs 4) ; ((1 2 3) (1 4 5) (2 3 5) (3 4 7))
