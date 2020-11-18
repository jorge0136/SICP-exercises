#lang sicp

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate
             op
             init
             (accumulate
              (lambda (item accumulator)
                (cons (car item) accumulator))
              '() seqs ))
            (accumulate-n
             op
             init
             (accumulate
              (lambda (item accumulator) (cons (cdr item) accumulator))
              '()
              seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define va '(1 2 3))
(define vb '(2 4 6))

(dot-product va vb) ;32

(define (matrix-*-vector m v)
  (map
   (lambda (l)
     (accumulate
      +
      0
      (accumulate-n
       *
       1
       (cons l (list v)))))
   m))

(define matrix '(
                 (1 2 3)
                 (4 5 6)
                 (7 8 9)
                 ))
(define vector '(2 1 3))

(matrix-*-vector matrix vector) ;(13 31 49)

(define (transpose mat)
  (accumulate-n cons '() mat))

(transpose matrix) ;((1 4 7) (2 5 8) (3 6 9))


(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map
     (lambda (m-row)
       (map
        (lambda (n-col) (dot-product m-row n-col))
        cols))
       m)))

(matrix-*-matrix matrix matrix) ;((30 36 42) (66 81 96) (102 126 150))
