#lang sicp
(#%require sicp-pict)

(define bl (make-vect 0 0))
(define br (make-vect 0.99 0))
(define tl (make-vect 0 0.99))
(define tr (make-vect 0.99 0.99))
(define mr (make-vect 0.99 0.5))
(define mt (make-vect 0.5 0.99))
(define ml (make-vect 0 0.5))
(define mb (make-vect 0.5 0))



(define (outline frame)
   ((segments->painter (list (make-segment bl br)
                             (make-segment br tr)
                             (make-segment tr tl)
                             (make-segment tl bl)))
  frame))

(define (draw-x frame)
 
    ((segments->painter (list (make-segment tl br)
                              (make-segment tr bl)
                             ))
     frame))

(define (diamond frame)
    ((segments->painter (list (make-segment ml mt)
                              (make-segment mt mr)
                              (make-segment mr mb)
                              (make-segment mb ml)
                             ))
     frame))

 
(paint outline)
(paint draw-x)
(paint diamond)
; Uh no

