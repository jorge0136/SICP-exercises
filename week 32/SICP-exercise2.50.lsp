#lang sicp
(#%require sicp-pict)
(define (flip-horiz painter)
   (transform-painter 
   painter
   (make-vect 1.0 0.0)   ; new origin
   (make-vect 0.0 0.0)   ; new end of edge1
   (make-vect 1.0 1.0))) ; new end of edge2
  
(define (rotate-180 painter)

   (transform-painter 
   painter
   (make-vect 1.0 1.0)   ; new origin
   (make-vect 0.0 1.0)   ; new end of edge1
   (make-vect 1.0 0.0))) ; new end of edge2

(define (rotate-270 painter)

   (transform-painter 
   painter
   (make-vect 1.0 0.0)   ; new origin
   (make-vect 1.0 1.0)   ; new end of edge1
   (make-vect 0.0 0.0))) ; new end of edge2


(paint einstein)
(paint (flip-horiz einstein))
(paint (rotate-180 einstein))
(paint (rotate-270 einstein))