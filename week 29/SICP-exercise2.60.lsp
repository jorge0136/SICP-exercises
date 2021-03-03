#lang sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
(display "element-of-set?")(newline)
(element-of-set? 2 '()) ;=> false
(element-of-set? 2 '(2)) ;=> true
(element-of-set? 2 '(2 3 4 2)) ;=> true
(element-of-set? 2 '(3 3 4 8)) ;=> false

(define (adjoin-set x set)
  (cons x set))

(newline)
(display "adjoin-set")
(newline)

(adjoin-set 4 '(2 3)); => (4 2 3)
(adjoin-set 4 '()); => (4)
(adjoin-set 4 '(4 4)); => (4 4 4)

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) 
         '())
        ((element-of-set? (car set1) set2)
         (let ((intersection (intersection-set (cdr set1) set2)))
           (if (not (element-of-set? (car set1) intersection)) (cons (car set1) intersection)
               intersection)))
        (else (intersection-set (cdr set1) 
                                set2))))

(newline)
(display "intersection-set")
(newline)

(intersection-set '(1 2 3) '(1 2 3)) ; =>  (1 2 3)
(intersection-set '(1 2 3) '()) ; =>  ()
(intersection-set '() '(1 2 3)) ; =>  ()
(intersection-set '(1 2 3) '(2 3 4)) ; =>  (2 3)
(intersection-set '(6 5 4) '(4 2 3)) ; =>  (4)
(intersection-set '(1 2 1 2 6) '(2 1 2 6 8)) ; =>  (1 2 6)

(define (append set1 set2)
  (if (null? set1)
      set2
      (cons (car set1)
            (append (cdr set1) set2))))

(define union-set append)

(newline)
(display "union-set")
(newline)

(union-set '() '()) ;=> ()
(union-set '(1 2 3) '()) ;=> (3 2 1)
(union-set '() '(1 2 3)) ;=> (3 2 1)
(union-set '(1 2 3) '(2 3 4)) ;=> (4 3 2 1)
(union-set '(4 3 2) '(3 2 1)) ;=> (1 2 3 4)
(union-set '(1 2 1 2 3) '(4 3 2 3 1)) ; => (1 2 1 2 3 4 3 2 3 1)

;I'm unsure if only the internal represention allows duplicates or the final output can as well.
                   Duplicates    Non duplicates
; Element-of-set?  O(n)            O(n)
; adjoin-set       O(1)            O(n)
; intersection-set O(n2)           O(n2)
; union-set        O(n)            O(n2)

; We might use this implementation if we can output duplicates and space is not a concern.


