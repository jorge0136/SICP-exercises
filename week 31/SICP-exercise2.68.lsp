#lang sicp
; Exercise 2.68.  The encode procedure takes as arguments a message and a tree and produces the list of bits that gives the encoded message.

 (define (encode message tree)
   (if (null? message)
       '()
       (append (encode-symbol (car message) tree)
               (encode (cdr message) tree))))

; Encode-symbol is a procedure, which you must write, that returns the list of bits that encodes a given symbol according to a given tree.
; You should design encode-symbol so that it signals an error if the symbol is not in the tree at all. Test your procedure by encoding the
; result you obtained in exercise 2.67 with the sample tree and seeing whether it is the same as the original sample message.\

(define (symbols-match? symbol tree)
  (element-of-set? symbol (symbols tree)))

; Given a Huffman tree, we can find the encoding of any symbol by starting at the root and moving down until we reach the leaf that
; holds the symbol. Each time we move down a left branch we add a 0 to the code, and each time we move down a right branch we add a 1.
; (We decide which branch to follow by testing to see which branch either is the leaf node for the symbol or contains the symbol in its set.)

; I can't help but feel that I have more cases than are needed. Can I simplify this procedure? 
(define (encode-symbol symbol tree)
  (define (encode-symbol-iter symbol tree encoding)
    (cond ((leaf? tree) encoding)
          ((symbols-match? symbol (left-branch tree)) (encode-symbol-iter symbol
                                                                          (left-branch tree)
                                                                          (append encoding (list '0))))
          ((symbols-match? symbol (right-branch tree)) (encode-symbol-iter symbol
                                                                           (right-branch tree)
                                                                           (append encoding (list '1))))
          (else (error "ERROR: The following symbol is not in the huffman tree -- " symbol ))))
  (encode-symbol-iter symbol tree '()))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

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

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

;(symbols (cadr sample-tree))
;(element-of-set? 'A (car sample-tree))
;(element-of-set? 'Z (car sample-tree))
(left-branch sample-tree)
(left-branch (right-branch sample-tree))

(encode (list 'A) sample-tree)
(encode (list 'B) sample-tree)
(encode (list 'C) sample-tree)
; Expected error thrown from this test case. 
;(encode (list 'Z) sample-tree)

(define 2.67-message (list 'A 'D 'A 'B 'B 'C 'A))
(encode 2.67-message sample-tree)

(define 2.67-encoding '(0 1 1 0 0 1 0 1 0 1 1 1 0))
2.67-encoding