#lang sicp
; Exercise 2.65.  Use the results of exercises 2.63 and  2.64 to give O(n)
; implementations of union-set and intersection-set for sets implemented as (balanced) binary trees.

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

; Could be named "set-builder"
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set) 
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

 (define (tree->list-2 tree)
   (define (copy-to-list tree result-list)
     (if (null? tree)
         result-list
         (copy-to-list (left-branch tree)
                       (cons (entry tree)
                             (copy-to-list (right-branch tree)
                                           result-list)))))
   (copy-to-list tree '()))

; Are we including going into and out of trees in our big O? 
(define set-a (list->tree (list 1 3 5 7 9 11)))
(define set-b (list->tree (list 2 4 6 7 8 11)))

; ****** Union ******

