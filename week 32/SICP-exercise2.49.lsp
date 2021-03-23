#lang sicp
;(#%require sicp-pict)

; Exercise 2.49.  Use segments->painter to define the following primitive painters:

; ** Vectors ** 
(define (make-vect x y)
  (cons x y))
(define (xcor-vect point) (car point))
(define (ycor-vect point) (cdr point))
(define (add-vect vect1 vect2)
  (make-vect (+ (xcor-vect vect1) (xcor-vect vect2))
              (+ (ycor-vect vect1) (ycor-vect vect2))))
(define (sub-vect vect1 vect2)
  (make-vect (- (xcor-vect vect1) (xcor-vect vect2))
              (- (ycor-vect vect1) (ycor-vect vect2))))
(define (scale-vect vect scalar)
  (make-vect (* (xcor-vect vect) vect)
             (* (ycor-vect vect) vect)))

; ** Frames ** 
(define (make-frame origin edge1 edge2) (list origin edge1 edge2))
(define (origin-frame frame) (car frame))
(define (edge1-frame frame) (cadr frame))
(define (edge2-frame frame) (caddr frame))

; ** Segments **
(define (make-segment start-vector end-vector) (list start-vector end-vector))
(define (start-segment segment) (car segment))
(define (end-segment segment) (cadr segment))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v)
                           (edge1-frame frame))
               (scale-vect (ycor-vect v)
                           (edge2-frame frame))))))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))

(define og-frame (make-frame (make-vect 0 0) (make-vect 11 0) (make-vect 0 11)))
;
;; a.  The painter that draws the outline of the designated frame.
(define painter-a (segments->painter (list
                              (make-segment (make-vect 0 0) (make-vect 1 0))
                              (make-segment (make-vect 0 0) (make-vect 0 1))
                              (make-segment (make-vect 0 1) (make-vect 1 1))
                              (make-segment (make-vect 1 0) (make-vect 1 1)))))

;(paint painter-a)
; b.  The painter that draws an ``X'' by connecting opposite corners of the frame.

(define painter-b (segments->painter (list
                              (make-segment (make-vect 0 0) (make-vect 1 1))
                              (make-segment (make-vect 1 0) (make-vect 0 1)))))


; c.  The painter that draws a diamond shape by connecting the midpoints of the sides of the frame.


; d.  The wave painter.
