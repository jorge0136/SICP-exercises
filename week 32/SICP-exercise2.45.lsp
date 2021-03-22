#lang scheme
(#%require sicp-pict)

(define (split p1 p2)
  (define (splitter painter n)
     (if (= n 0) painter
      (let ((smaller (splitter painter (- n 1))))
        (p1 painter (p2 smaller smaller)))))
    splitter)

(define right-split (split beside below))
(define up-split (split below beside))

(paint (right-split einstein 3))
(paint (up-split einstein 3))
