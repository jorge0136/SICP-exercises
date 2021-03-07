#lang sicp

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (entry set)) true)
        ((< x (entry set))
         (element-of-set? 
          x 
          (left-branch set)))
        ((> x (entry set))
         (element-of-set? 
          x 
          (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree 
          (entry set)
          (adjoin-set x (left-branch set))
          (right-branch set)))
        ((> x (entry set))
         (make-tree
          (entry set)
          (left-branch set)
          (adjoin-set x (right-branch set))))))


(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append 
       (tree->list-1 
        (left-branch tree))
       (cons (entry tree)
             (tree->list-1 
              (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list 
         (left-branch tree)
         (cons (entry tree)
               (copy-to-list 
                (right-branch tree)
                result-list)))))
  (copy-to-list tree '()))

; 1) Both procedures are recursive and will build the list from an inorder depth first traversal.
;    Since the left node is always smaller than the root and the right node is always larger than the root,
;    the lists will be built in ascending order.  
(define l1 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ()))))
(define l2 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ())))))
(define l3 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ()))))
(tree->list-1 l1) ; => (1 3 5 7 9 11)
(tree->list-2 l1) ; => (1 3 5 7 9 11)

(tree->list-1 l2) ; => (1 3 5 7 9 11)
(tree->list-2 l2) ; => (1 3 5 7 9 11)
(tree->list-1 l3) ; => (1 3 5 7 9 11)
(tree->list-2 l3) ; => (1 3 5 7 9 11)

; 2) The first method must vist each of the nodes exactly once requiring O(n) steps, however...
;    It uses append which has O(n) runtime, resulting in O(n2) total run time.

;    The second method vists each node exactly once requiring O(n) steps. It uses cons instead which is has
;    an O(1) resulting in a total run time of O(n)

;    The second method will grow more slowly(be more efficient) than the first.

