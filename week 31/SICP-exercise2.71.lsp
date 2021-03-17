#lang sicp
; Exercise 2.71.  Suppose we have a Huffman tree for an alphabet of n symbols, and that the
; relative frequencies of the symbols are 1, 2, 4, ..., 2n-1. Sketch the tree for n=5; for n=10.
; In such a tree (for general n) how many bits are required to encode the most frequent symbol?
; the least frequent symbol?

; 2 ^ (5 - 1) = 16

;                                               (n=1 n=2 n=3 n=4 n=5) 31
;                                                   /            \
;                                            leaf n=5 16    (n=1 n=2 n=3 n=4) 15
;                                                              /             \
;                                                        leaf n=4 8        (n=1 n=2 n=3) 7
;                                                                            /          \
;                                                                      leaf n=3 4    (n=1 n=2) 3
;                                                                                     /        \
;                                                                                leaf n=1 1  leaf n=2 2                  

; 2 ^ (10 - 1) = 512
;(define n-alphabet '((n=10 512)
;                     (n=9 256)
;                     (n=8 128)
;                     (n=7 64)
;                     (n=6 32)
;                     (n=5 16)
;                     (n=4 8)
;                     (n=3 4)
;                     (n=2 2)
;                     (n=1 1)))
;(display (generate-huffman-tree n-alphabet))

;                                       (n=1 n=2 n=3 n=4 n=5 n=6 n=7 n=8 n=9 n=10) 1023
;                                       /                             \
;                           leaf n=10 512                          (n=1 n=2 n=3 n=4 n=5 n=6 n=7 n=8 n=9) 511
;                                                                      /                                  \
;                                                             leaf n=9 256                          (n=1 n=2 n=3 n=4 n=5 n=6 n=7 n=8) 255
;                                                                                                     /          \
;                                                                                           leaf n=8 128        (n=1 n=2 n=3 n=4 n=5 n=6 n=7) 127
;                                                                                                                /                             \
;                                                                                                             leaf n=7 64                   (n=1 n=2 n=3 n=4 n=5 n=6) 63)
;                                                                                                                                            /                       \
;                                                                                                                                     leaf n=6 32            (n=1 n=2 n=3 n=4 n=5) 31
;                                                                                                                                                                /                 \
;                                                                                                                                                          leaf n=5 16    (n=1 n=2 n=3 n=4) 15
;                                                                                                                                                                              /             \
;                                                                                                                                                                         leaf n=4 8        (n=1 n=2 n=3) 7
;                                                                                                                                                                                               /          \
;                                                                                                                                                                                       leaf n=3 4    (n=1 n=2) 3
;                                                                                                                                                                                                       /        \
;                                                                                                                                                                                                leaf n=1 1  leaf n=2 2     
;
; In such a tree (for general n) how many bits are required to encode the most frequent symbol?
;       1 bit for the most frequently used symbol.

; The least frequent symbol?
;     Looking at the encodings for n=5 we get `0, 10, 110, 1110, and 1111`. Which means our least frequent symbol is n - 1 bits. 
;     A nice explination is that the nature of this huffman tree is that each new `n` added creates a new leaf node, increasing the tree bepth by one.  


