#lang sicp
; Exercise 2.69.  The following procedure takes as its argument a list of symbol-frequency pairs
; (where no symbol appears in more than one pair) and generates a Huffman encoding tree according to the Huffman algorithm.

; (define (generate-huffman-tree pairs)
;   (successive-merge (make-leaf-set pairs)))

; Make-leaf-set is the procedure given above that transforms the list of pairs into an ordered set of leaves.
; Successive-merge is the procedure you must write, using make-code-tree to successively merge the smallest-weight elements
; of the set until there is only one element left, which is the desired Huffman tree.
; (This procedure is slightly tricky, but not really complicated. If you find yourself designing a complex procedure,
; then you are almost certainly doing something wrong. You can take significant advantage of the fact that we are using
; an ordered set representation.)

(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence)
                 (accumulate operation initial (cdr sequence)))))

(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

; Why not continue to use make-code-tree ? 
(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

; We want to be able to build with.... 
; (generate-huffman-tree (list (list 'A 4) (list 'B 2) (list 'D 1) (list 'C 1)))

; Instead of.... 

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

 (define (generate-huffman-tree pairs)
   (successive-merge (make-leaf-set pairs)))

; Now find two leaves with the lowest weights and merge them to produce a node that has these two nodes as its left and right branches.
; The weight of the new node is the sum of the two weights. Remove the two leaves from the original set and replace them by this new node.
; Now continue this process. At each step, merge two nodes with the smallest weights, removing them from the set and replacing them
; with a node that has these two as its left and right branches. The process stops when there is only one node left, which is the root
; of the entire tree.

; The algorithm does not always specify a unique tree, because there may not be unique smallest-weight nodes at each step. Also, the choice
; of the order in which the two nodes are merged (i.e., which will be the right branch and which will be the left branch) is arbitrary.

(define (last-two-leaves items)
  (define (last-two-leaves-iter items previous)
    (if (null? (cdr items))
      (list previous (car items))
      (last-two-leaves-iter (cdr items) (car items))))
  (last-two-leaves-iter items '()))

(define (merge-symbols last-two-leaves)
  (adjoin-set (symbols (right-branch (last-two-leaves last-two-leaves)))
              (symbols (left-branch (last-two-leaves last-two-leaves)))))

(define (merge-weights last-two-leaves)
  (merged-weights (+ (weight (right-branch (last-two-leaves last-two-leaves)))
                     (weight (left-branch (last-two-leaves last-two-leaves))))))

(define (successive-merge leaf-set)
  ; Merge the two leaves as the new root, pass the leaves through as children.
  (let ((minimum-weight-leaves) (last-two-leaves leaf-set))
        (merged-symbols (merge-symbols minimum-weight-leaves))
        (merged-weights (merge-weights minimum-weight-leaves))
  (make-code-tree (make-leaf merged-symbols merged-weights)
                  (make-code-tree (left-branch (last-two-leaves leaf-set)) (left-branch (last-two-leaves leaf-set))))))
  
; Combine the two lowest leaves as the root of a new tree with the branches being the two leafs of the lowest weight.

; Does our ordered set implementation just a convention of when we call it? If I add `(list 'E 11)`, it doesn't order it....
(make-leaf-set (list (list 'A 4) (list 'B 2) (list 'D 1) (list 'C 1)))
; --> ((leaf A 4) (leaf B 2) (leaf D 1) (leaf C 1)) This will be our input to the `successive-merge` function.

(successive-merge (make-leaf-set (list (list 'A 4) (list 'B 2) (list 'D 1) (list 'C 1))))