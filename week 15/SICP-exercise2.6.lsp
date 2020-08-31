#lang sicp
; Exercise 2.6: In case representing pairs as procedures wasn’t mind-boggling enough, consider
; that, in a language that can manipulate procedures, we can get by without numbers (at least
; insofar as nonnegative integers are concerned) by implementing 0 and the operation of adding 1
; as

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f)
    (lambda (x)
      (f ((n f) x)))))
; This representation is known as Church numerals, after its inventor, Alonzo Church, the logician
; who invented the λ-calculus.

; Define one and two directly (not in terms of zero and add-1). (Hint: Use substitution to
; evaluate (add-1 zero)). Give a direct definition of the addition procedure + (not in terms of
; repeated application of add-1).

; Literal one. 
; A (define one (add-1 zero))
; B (add-1 (lambda (f) (lambda (x) x)))
; Skipping nitty gritty details I don't 100% understand. 
; C (lambda (f) (lambda (x) (f x)))

; Literal two.
; (lambda (f) (lambda (x) (f (f x))))

; My initial pass through add I wasn't calling `a` or `b` on `f`, only on `x`.
; One needs `f(x` `a + b` times, not just `a(b(x))`. 
 (define (addition a b)
         (lambda (f)
                 (lambda (x)
                         ((a f)
                          ((b f) x)))))
(define one
  (lambda (f)
    (lambda (x)
      (f x))))

(define two
  (lambda (f)
    (lambda (x)
      (f (f x)))))

; Printing idea provided by this blog post: https://jlongster.com/SICP-2.6--Church-Numerals
;((two (lambda (x)
;              (display x) ; Do a side effect of printing hello to indicate a pass through the loop. 
;              x))
; "hello \n")

; Here I abstracted out the printing procedure and gave it a name. 
(define (church-numeral-printer church-numeral string)
                                      ((church-numeral (lambda (p)
                                                              (display p)
                                                              p))
                                       string))

(church-numeral-printer two "two! \n")
(newline)
(church-numeral-printer (addition one two) "three! \n")
