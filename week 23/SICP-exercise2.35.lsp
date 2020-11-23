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

; Have the map return a flat list of 1 or 0.

(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence)
                 (accumulate operation initial (cdr sequence)))))

; Breaking these out to figure out how to flatten the list to `zero` or `one` helped figure out what I needed to do. 
(define (flatten-to-1-or-zero tree)
  (cond ((pair? tree) 1)  
  (else 0)))

(define (test-flatten-transform x)
  (map flatten-to-1-or-zero x))

(define (count-leaves t)
  (accumulate +
              0
              (map 
               (lambda (t) 
                 (cond ((null? t) 0) 
                       ((pair? t) (count-leaves t)) 
                       (else 1))) 
               t))) 

(define x (cons (list 1 2) (list 3 4)))
(count-leaves x)

;(flatten-to-1-or-zero x)
;(test-map x)