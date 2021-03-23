#lang sicp
(#%require sicp-pict)

; Exercise 2.49.  Use segments->painter to define the following primitive painters:

(define bottom-left (make-vect 0 0))
(define bottom-right (make-vect 0 1))
(define top-right (make-vect 1 1))
(define top-left (make-vect 1 0))


;; a.  The painter that draws the outline of the designated frame.
(define a (segments->painter (list
                              (make-segment bottom-left top-left)
                              (make-segment bottom-left bottom-right)
                              (make-segment bottom-right top-right)
                              (make-segment top-left top-right))))

; The sicp-pict language has rewired the way painters work. Instead of passing a frame to a painter, we call `paint` on a painter.
; See prior commit for all the gory details. Ultimate missing part was `line`. 
(paint a)
(newline)
; b.  The painter that draws an ``X'' by connecting opposite corners of the frame.

(define b (segments->painter (list
                              (make-segment bottom-left top-right )
                              (make-segment bottom-right top-left))))

(paint b)
; c.  The painter that draws a diamond shape by connecting the midpoints of the sides of the frame.

(define mid-left (make-vect 0 .5))
(define mid-right (make-vect 1 .5))
(define mid-top (make-vect .5 1))
(define mid-bottom (make-vect .5 0))

(define c (segments->painter (list
                              (make-segment mid-left mid-top)
                              (make-segment mid-top mid-right)
                              (make-segment mid-right mid-bottom)
                              (make-segment mid-bottom mid-left))))
(paint c)

; d.  The wave painter.

