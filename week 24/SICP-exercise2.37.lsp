#lang sicp
; Exercise 2.37.  Suppose we represent vectors v = (vi) as sequences of numbers, and matrices m = (mij) as sequences of vectors (the rows of the matrix). For example, the matrix

; 1 2 3 4
; 4 5 6 6
; 6 7 8 9

; is represented as the sequence ((1 2 3 4) (4 5 6 6) (6 7 8 9)). With this representation,
; we can use sequence operations to concisely express the basic matrix and vector operations.
; These operations (which are described in any book on matrix algebra) are the following:

; We can define the dot product as

 (define (dot-product v w)
   (accumulate + 0 (map * v w)))

; Fill in the missing expressions in the following procedures for computing the other matrix operations. (The procedure accumulate-n is defined in exercise 2.36.)

(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence)
                 (accumulate operation initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))


; ****************************************************************************************************************************************
; (define (matrix-*-vector m v)
;   (map <??> m))

; Scale each column vector in a matrix by a vector. I think this is row wise multiplication of each member of the matrix.
; Each entry in the scalar is multipled times each entry of the matrix row, add those together and get the first entry of the outgoing vector.

; m is a matrix of i by j.
; v is a scalar vector j long.

; returning a new vector, do the following...
; for each (car v)
;  (+ (* vj (car mji)).... which is the dot-product. Sneaky. 

 (define (matrix-*-vector matrix scalar-vector)
   (map (lambda (row-vector)
          (dot-product row-vector scalar-vector))
        matrix))

; ****************************************************************************************************************************************
; (define (transpose mat)
;   (accumulate-n <??> <??> mat))

; Take each row and make a new column. accumulate-n does the heavy lifting here. 

 (define (transpose matrix)
   (accumulate-n cons nil matrix))

; ****************************************************************************************************************************************
; (define (matrix-*-matrix m n)
;   (let ((cols (transpose n)))
;     (map <??> m)))

; Is this math right? Are we multiplying by an extra transpose column here?
; Additionally the number of columns of the first matrix must equal the number of rows in the second. Is this just none-sense math? 
 (define (matrix-*-matrix m n)
   (let ((n-columns (transpose n)))
     (map (lambda (m-row-vector)
             (matrix-*-vector n-columns m-row-vector))
          m)))

(define a-fine-matrix (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
(define b-fine-matrix (list (list 1 2 3) (list 5 6 7) (list 9 10 11)))
(newline)
(display a-fine-matrix)
(newline)
(display b-fine-matrix)
(newline)

(matrix-*-vector a-fine-matrix (car a-fine-matrix))
(transpose a-fine-matrix)
(matrix-*-matrix a-fine-matrix b-fine-matrix)