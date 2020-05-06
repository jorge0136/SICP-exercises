
;; * Exercise 1.5
;; Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using
;; applicative-order evaluation or normal-order evaluation. He defines the following two procedures:

  ;; (define (p) (p))

  ;; (define (test x y)
  ;;   (if (= x 0)
  ;;       0
  ;;       y))

  ;; Then he evaluates the expression

  ;; (test 0 (p))

;; What behavior will Ben observe with an interpreter that uses applicative-order evaluation?
;; What behavior will he observe with an interpreter that uses normal-order evaluation?
;; Explain your answer.
;; (Assume that the evaluation rule for the special form if is the same whether the interpreter
;; is using normal or applicative order: The predicate expression is evaluated first, and the
;; result determines whether to evaluate the consequent or the alternative expression.)

  ;; MY NOTES:
    ;; p is recurisve, it starts a never ending loop.
    ;; https://www.lvguowei.me/post/sicp-goodness/
    ;; https://courses.cs.washington.edu/courses/cse505/99au/functional/applicative-normal.pdf

    ;; * Applicative Order Evalutation --> "Evaluate the function and arguments and then apply"... rewrite
      ;; the leftmost occurence of a function application. (This is equivalent to call by name.)

    ;; * Normal Order Evaluation --> "Fully expand and then reduce"... rewrite the innermost occurrence of a
      ;; function application first. (This is equivalent to call by value.)

  ;; "An alternative evaluation model would not evaluate the operands until their values were needed.
  ;; Instead it would first substitute operand expressions for parameters until it obtained an expression
  ;; involving only primitive operators, and would then perform the evaluation."

;; * What behavior will Ben observe with an interpreter that uses applicative-order evaluation?
  ;; Ben Will observe the program stuck in a loop forever. Applicative order will evaluate the function and
  ;; arguments and then apply. It will attempt to resolve (p) first.

;; * What behavior will he observe with an interpreter that uses normal-order evaluation?
  ;; Ben will observe the program stuck returning 0. 'Fully expand and then reduce' of normal-order
  ;; means that the arguments to the predicate will be evaluated first, then the predicate before
  ;; (p) is ever evaluated.

  ;; For my personal machine I am think I am running normal-order evaluation, as it doesn't get stuck.
