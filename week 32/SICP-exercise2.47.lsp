#lang scheme

(define (make-vect x y)
  (cons x y))

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

(define origin (make-vect 0 0))
(define edge1 (make-vect 0 5))
(define edge2 (make-vect 5 0))

(define frame (make-frame origin edge1 edge2))

(origin-frame frame) ; => (0 . 0)
(edge1-frame frame)  ; => (0 . 5)
(edge2-frame frame)  ; => (5 . 0)

; The selectors work for both implemetations of make-frame.