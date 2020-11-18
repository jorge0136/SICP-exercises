; Exercise 2.29: A binary mobile consists of two branches, a left branch and a right branch. Each
; branch is a rod of a certain length, from which hangs either a weight or another binary mobile. We
; can represent a binary mobile using compound data by constructing it from two branches (for
; example, using list):

; (define (make-mobile left right) (list left right)) A branch is constructed from a length (which
; must be a number) together with a structure, which may be either a number (representing a simple
; weight) or another mobile:

; (define (make-branch length structure) (list length structure)) Write the corresponding selectors
; left-branch and right-branch, which return the branches of a mobile, and branch-length and
; branch-structure, which return the components of a branch. Using your selectors, define a
; procedure total-weight that returns the total weight of a mobile. A mobile is said to be balanced
; if the torque applied by its top-left branch is equal to that applied by its top-right branch
; (that is, if the length of the left rod multiplied by the weight hanging from that rod is equal to
; the corresponding product for the right side) and if each of the submobiles hanging off its
; branches is balanced. Design a predicate that tests whether a binary mobile is balanced. Suppose
; we change the representation of mobiles so that the constructors are (define (make-mobile left
; right) (cons left right))

; (define (make-branch length structure) (cons length structure)) How much do you need to change
; your programs to convert to the new representation?
#lang sicp

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define (total-weight mobile)
  (if (integer? mobile) mobile
      (+
       (total-weight (branch-structure (left-branch mobile)))
       (total-weight (branch-structure (right-branch mobile))))))

(define (branch-torque branch)
  (*
   (branch-length branch)
   (total-weight (branch-structure branch))))

(define (balanced? mobile)
  (if (integer? mobile) true
      (and
       (=
        (branch-torque (left-branch mobile))
        (branch-torque (right-branch mobile)))
       (balanced? (branch-structure (left-branch mobile)))
       (balanced? (branch-structure (right-branch mobile))))))

;;;;;;;;;;;;;;;;; Tests ;;;;;;;;;;;;;;;;;

(define simple-mobile (make-mobile
                       (make-branch 2 10)
                       (make-branch 1 20)))

(define another-simple-mobile (make-mobile
                               (make-branch 2 10)
                               (make-branch 1 20)))

(define complex-mobile (make-mobile
                        (make-branch 2 simple-mobile)
                        (make-branch 2 another-simple-mobile)))

(total-weight simple-mobile) ;30
(total-weight complex-mobile) ;60
(balanced? complex-mobile) ; #t

; If we changed the constructors we should only need to change the selectors to return data in the
; previous format.
