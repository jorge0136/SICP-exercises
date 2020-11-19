#lang sicp
; Exercise 2.35.  Redefine count-leaves from section 2.2.2 as an accumulation:

;(define (count-leaves x)
;  (cond ((null? x) 0)  
;        ((not (pair? x)) 1)
;        (else (+ (count-leaves (car x))
;                 (count-leaves (cdr x))))))

;(define (square-tree node)
;  (if (not (pair? node)) (square node)
;      (map square-tree node)))


(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence)
                 (accumulate operation initial (cdr sequence)))))

; TODO: Make a valid procedure to make a fla
;(define (only-leaves t)
;  (if (not (pair? t)) t)
;      (map only-leaves t))

(define (fringe tree)
  (cond ((null? tree) nil)
        ((pair? tree) (append (fringe (car tree))
                              (fringe (cdr tree))))
        (else (list tree))))

 (define (count-leaves t)
   (lambda (leaf accumulator) (+ 1 accumulator))
               nil
               (map (fringe t)))

(define x (cons (list 1 2) (list 3 4)))
(fringe x)
;(count-leaves x)