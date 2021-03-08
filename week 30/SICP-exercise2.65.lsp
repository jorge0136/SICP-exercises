#lang sicp
; Exercise 2.65.  Use the results of exercises 2.63 and  2.64 to give O(n)
; implementations of union-set and intersection-set for sets implemented as (balanced) binary trees.

; I initially interperted this problem that should be 100% solved in the tree data structure. After
; monkeying about a bit with that implementation it'll very difficult to get O(n) out of that. 

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
(define balanced-set-a (list->tree (list 1 3 5 7 9 11)))
(define balanced-set-b (list->tree (list 2 4 6 7 8 11)))
(define unbalanced-set-c (list->tree (list 1 2 3 900)))
(define unbalanced-set-d (list->tree (list 2 3 5 7 9 11 13 17 19 25 200 900)))

; ****** Union ******

; tree --> list --> Use union set.
(define (union-set set1 set2)
  (cond ((and (null? set1) (null? set2)) '())
        ((null? set1) set2)
        ((null? set2) set1)
        (else 
     (let ((x1 (car set1)) (x2 (car set2)))
       (cond ((= x1 x2)
              (cons x1 (union-set (cdr set1) (cdr set2))))
             ((< x1 x2)
              (cons x1 (union-set (cdr set1) set2)))
             ((< x2 x1)
              (cons x2 (union-set set1 (cdr set2))))
        )))))

(define (union-trees tree1 tree2)
  (union-set (tree->list-2 tree2)(tree->list-2 tree1)))

(union-trees balanced-set-a balanced-set-b)
(union-trees unbalanced-set-c unbalanced-set-d)

; If you interpret the challenge as finishing with a tree we case use `list-->tree` to go back. 

; ****** Intersection ******
 (define (intersection-set set1 set2) 
   (if (or (null? set1) (null? set2)) 
       '()     
       (let ((x1 (car set1)) (x2 (car set2))) 
         (cond ((= x1 x2) 
                (cons x1 
                      (intersection-set (cdr set1) 
                                        (cdr set2)))) 
               ((< x1 x2) 
                (intersection-set (cdr set1) set2)) 
               ((< x2 x1) 
                (intersection-set set1 (cdr set2))))))) 
  
(define (intersection-tree tree1 tree2)
  (intersection-set (tree->list-2 tree2)(tree->list-2 tree1)))

(intersection-tree balanced-set-a balanced-set-b)
(intersection-tree unbalanced-set-c unbalanced-set-d)
; If you interpret the challenge as finishing with a tree we case use `list-->tree` to go back. 