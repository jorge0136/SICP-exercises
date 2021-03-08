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

(define (adjoin-record-to-db x record-db)
  (let 
      ((x-key (key x)))
  (cond ((null? record-db) (make-record-tree x '() '()))
        ((= x-key (key (entry record-db))) record-db)
        ((< x-key (key (entry record-db)))
         (make-record-tree (entry record-db) 
                    (adjoin-record-to-db x (left-branch record-db))
                    (right-branch record-db)))
        ((> x-key (key (entry record-db)))
         (make-record-tree (entry record-db)
                    (left-branch record-db)
                    (adjoin-record-to-db x (right-branch record-db)))))))

; TODO: Have a method for ensuring the building of the tree is balanced. Skipping for now. 
(define record-jill (make-record 1 "Jill"))
(define record-bill (make-record 2 "Bill"))
(define record-phil (make-record 3 "Phil"))

; Giving up on attempting to create balanced constructor for the moment. 
(define record-db (list record-jill (list record-bill '() '()) (list record-phil '() '())))
;(define (element-of-set0? x set)
;  (cond ((null? set) false)
;        ((equal? x (car set)) true)
;        (else (element-of-set? x (cdr set)))))
;
;(define (key0 record)
;  (car record))
;(define (lookup0 given-key set-of-records)
;  (cond ((null? set-of-records) false)
;        ((equal? given-key (key0 (car set-of-records)))
;         (car set-of-records))
;        (else (lookup0 given-key (cdr set-of-records)))))
;
;(define (entry tree) (car tree))
;(define (left-branch tree) (cadr tree))
;(define (right-branch tree) (caddr tree))
;
;(define (element-of-set? x set)
;  (cond ((null? set) false)
;        ((= x (entry set)) true)
;        ((< x (entry set))
;         (element-of-set? x (left-branch set)))
;        ((> x (entry set))
;         (element-of-set? x (right-branch set)))))
;
;(define (key tree) (car tree))
;(define (left-branch tree) (cadr tree))
;(define (right-branch tree) (caddr tree))
;
;(define (lookup given-key set-of-records)
;  (cond ((null? set-of-records) false)
;        ((= given-key (key set-of-records)) true)
;        ((< given-key (entry set-of-records))
;         (element-of-set? given-key (left-branch set-of-records)))
;        ((> given-key (entry set-of-records))
;         (element-of-set? given-key (right-branch set-of-records)))))
;
;



