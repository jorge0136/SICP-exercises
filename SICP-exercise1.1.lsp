#lang scheme
 (require racket/pretty)
;; Exercises based on the following lecture and readings. 

;; youtube.com/watch?time_continue=1688&v=2Op3QLzMgSY
;; https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-10.html#%_sec_1.1

;;Exercise 1.1.  Below is a sequence of expressions.
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

;; Exercise 1.2.  Translate the following expression into prefix form
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

;; Exercise 1.3.  Define a procedure that takes three numbers as arguments and returns 
;; the sum of the squares of the two larger numbers.

 ;; PICK UP HERE. It's written but buggy and not yet tested. 
 ;; Need to clean up the predicate logic around deciding the largest three numbers. 
(define (sum-square-of-biggest-two a b c)
  ;; Define in-block vs. not? 
  (define (sum-square x y)
    (+ (* x x) (* y y))
  )

  (cond ((>= a b c) sum-square a b)
        ((>= a c b) sum-square a c)
        ((>= b c a) sum-square b c)
        ((>= c b a) sum-square b c))
)
(sum-square-of-biggest-two 2 2 3)
  ;; --> 8? 

;; Exercise 1.4.  Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

  ;; (define (a-plus-abs-b a b)
  ;;   ((if (> b 0) + -) a b))

;; Exercise 1.5.  Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:
  ;; TODO: Fully understand and express normal order vs. applicative order. 
  ;; https://www.lvguowei.me/post/sicp-goodness/
  ;; https://courses.cs.washington.edu/courses/cse505/99au/functional/applicative-normal.pdf

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
  ;; (Assume that the evaluation rule for the special form if is the same whether the interpreter is using normal or applicative order: The predicate expression is evaluated first, and the result determines whether to evaluate the consequent or the alternative expression.)


