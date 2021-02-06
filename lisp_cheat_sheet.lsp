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

; My own implementation of `unique`. Not especially fast. Mostly depends on `member`.
; TODO: Discuss asymptotic complexity. 

(define (unique l)
  (unique-iter l '() ))

(define (unique-iter l snowflakes)
   (cond ((null? l) snowflakes)
         ((member (car l) (cdr l))
          (unique-iter (cdr l)
                       snowflakes))
         (else (unique-iter (cdr l)
                            (append snowflakes (list(car l)))))))
