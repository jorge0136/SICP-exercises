#lang sicp

(define (accumulate op init l)
  (if (null? l) init
      (op (car l) (accumulate op init (cdr l)))))

(define (append x y)
  (if (null? x) y
      (cons (car x) (append (cdr x) y))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (fringe x)
  (if (pair? x) (flatmap fringe x)
      (list x)))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (_) 1) (fringe t))))

(define y  (list (list 1 2) (list 3 4 7)))

(count-leaves y)

