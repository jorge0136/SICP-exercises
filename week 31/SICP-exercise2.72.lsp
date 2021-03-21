#lang sicp
; Exercise 2.72.  Consider the encoding procedure that you designed in exercise 2.68. What is the
; order of growth in the number of steps needed to encode a symbol? Be sure to include the number of
; steps needed to search the symbol list at each node encountered. To answer this question in
; general is difficult. Consider the special case where the relative frequencies of the n symbols
; are as described in exercise 2.71, and give the order of growth (as a function of n) of the number
; of steps needed to encode the most frequent and least frequent symbols in the alphabet.


; Given a Huffman tree, we can find the encoding of any symbol by starting at the root and moving down until we reach the leaf that
; holds the symbol. Each time we move down a left branch we add a 0 to the code, and each time we move down a right branch we add a 1.
; (We decide which branch to follow by testing to see which branch either is the leaf node for the symbol or contains the symbol in its set.)

;(define (symbols-match? symbol tree)
;  (element-of-set? symbol (symbols tree)))

;(define (no-match-in-entire-tree? symbol tree encoding)
;  (and (not (symbols-match? symbol tree))
;        (null? encoding)))

;(define (encode-symbol symbol tree)
;  (define (encode-symbol-iter symbol tree encoding)
;    (cond ((no-match-in-entire-tree? symbol tree encoding) (error (string-append "ERROR: The following symbol is not in the huffman tree -- " (symbol->string symbol))))
;          ((not (symbols-match? symbol tree)) nil)
;          ((leaf? tree) encoding)
;          ((symbols-match? symbol (left-branch tree)) (encode-symbol-iter symbol
;                                                                          (left-branch tree)
;                                                                          (append encoding (list '0))))
;          ((symbols-match? symbol (right-branch tree)) (encode-symbol-iter symbol
;                                                                           (right-branch tree)
;                                                                           (append encoding (list '1))))))
;  (encode-symbol-iter symbol tree '()))


; A) We search for symbol matching: (element-of-set? of the symbols each node): O(n) time
; B) We do that on each branching node, AKA halving AKA log_n branches
; General Case: O(n * log_n)

; Best case scenario the depth of the tree is 1 (n * 1) = O(n). After we discussed this, if we order the `symbols` in the huffman tree by order of frequency this is O(1). 
; Worse case scenario is like 2.71, where in that problem we already discussed the depth of the tree being n - 1. (n * n -1 ) = O(n ^ 2)
