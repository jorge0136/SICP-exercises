#lang sicp

(define (key tree) (caar tree))
(define (data tree) (cadar tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))



(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((= (key set-of-records) given-key) (data set-of-records))
        ((< given-key (key set-of-records))
         (lookup given-key (left-branch set-of-records)))
        ((> given-key (key set-of-records))
         (lookup given-key (right-branch set-of-records)))))

(define records '((5 Bill)
                  ((3 Jane)
                   ((2 Ted) () ()) ())
                  ((6 Janet)
                   () ((8 Ralph)
                       ((7 Sue) () ())
                       ((11 Tommy) () ())))))

(lookup 5 records) ; => Bill
(lookup 2 records) ; => Ted
(lookup 7 records) ; => Sue
(lookup 11 records) ; => Tommy