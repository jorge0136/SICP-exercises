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

(define (unique-triples n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k)
                               (cons i (cons j (list k)))
                               )
                             (enumerate-interval (+ j 1) n)
                             )
                        )
                      (enumerate-interval (+ i 1) n)
                      )
             )
           (enumerate-interval 1 n)))

(unique-triples 4) ; ((1 2 3) (1 2 4) (1 3 4) (2 3 4))


(define (find-triple-sum n s)
  (filter (lambda (x) (= (accumulate + 0 x) s)) (unique-triples n))
  )

(find-triple-sum 8 8); ((1 2 5) (1 3 4))
