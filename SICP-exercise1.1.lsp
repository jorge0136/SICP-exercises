#lang scheme
 (require racket/pretty)
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

;; * Exercise 1.2
;; Translate the following expression into prefix form
            ;; 5 + 4 + (2 − (3 − (6 + 4/5)))
            ;; -----------------------------
            ;;       3(6 − 2)(2 − 7)

  ;; (/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (* (- 6 2 ) (- 2 7))))
  ;; Pretty printed
  (/
    (+ 5 4
        (- 2
            (- 3
                (+ 6
                    (/ 4 5)))))
    (* 3
        (*
            (- 6 2 )
            (- 2 7))))

;; * Exercise 1.3
;; Define a procedure that takes three numbers as arguments and returns
;; the sum of the squares of the two larger numbers.

(define ( square x ) (* x x))
( =  (square 3) 9)

(define ( sum-square y z ) (+ ( square y ) ( square z)))
( =  (sum-square 3 2) 13)

(define ( sum-square-of-biggest-two a b c )
  (define smallest (min a b c))
  (cond ((= smallest c) (sum-square a b))
        ((= smallest b) (sum-square a c))
        ((= smallest a) (sum-square b c))
        (else -1))
)

(sum-square-of-biggest-two 2 2 3)
( =  (sum-square-of-biggest-two 2 2 3) 13)

;; * Exercise 1.4
;; Observe that our model of evaluation allows for combinations whose operators are compound expressions.
;; Use this observation to describe the behavior of the following procedure:

;; Explination:
  ;; Example Compound Expression: (+ 3 2)
  ;; Example Combination: (+ 3 (* 5 6) 8 2)
    ;; Operators involved are +, *

  (define (a-plus-abs-b a b)
    ((if (> b 0) + -)
          a
          b))


  ;; Concise explination below from http://community.schemewiki.org/?sicp-ex-1.4
  ;; The if statement returns either a - or a +, which is then applied to the operands.


  ;;  (a + |b|)
  ;;  A plus the absolute value of B

  ;; given

  ;;  (define (a-plus-abs-b a b)
  ;;    ((if (> b 0) + -) a b))
  ;;  (a-plus-abs-b 1 -3)
  ;;  ((if (> -3 0) + -) 1 -3)
  ;;  ((if #f + -) 1 -3)
  ;;  (- 1 -3)
  ;;  4

  ;;  (a-plus-abs-b 1 3)
  ;;  ((if (> 3 0) + -) 1 -3)
  ;;  ((if #t + -) 1 3)
  ;;  (+ 1 3)
  ;;  4
