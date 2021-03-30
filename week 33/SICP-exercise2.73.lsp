#lang sicp

; ** BOILERPLATE **

(define ( square x ) (* x x))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)    
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

; **********************


; Exercise 2.73.

; Section 2.3.2 described a program that performs symbolic differentiation:

;(define (deriv exp var)
;  (cond ((number? exp) 0)
;        ((variable? exp) (if (same-variable? exp var) 1 0))
;        ((sum? exp)
;         (make-sum (deriv (addend exp) var)
;                   (deriv (augend exp) var)))
;        ((product? exp)
;         (make-sum
;           (make-product (multiplier exp)
;                         (deriv (multiplicand exp) var))
;           (make-product (deriv (multiplier exp) var)
;                         (multiplicand exp))))
;;        <more rules can be added here>
;        (else (error "unknown expression type -- DERIV" exp))))

; We can regard this program as performing a dispatch on the type of the expression to be
; differentiated. In this situation the ``type tag'' of the datum is the algebraic operator symbol
; (such as +) and the operation being performed is deriv. We can transform this program into
; data-directed style by rewriting the basic derivative procedure as

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp)
                                           var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

; a.  Explain what was done above. Why can't we assimilate the predicates number? and same-variable?
; into the data-directed dispatch?

; Those data types don't have a tag, nor are they a pair. We would need to add tags for variables and numbers. 

; b.  Write the procedures for derivatives of sums and products, and the auxiliary code required to
; install them in the table used by the program above.

(define (install-deriv-package)
  (define (=number? exp num) ; Checks whether an expression is equal to a given number
    (and (number? exp) (= exp num)))
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
 
  ;; interface to the rest of the system
  (put 'deriv '+ make-sum)
  (put 'deriv '* make-product)
  'done)

(install-deriv-package)
(deriv '(* (* x y) (+ x 3)) 'x)

; c.  Choose any additional differentiation rule that you like, such as the one for exponents
; (exercise 2.56), and install it in this data-directed system.
(define (add-exponentiation-to-deriv-package)
  (define (=number? exp num) ; Checks whether an expression is equal to a given number
    (and (number? exp) (= exp num)))
  (define (** b n)
    (fast-expt-iter b n 1))
  (define (fast-expt-iter b n a)
    (cond ((= n 0) a)
          ((even? n) (fast-expt-iter (square b) (/ n 2) a))
          (else (fast-expt-iter b (- n 1) (* b a)))))
  (define (make-exponentiation base e)
    (cond ((=number? e 0) 1) ; anything raised to the power 0 is 1.
          ((=number? e 1) base) ; anything raised to the power 1 is the thing itself
          ((=number? base 1) 1)
          ((and (number? base) (number? e)) (** base e))
          (else (list '** base e))))

  ; interface to the rest of the system
  (put 'deriv '** make-exponentiation)
  'done)

(add-exponentiation-to-deriv-package)
(deriv '(** x 3) 'x)

; d.  In this simple algebraic manipulator the type of an expression is the algebraic operator that
; binds it together. Suppose, however, we indexed the procedures in the opposite way, so that the
; dispatch line in deriv looked like

;((get (operator exp) 'deriv) (operands exp) var)

;What corresponding changes to the derivative system are required?

; Merely need to flip the operators around when adding them to the table. This would involve updates to selectors and constructors too. 
