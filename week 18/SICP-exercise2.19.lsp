#lang sicp
; Exercise 2.19.  Consider the change-counting program of section 1.2.2. It would be nice to be able
; to easily change the currency used by the program, so that we could compute the number of ways to
; change a British pound, for example. As the program is written, the knowledge of the currency is
; distributed partly into the procedure first-denomination and partly into the procedure count-change
; (which knows that there are five kinds of U.S. coins). It would be nicer to be able to supply a
; list of coins to be used for making change.
;
; We want to rewrite the procedure cc so that its second argument is a list of the values of the coins
; to use rather than an integer specifying which coins to use. We could then have lists that defined
; each kind of currency:
;
; (define us-coins (list 50 25 10 5 1))
; (define uk-coins (list 100 50 20 10 5 2 1 0.5))
;
; We could then call cc as follows:
;
; (cc 100 us-coins)
; 292
;
; To do this will require changing the program cc somewhat. It will still have the same form, but it
; will access its second argument differently, as follows:
;
(define (list-ref items n)
  (if (= n 0)
      (car items)
      (list-ref (cdr items) (- n 1))))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))


; Define the procedures first-denomination, except-first-denomination, and no-more? in terms of primitive operations on list structures.


(define (except-first-denomination coin-values)
        (cdr coin-values))

(define (no-more? coin-values)
  (null? coin-values))
  
(define (first-denomination coin-values)
        (car coin-values))

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(cc 100 us-coins)
; -> 292

; Does the order of the list coin-values affect the answer produced by cc? Why or why not?
  ; My hypothesis prior to testing is that yes the order matters a lot. It will subtract coins in the wrong order and not be able to find all
  ; the combos if the order is reversed.

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (reverse items)
 (define (reverse-iter items reversed-list)
    (if (null? items)
        reversed-list
        (reverse-iter (cdr items)
                      (append (list (car items))
                              reversed-list))))
  (reverse-iter items '()))

(cc 100 (reverse us-coins))
(define us-coins-random-order (list 5 10 25 50 1))
(cc 100  us-coins-random-order)
; After testing my guess was incorrect. The recursive nature of the `cc` procedure will find the combos regardless of order. 