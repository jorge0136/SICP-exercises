#lang sicp
; Exercise 2.59.  Implement the union-set operation for the unordered-list representation of sets.

; Is the x in the set? 
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

; Add new item to set and return, otherwise return the set unmodifed
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

; Reutrn the deduplicated list of shared elements. 
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)        
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

; Union of a set is the deduplicated list of all members of both groups, shared or not.
; adjoin each element of both lists. 
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (union-set (adjoin-set (car set2)
                               set1)
                   (cdr set2))))

; Right now there isn't any sort of constructor that limits duplication. It's on read, not on write. 

(define a (list 2 3 2 1 3 2 2))
(define b (list 4 5 2 1 4 8 9))

(union-set a b)
