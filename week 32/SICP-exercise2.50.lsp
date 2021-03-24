#lang sicp
(#%require sicp-pict)

; Exercise 2.50.  Define the transformation flip-horiz, which flips painters horizontally, and
; transformations that rotate painters counterclockwise by 180 degrees and 270 degrees.

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter
         (make-frame new-origin
                     (vector-sub (m corner1) new-origin)
                     (vector-sub (m corner2) new-origin)))))))

; 0,1 - 1, 1
;  |     |
; 0,0 - 1, 0
(define bottom-left (make-vect 0 0))
(define top-left (make-vect 0 1))
(define top-right (make-vect 1 1))
(define bottom-right (make-vect 1 0))

; Normal
; edge 2
;  |
; origin - edge 1

; With `painter` implementation the default frame isn't super clear. 
(define (identity-transform painter)
  (transform-painter painter
                     bottom-left    ; new origin
                     bottom-right   ; new end of edge1
                     top-left))     ; new end of edge2
; Vertical
; origin - edge 1
;   |  
; edge 2  
(define (flip-vert painter)
  (transform-painter painter
                     top-left      ; new origin
                     top-right     ; new end of edge1
                     bottom-left)) ; new end of edge2
; Horizontal
;           edge 2
;             |   
; edge 1  - origin
(define (flip-horiz painter)
  (transform-painter painter
                     bottom-right ; new origin
                     bottom-left  ; new end of edge1
                     top-right))  ; new end of edge2

(define (rotate90 painter)
  (transform-painter painter
                     bottom-right
                     top-right
                     bottom-left))

; Breaking out implementation from exercise 1.45
; Combinators for the win! 
(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
  (compose f (repeated f (- n 1)))))

; Counterclockwise 180
; 90 degrees twice. 
(define (counter-clockwise-180 painter)
 ((repeated rotate90 2) painter))

; Counterclockwise 270
; 90 degrees thrice. 
(define (counter-clockwise-270 painter)
 ((repeated rotate90 3) painter))

(define george (segments->painter (list (make-segment (make-vect 0 0.6) (make-vect 0.2 0.4))
                            (make-segment (make-vect 0.2 0.4) (make-vect 0.3 0.55))
                            (make-segment (make-vect 0.3 0.55) (make-vect 0.35 0.45))
                            (make-segment (make-vect 0.35 0.45) (make-vect 0.25 0))
                            (make-segment (make-vect 0.4 0) (make-vect 0.5 0.3))
                            (make-segment (make-vect 0.5 0.3) (make-vect 0.6 0))
                            (make-segment (make-vect 0.75 0) (make-vect 0.6 0.45))
                            (make-segment (make-vect 0.6 0.45) (make-vect 0.99 0.15))
                            (make-segment (make-vect 0 0.8) (make-vect 0.2 0.55))
                            (make-segment (make-vect 0.2 0.55) (make-vect 0.3 0.6))
                            (make-segment (make-vect 0.3 0.6) (make-vect 0.4 0.6))
                            (make-segment (make-vect 0.4 0.6) (make-vect 0.35 0.8))
                            (make-segment (make-vect 0.35 0.8) (make-vect 0.4 0.99))
                            (make-segment (make-vect 0.6 0.99) (make-vect 0.65 0.8))
                            (make-segment (make-vect 0.65 0.8) (make-vect 0.6 0.6))
                            (make-segment (make-vect 0.6 0.6) (make-vect 0.8 0.6))
                            (make-segment (make-vect 0.8 0.6) (make-vect 0.99 0.35)))))

(display "Original") (paint (identity-transform george)) (newline)
(display "Rotate 90") (paint (rotate90 george)) (newline)
(display "Flip Vertical")(paint (flip-vert george)) (newline)
(display "Flip Horizontal")(paint (flip-horiz george)) (newline)
(display "counter-clockwise-180") (paint (counter-clockwise-180 george)) (newline)
(display "counter-clockwise-270") (paint (counter-clockwise-270 george)) (newline)