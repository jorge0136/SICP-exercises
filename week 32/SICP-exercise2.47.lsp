#lang sicp
; Exercise 2.47.  Here are two possible constructors for frames:

(define (make-frame origin edge1 edge2) (list origin edge1 edge2))

(define (make-frame-cons origin edge1 edge2) (cons origin (cons edge1 edge2)))

; For each constructor supply the appropriate selectors to produce an implementation for frames.

; selectors needed are origin-frame, edge1-frame, and edge2-frame
(define (make-vect x y) (cons x y))

(define example-origin (make-vect .25 .25))
(define example-edge1 (make-vect .25 .5))
(define example-edge2 (make-vect .5 .25))

(display "list frame") (newline)
(define list-frame (make-frame example-origin example-edge1 example-edge2))
(define (origin-frame frame) (car frame))
(define (edge1-frame frame) (cadr frame))
(define (edge2-frame frame) (caddr frame))
list-frame
(origin-frame list-frame)
(edge1-frame list-frame)
(edge2-frame list-frame)

(display "cons frame") (newline)
(define cons-frame (make-frame-cons example-origin example-edge1 example-edge2))
(define (origin-frame-cons frame) (car frame))
(define (edge1-frame-cons frame) (cadr frame))
; Reason not to `cons` it all together is that the end of list isn't it's own entity, it's just a rando pair. 
(define (edge2-frame-cons frame) (cons (caddr frame) (caadr frame)))
cons-frame
(origin-frame-cons cons-frame)
(edge1-frame-cons cons-frame)
(edge2-frame-cons cons-frame)
