#lang sicp

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

; Exercise 2.64.  The following procedure list->tree converts an ordered list to a balanced binary
; tree. The helper procedure partial-tree takes as arguments an integer n and list of at least
; n elements and constructs a balanced tree containing the first n elements of the list.
; The result returned by partial-tree is a pair (formed with cons) whose car is the constructed
; tree and whose cdr is the list of elements not included in the tree.

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

; a. Write a short paragraph explaining as clearly as you can how partial-tree works.
; Draw the tree produced by list->tree for the list (1 3 5 7 9 11).

; This solution uses what appears to be a lot of wishful thinking and naming to chop up the tree into
; it's consituent parts. First it computes the size of left branch of the tree as "(n - 1) / 2", then
; it builds the left branch of the tree with a recursive call, gives names to the parts that result.
; From those names we can isolate the elements of the right branch and it's size as
; "left branch size + 1". From there we can take the elements of the right branch and it's size and
; again make a recursive call creating the actual right branch. At this point all we are missing is
; the root of the tree and to stitch it together with the elements of the original list greater than
; index of "n"

(list->tree (list 1 3 5 7 9 11))
;             5
;           /    \
;          1      9
;           \    / \
;            3  7  11


; b. What is the order of growth in the number of steps required by list->tree to convert
; a list of n elements?

; My instincts telling me there is halving involved so it should be a function of O(log n).
; but I am constantly wrong about these things: 

; http://wiki.drewhess.com/wiki/SICP_exercise_2.64

; list-tree's order of growth is determined by partial-tree. partial-tree visits each element in the
; original input list exactly once (it must, in order to make each element the entry of a
; node in the balanced tree): this is θ(n) operations. Each visit performs a single cons, which
; requires a constant-factor number of steps for our purposes, so the overall order of growth in
; steps is also θ(n).