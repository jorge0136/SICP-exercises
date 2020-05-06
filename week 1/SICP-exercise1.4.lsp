#lang sicp
;; Exercise 1.4
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
