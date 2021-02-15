#lang sicp

; Exercise 2.56.  Show how to extend the basic differentiator to handle more kinds of expressions.
; For instance, implement the differentiation rule ...

; see book for graphic

;; by adding a new clause to the deriv program and defining appropriate procedures exponentiation?, base, exponent, and make-exponentiation. (You may use the symbol ** to denote exponentiation.) Build in the rules that anything raised to the power 0 is 1 and anything raised to the power 1 is the thing itself.
;

; First a quick note. The OG SICP PDF has terrible graphics for this section. The equations are difficult to read.

; See this version of the book. http://sarabander.github.io/sicp/html/2_002e3.xhtml#g_t2_002e3_002e2

; ************* MATHY BACKGROUND REFRESHER *************

; Intuition:

; https://0a.io/chapter1/calculus-explained.html
; See "3. What is differentiation?"

; Originally a book by SILVANUS P. THOMPSON
; 1. http://calculusmadeeasy.org/
; Pawing through this has a quote I am finding enlightening.
; > "This ratio dy/dx is the result of differentiating y with respect to x. Differentiating means finding the differential coefficient."
; Can we find the "differential coefficient" when doing symbolic differnetation? What is the importance of `symbolic` here? 

; Mechanics:

; Initially I started doing a deep dive on differentation mechanics. This really isn't needed. I'll mention the details here but this section is a good candidate for skipping.

; #################### Skip me ##############################
; https://www.youtube.com/watch?v=OpB6rULADSU
; It immediately begs the question of familiarity with several concepts:

; 1. Product rule
; 2. Quotient rule
; 3. Chain rule

; There is a good quick refernce for these things in https://0a.io/chapter1/calculus-explained.html. Search for "Here is a list of famous shortcuts for differentiation." 
; ###########################################################

; Comparing the rules mentioned above, they are evidently not used at all in the simple examples we are looking at.

; Quoting the book, the critical passage on the nature of the differentation we are doing is the following: 
; > "Observe that the latter two rules are recursive in nature. That is, to obtain the derivative of a sum we first find the derivatives
; > of the terms and add them. Each of the terms may in turn be an expression that needs to be decomposed.
; > Decomposing into smaller and smaller pieces will eventually produce pieces that are either constants or variables,
; > whose derivatives will be either 0 or 1."

; Looking the implementation in the book, we are indeed seeking for the coefficients of the variables in the equations.
; Still not sure how "symbolic differentation" is distinct from mere "differntation".

; This quote is a bit of an ephipany for me about math in general:
; >  "The problem of algebraic simplification is complex because, among other reasons, a form that may be simplest for one purpose may not be for another."

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

; Book provided implemtentation of procedures used in `deriv`.

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (=number? exp num) ; Checks whether an expression is equal to a given number
  (and (number? exp) (= exp num)))

(define (sum? x) ; A product is a list whose first element is the symbol +:
  (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s)) ; The addend is the second item of the sum list
(define (augend s) (caddr s)) ; The augend is the third item of the sum list

(define (product? x) ; A product is a list whose first element is the symbol *:
  (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p)) ; The multiplier is the second item of the product list
(define (multiplicand p) (caddr p)) ; The multiplicand is the third item of the product list

(define (exponentiation? x) ; A exponentiation? is a list whose first element is the symbol **:
  (and (pair? x) (eq? (car x) '**)))
(define (base e) (cadr e)) ; The base is the second item of the exponentiation? list
(define (exponent e) (caddr e)) ; The exponent is the third item of the product list

; Sums and products and exponents are constructed as lists. Note these implmentations are imbued with logic to simplify the final solutions. 
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) 
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) 
             (=number? m2 0)) 
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) 
         (* m1 m2))
        (else (list '* m1 m2))))

(define (make-exponentiation base e)
  (cond ((=number? e 0) 1) ; anything raised to the power 0 is 1.
        ((=number? e 1) base) ; anything raised to the power 1 is the thing itself
        ((=number? base 1) 1)
        ((and (number? base) (number? e)) (** base e))
        (else (list '** base e))))

; Test cases: 
; (make-exponentiation 'a 'b) --> (** a b)
; (make-exponentiation 'a 1) --> a
; (make-exponentiation 'a 0) --> 1

; (make-exponentiation 4 4) --> 256

; (make-exponentiation 2 'b) --> (** 2 b)
; (make-exponentiation 'a 3) --> (** 3 a)
; (make-exponentiation 1 'b) --> 1

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

; Regression tests for earlier operators: 
;(deriv '(+ x 3) 'x) ; --> 1. 
;(deriv '(* x y) 'x) ; --> y
;(deriv '(* (* x y) (+ x 3)) 'x) ; --> (+ (* x y) (* y (+ x 3)))

; New exponentiation tests: 
(deriv '(** x 3) 'x) ; --> (* 3 (** x 2))
(deriv '(** x y) 'x) ; --> (* y (** x (+ y -1)))
(deriv '(* (+ 3 y) (+ y (** x 4))) 'x) ; --> (* (+ 3 y) (* 4 (** x 3)))

; Thanks to http://wiki.drewhess.com/wiki/SICP_exercise_2.56 for `let` variable naming idea and test cases. 