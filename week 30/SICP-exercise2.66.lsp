#lang sicp
; Exercise 2.66.  Implement the lookup procedure for the case where the set of records is structured
; as a binary tree, ordered by the numerical values of the keys.


(define (key record) (car record))
(define (name record) (cdr record))
(define (make-record id name) (list id name))

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-record-tree root left right)
  (list root left right))

; TODO: Have a method for ensuring the building of the tree is balanced. Skipping for now. 
(define record-jill (make-record 1 "Jill"))
(define record-bill (make-record 2 "Bill"))
(define record-phil (make-record 3 "Phil"))

; Giving up on attempting to create balanced constructor for the moment. 
(define record-db (make-record-tree record-jill (list record-bill '() '()) (list record-phil '() '())))

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((= given-key (key (entry set-of-records))) (entry set-of-records))
        ((< given-key (key (entry set-of-records)))
         (lookup given-key (left-branch set-of-records)))
        ((> given-key (key (entry set-of-records)))
         (lookup given-key (right-branch set-of-records)))))

(lookup 3 record-db)
