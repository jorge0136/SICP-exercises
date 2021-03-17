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
;  (member symbol (symbols tree)))

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


; Woof this problem is tough. I am still struggling with my asymtoptic complexity.
; I am also not certain of the complexity of `member`. I suppose that means that I should perhaps use a different, known complexity algorthim.
; I want to talk this one over. http://community.schemewiki.org/?sicp-ex-2.72

; Excerpt from someone else's answer:
; For the encode-symbol procedure in 2.68:
;
; Search the symbol list at each node: O(n) time
; Then take log_n branches
; Total: O(n * log_n) (best case) 
; 