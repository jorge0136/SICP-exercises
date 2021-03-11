#lang sicp

; SICP Lisp Cheat Sheet
; -----------------------------------------------------------------------------

; ** IF ** 
; (if ⟨predicate⟩ ⟨consequent⟩ ⟨alternative⟩)

; Example:
;(if (= x 0) 
;      0 
;      y))

; -----------------------------------------------------------------------------

; ** COND ** 
; (cond (⟨p1⟩ ⟨e1⟩)
;       (⟨p2⟩ ⟨e2⟩)
;       ...
;       (⟨pn⟩ ⟨en⟩))

;Example:
;(cond ((> a b) a)
;         ((< a b) b)
;         (else -1))

; -----------------------------------------------------------------------------

; ** LET **

;(let ((<var1> <exp1>) ... (<var_n> <exp_n>))
;  <body>)

; Example:
(let
  ((x 10)
   (y 20))
  (+ x y))

; Also valid for a higher order function rather than just a value. 
; (let <var> <bindings> <body>)

; Example: 
(define (fib n)
  (let fib-iter ((a 1)
                 (b 0)
                 (count n))
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1)))))

; -----------------------------------------------------------------------------

; ** ACCUMULATE ** 
(define (accumulate operation initial sequence)
  (if (null? sequence)
      initial
      (operation (car sequence)
                 (accumulate operation initial (cdr sequence)))))

; -----------------------------------------------------------------------------

; ** APPEND ** 

(define (append seq1 seq2)
  (accumulate cons seq1 seq2))

; -----------------------------------------------------------------------------

; ** MAP ** 
 (define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

; -----------------------------------------------------------------------------
; The combination of mapping and accumulating with append is so common in this sort of program that we will
; isolate it as a separate procedure:

; ** FLATMAP ** 
(define (flatmap proc seq) 
  (accumulate append nil (map proc seq)))

; Note that the proc should be a lambda containing a map. 

; -----------------------------------------------------------------------------

; ** FILTER ** 
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))


; -----------------------------------------------------------------------------

; Is the item in the list? 
; ** MEMQ ** 
(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

; If the symbol is not contained in the list (i.e., is not eq? to any item in the list), then memq returns false.
; Otherwise, it returns the sublist of the list beginning with the first occurrence of the symbol:

;For example, the value of
(memq 'apple '(pear banana prune))
;is false, whereas the value of
(memq 'apple '(x (apple sauce) y apple pear))
;is (apple pear).

; -----------------------------------------------------------------------------

; My own implementation of `unique`. Not especially fast. Mostly depends on `member`.
; TODO: Discuss asymptotic complexity.
; TODO: Consider replacing `member` with `memq`. Is it more efficient to use memq? 

(define (unique l)
  (unique-iter l '() ))

(define (unique-iter l snowflakes)
   (cond ((null? l) snowflakes)
         ((member (car l) (cdr l))
          (unique-iter (cdr l)
                       snowflakes))
         (else (unique-iter (cdr l)
                            (append snowflakes (list(car l)))))))