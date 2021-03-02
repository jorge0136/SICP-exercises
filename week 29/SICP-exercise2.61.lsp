#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set 
                         (cdr set1)
                         (cdr set2))))
              ((< x1 x2) (intersection-set 
                          (cdr set1) 
                          set2))
              ((< x2 x1) (intersection-set 
                          set1 
                          (cdr set2)))))))

(define (ajoin-set set1 set2)
  (if (and (null? set1) (null? set2)) '()) 
        (let ((x1 (car set1)) (x2 (car set2)))
                (cond ((= x1 x2)
                       (cons x1 (ajoin-set (cdr set1) (cdr set2))))
                      ((< x1 x2)
                      (cons x1 (ajoin-set (cdr set1) set2)))
                      ((< x2 x1)
                       (cons x2 (ajoin-set set1 (cdr set2))))
                      ((null? set1)
                       (cons x2 (ajoin-set '() (cdr set2))))
                      ((null? set2)
                       (cons x1 (ajoin-set (cdr set1) '())))
                       
                      )))

(ajoin-set '(1 2 3) '(2 3 4))