#lang sicp

; Exercise 2.29: A binary mobile consists of two branches, a left branch and a right branch. Each
; branch is a rod of a certain length, from which hangs either a weight or another binary mobile.
; We can represent a binary mobile using compound data by constructing it from two branches (for
; example, using list):

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (cons length structure))

; A branch is constructed from a length (which must be a number) together with a structure, which
; may be either a number (representing a simple weight) or another mobile:


; 1. Write the corresponding selectors left-branch and right-branch, which return the branches of a
; mobile, and branch-length and branch-structure, which return the components of a branch.

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
 (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))

; (left-branch tree)
; (right-branch tree)

;(branch-length (right-branch tree)))

; 2. Using your selectors, define a procedure total-weight that returns the total weight of a mobile.

(define (total-weight mobile)
  (cond ((null? mobile) 0)
        ((not (pair? mobile)) mobile)
        (else (+ (total-weight (branch-structure (left-branch mobile)))
                 (total-weight (branch-structure (right-branch mobile)))))))

 (define tree (make-mobile (make-branch 1 4) (make-branch 2 1))) 
 (total-weight tree)

; 3. mobile is said to be balanced if the torque applied by its top-left branch is equal to that
; applied by its top-right branch (that is, if the length of the left rod multiplied by the weight
; hanging from that rod is equal to the corresponding product for the right side) and if each of
; the submobiles hanging off its branches is balanced. Design a predicate that tests whether a
; binary mobile is balanced.

(define (torque branch)
  (* (branch-length branch) (total-weight (branch-structure branch))))

(define (balanced? mobile)
  (if (not (pair? mobile))
      true
      (and (= (torque (left-branch mobile)) (torque(right-branch mobile)))
           (balanced? (branch-structure (left-branch mobile)))
           (balanced? (branch-structure (right-branch mobile))))))

       
(balanced? tree)

(define btree (make-mobile (make-branch 1 4) (make-branch 1 4)))

(balanced? btree)
; 4. Suppose we change the representation of mobiles so that the constructors are:

;(define (make-mobile left right)
 ; (cons left right))

;(define (make-branch length structure)
 ; (cons length structure))

; how much do you need to change your programs to convert to the new representation?
