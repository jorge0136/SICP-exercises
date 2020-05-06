#lang sicp
;; Exercises based on the following lecture and readings.

;; youtube.com/watch?time_continue=1688&v=2Op3QLzMgSY
;; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-10.html#%_sec_1.1

;; * Exercise 1.1
;; Below is a sequence of expressions.
;; What is the result printed by the interpreter in response to each expression?
;; Assume that the sequence is to be evaluated in the order in which it is presented.

10
  ;; -> 10
(+ 5 3 4)
  ;; --> 12
(- 9 1)
  ;; --> 8
(/ 6 2)
 ;; --> 3
(+ (* 2 4) (- 4 6))
  ;; --> 6
(define a 3)
(define b (+ a 1))
(+ a b (* a b))
 ;; --> 19

(= a b)
  ;; --> #f
  ;; This is equality check. #f is the boolean false.

(if (and (> b a) (< b (* a b)))
    b
    a)
  ;; --> 4
  ;; Both statements are true. It returns `b`.

(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
  ;; --> 16
  ;; --> (= b 4 ) evalutes to true so --> (+ 6 7 a) --> 16

(+ 2 (if (> b a) b a))
  ;; --> 6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))
  ;; --> 16
  ;; (< a b ) evaluates to true so --> cond returns b. (* b (+ a 1)) --> 16
