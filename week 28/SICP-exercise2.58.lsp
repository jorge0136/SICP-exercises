#lang sicp
; Exercise 2.58.  Suppose we want to modify the differentiation program so that it works with
; ordinary mathematical notation, in which + and * are infix rather than prefix operators.
; Since the differentiation program is defined in terms of abstract data, we can modify it to
; work with different representations of expressions solely by changing the predicates, selectors,
; and constructors that define the representation of the algebraic expressions on which the
; differentiator is to operate.

; ################ Implementing `**` operator ################
(define (even? n)(= (remainder n 2) 0))
(define ( square x ) (* x x))

(define (** b n)
  (fast-expt-iter b n 1))

;; b is the base
;; n is the exponent or `counter`
;; a is the product which holds the state between iterations.
(define (fast-expt-iter b n a)
  (cond ((= n 0) a)
        ((even? n) (fast-expt-iter (square b) (/ n 2) a))
        (else (fast-expt-iter b (- n 1) (* b a)))))
; ################################################################

(define (accumulate op initial sequence) 
  (if (null? sequence) 
      initial 
      (op (car sequence) 
          (accumulate op initial (cdr sequence))))) 

; Book provided implemtentation of procedures used in `deriv`.

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (=number? exp num) ; Checks whether an expression is equal to a given number
  (and (number? exp) (= exp num)))

; a. Show how to do this in order to differentiate algebraic expressions presented in infix form,
; such as (x + (3 * (x + (y + 2)))). To simplify the task, assume that + and * always take two
; arguments and that expressions are fully parenthesized.

; ** Sum **
(define (sum? x) ; A product is a list whose second element is the symbol +:
  (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))

(define (augend s)    
  (accumulate make-sum 0 (cddr s))) 

(define (make-sum a1 a2) 
  (cond ((=number? a1 0) a2) 
        ((=number? a2 0) a1) 
        ((and (number? a1) (number? a2)) (+ a1 a2)) 
        (else (list a1 '+ a2)))) 

; ** Product **
(define (product? x) ; A product is a list whose second element is the symbol *:
  (and (pair? x) (eq? (cadr x) '*)))
(define (multiplier p) (car p)) ; The multiplier is the second item of the product list

(define (multiplicand p)  
  (accumulate make-product 1 (cddr  p)))

(define (make-product m1 m2) 
  (cond ((or (=number? m1 0) (=number? m2 0)) 0) 
        ((=number? m1 1) m2) 
        ((=number? m2 1) m1) 
        ((and (number? m1) (number? m2)) (* m1 m2)) 
        (else (list m1 '* m2)))) 

; ** Exponentiation **
(define (exponentiation? x) ; A exponentiation? is a list whose first element is the symbol **:
  (and (pair? x) (eq? (car x) '**)))
(define (base e) (cadr e)) ; The base is the second item of the exponentiation? list
(define (exponent e) (caddr e)) ; The exponent is the third item of the product list

(define (make-exponentiation base e)
  (cond ((=number? e 0) 1) ; anything raised to the power 0 is 1.
        ((=number? e 1) base) ; anything raised to the power 1 is the thing itself
        ((=number? base 1) 1)
        ((and (number? base) (number? e)) (** base e))
        (else (list base '** e))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))

        ((product? exp)
         (make-sum
          (make-product
           (multiplier exp)
           (deriv (multiplicand exp) var))
          (make-product
           (deriv (multiplier exp) var)
           (multiplicand exp))))

        ((exponentiation? exp)
         (let ((u (base exp))
               (n (exponent exp)))
           (make-product
            (make-product
             n
             (make-exponentiation u ; u ** n-1
                                  (make-sum n -1)))
            (deriv u var)))) ; du/dx
        (else (error "unknown expression
                      type: DERIV" exp))))

(deriv '(x * y * (x + 3)) 'x)

; b. The problem becomes substantially harder if we allow standard algebraic notation,
 ;such as (x + 3 * (x + y + 2)), which drops unnecessary parentheses and assumes that multiplication
; is done before addition. Can you design appropriate predicates, selectors, and constructors for
; this notation such that our derivative program still works?

; Jon's transform approach makes sense to me.

; scan the expression, looking for operators. (Use memq?) 
; Find the operators and their operands.
; Compute in precedence.