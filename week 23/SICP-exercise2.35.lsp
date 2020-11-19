#lang sicp

; Exercise 2.35: Redefine count-leaves from 2.2.2 as an accumulation:

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op
                      initial
                      (cdr sequence)))))

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append 
               (enumerate-tree (car tree))
               (enumerate-tree (cdr tree))))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1) (enumerate-tree t))))

(define x (cons (list 1 2) (list 3 4)))

; steps
; first we need to flatten the list with (enumerate-tree t).
; Without this step any pairs will be counted as one leaf.

(enumerate-tree x)

; (1 2 3 4)

; Then we need get an array representing the instances of leaves.
; We use map for this.

(map (lambda (x) 1) (enumerate-tree x))
; (1 1 1 1)

; Finally, we use accumulate to get get a sum of the leaves

(count-leaves x)
; 4