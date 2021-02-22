#lang sicp
; Exercise 2.57.  Extend the differentiation program to handle sums and products of arbitrary numbers
; of (two or more) terms. Then the last example above could be expressed as

; (deriv '(* x y (+ x 3)) 'x)

; Previous example: (deriv '(* (* x y) (+ x 3)) 'x) 

; Try to do this by changing only the representation for sums and products, without changing the
; deriv procedure at all. For example, the addend of a sum would be the first term, and the augend
; would be the sum of the rest of the terms.

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
(define (augend s) 
  (let ((a (cddr s))) 
    (if (= (length a) 1) 
        (car a) 
        (make-sum-list a))))

; cdr down the list making a sum. 
(define (make-sum-list l) 
  (if (= (length l) 2) 
      (list '+ (car l) (cadr l)) 
      (make-sum (car l) (make-sum-list (cdr l)))))

(define (make-sum a1 a2) 
  (cond ((=number? a1 0) a2) 
        ((=number? a2 0) a1) 
        ((and (number? a1) (number? a2)) (+ a1 a2)) 
        (else (make-sum-list (list a1 a2))))) 

(define (product? x) ; A product is a list whose first element is the symbol *:
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p)) ; The multiplier is the second item of the product list

 (define (multiplicand p) 
   (let ((m (cddr p))) 
     (if (= (length m) 1) 
         (car m) 
         (make-product-list m)))) 

(define (make-product-list l) 
  (if (= (length l) 2) 
      (list (multiplier l) '* (multiplicand l)) 
      (make-product (car l) (make-product-list (cdr l)))))

(define (make-product m1 m2) 
  (cond ((or (=number? m1 0) (=number? m2 0)) 0) 
        ((=number? m1 1) m2) 
        ((=number? m2 1) m1) 
        ((and (number? m1) (number? m2)) (* m1 m2)) 
        (else (make-product-list (list m1 m2))))) 

(define (exponentiation? x) ; A exponentiation? is a list whose first element is the symbol **:
  (and (pair? x) (eq? (car x) '**)))
(define (base e) (cadr e)) ; The base is the second item of the exponentiation? list
(define (exponent e) (caddr e)) ; The exponent is the third item of the product lis

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

(deriv '(* x y (+ x 3)) 'x)
(deriv '(* (* x y) (+ x 3)) 'x) 