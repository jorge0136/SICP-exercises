#lang sicp
; Exercise 2.70.  The following eight-symbol alphabet with associated relative frequencies was designed to efficiently encode the lyrics of 1950s rock songs. (Note that the ``symbols'' of an ``alphabet'' need not be individual letters.)

; A	2	NA	16
; BOOM	1	SHA	3
; GET	2	YIP	9
; JOB	2	WAH	1
; Use generate-huffman-tree (exercise 2.69) to generate a corresponding Huffman tree, and use encode (exercise 2.68) to encode the following message:

; Get a job

; Sha na na na na na na na na

; Get a job

; Sha na na na na na na na na

; Wah yip yip yip yip yip yip yip yip yip

; Sha boom

; How many bits are required for the encoding? What is the smallest number of bits that would be needed to encode this song if we used a fixed-length code for the eight-symbol alphabet?

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? object)
  (eq? (car object) 'leaf))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)    ; symbol
                               (cadr pair))  ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (is-root? node-set) (null? (cdr node-set)))
(define (tree-trunk node-set) (cddr node-set))
 
(define (successive-merge node-set)
  (cond ((null? node-set) '())
        ((is-root? node-set) (car node-set))
        (else (let ((new-sub-tree (make-code-tree (left-branch node-set)
                                                  (right-branch node-set))))
                (successive-merge
                 (adjoin-set new-sub-tree (tree-trunk node-set)))))))

(define huffman-tree (generate-huffman-tree '((NA 16)
                                              (YIP 9)
                                              (SHA 3)
                                              (GET 2)
                                              (JOB 2)
                                              (A 2)
                                              (WAH 1)
                                              (BOOM 1))))
huffman-tree

; ** Encode ** 
(define (symbols-match? symbol tree)
  (member symbol (symbols tree)))

(define (no-match-in-entire-tree? symbol tree encoding)
  (and (not (symbols-match? symbol tree))
       (null? encoding)))

(define (encode-symbol symbol tree)
  (define (encode-symbol-iter symbol tree encoding)
    (cond ((no-match-in-entire-tree? symbol tree encoding) (error (string-append "ERROR: The following symbol is not in the huffman tree -- " (symbol->string symbol))))
          ((not (symbols-match? symbol tree)) nil)
          ((leaf? tree) encoding)
          ((symbols-match? symbol (left-branch tree)) (encode-symbol-iter symbol
                                                                          (left-branch tree)
                                                                          (append encoding (list '0))))
          ((symbols-match? symbol (right-branch tree)) (encode-symbol-iter symbol
                                                                           (right-branch tree)
                                                                           (append encoding (list '1))))))
  (encode-symbol-iter symbol tree '()))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))
(define sha-na-na '(GET A JOB SHA NA NA NA NA NA NA NA NA GET A JOB SHA NA NA NA NA NA NA NA NA WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP SHA BOOM))
(define encoded-song (encode sha-na-na huffman-tree))
(length encoded-song)
; 84 bits are required to encode this song with huffman encoding.

; For fixed-length encoding, interestingly we only need 3 bits per symbol. I find this unintuitive, as many of the symobls are actually 3 characters long.
; This yields 108 bits if we used fixed length encoding. 
(* 3 (length sha-na-na))
