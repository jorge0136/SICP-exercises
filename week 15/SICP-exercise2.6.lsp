; Exercise 2.6: In case representing pairs as procedures wasn’t mind-boggling enough, consider
; that, in a language that can manipulate procedures, we can get by without numbers (at least
; insofar as nonnegative integers are concerned) by implementing 0 and the operation of adding 1
; as

; (define zero (lambda (f) (lambda (x) x)))

; (define (add-1 n)
;   (lambda (f) (lambda (x) (f ((n f) x)))))
; This representation is known as Church numerals, after its inventor, Alonzo Church, the logician
; who invented the λ-calculus.

; Define one and two directly (not in terms of zero and add-1). (Hint: Use substitution to
; evaluate (add-1 zero)). Give a direct definition of the addition procedure + (not in terms of
; repeated application of add-1).

#lang sicp

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

; Adding one to zero is one.
(add-1 zero)

; Substitute add-1 for literal definition.
((lambda (f) (lambda (x) (f ((n f) x)))) zero)

; Apply the zero procedure.
(lambda (f) (lambda (x) (f ((zero f) x))))

;Zero is a procedure that takes a procedure that returns the argument. Zero is the identity
;function. Zero of f of x is x.
(lambda (f) (lambda (x) (f x)))

; We can define one as follows.
(define one (lambda (f) (lambda (x) (f x))))

; Adding one to one gets us two.
(add-1 one)

; Expanding add-1.
((lambda (f) (lambda (x) (f ((n f) x)))) one)

; Applying one to add-1.
(lambda (f) (lambda (x) (f ((one f) x))))

; Substituting the definition of one and changing the variables for sanity.
(lambda (f) (lambda (x) (f (((lambda (fa) (lambda (xa) (fa xa))) f) x))))

; Apply f to lambda with the argument of fa.
(lambda (f) (lambda (x) (f ((lambda (xa) (f xa)) x))))

; Apply x to the lambda with the argument of xa.
(lambda (f) (lambda (x) (f (f x))))

; The result is the definition for 2.
(define two (lambda (f) (lambda (x) (f (f x)))))
(define three (lambda (f) (lambda (x) (f (f (f x))))))

; Realize church to int. Church applies a function an number of times to an argument. We can use
; `inc` to convert a church number to an integer.
((zero +) 0) ;=> 0  Zero is an identity function that ignores it's first argument.
((two inc) 0) ; => 2
((three inc) 0) ; => 3

; Generalizing this we get:
(define (de-church n)
  ((n inc) 0))

(de-church three) ;=> 3


; Now to add church numbers, we want to apply f m + n many times.
; Whoops, first implementation attempt was actually times!
(define (times-church m n)
  (lambda (f)
    (lambda (x)
      ((m (n f)) x))))

(de-church (times-church two three)) ;=> 6

; Applying (m f) to the result of ((n f) x) instead of to just (n f) gives us addition instead of
; multiplication.
(define (add-church m n)
  (lambda (f)
    (lambda (x)
      ((m f) ((n f) x)))))

(de-church (add-church two three)); => 5
