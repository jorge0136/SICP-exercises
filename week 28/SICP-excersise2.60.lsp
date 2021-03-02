#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) 
         '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) 
                                 set2)))
        (else (intersection-set (cdr set1) 
                                set2))))

(define (reduce fn init coll)
  (if (null? coll) init
      (reduce fn (fn (car coll) init) (cdr coll))))

(define (union-set set1 set2)
  (reduce (lambda (item coll)
            (adjoin-set item coll))
          set1
          set2))

(union-set '(4 5 6) '(6 7 8)) ;=> (4 5 6 7 8)