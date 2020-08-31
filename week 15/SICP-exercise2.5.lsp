#lang sicp
; Exercise 2.5: Show that we can represent pairs of nonnegative integers using only numbers and
; arithmetic operations if we represent the pair a and b as the integer that is the product 2^a3^b.
; Give the corresponding definitions of the procedures cons, car, and cdr.

; The axiom for rational numbers is that we need a `make-rat` `numer` and `denom` that honor the following: 

; If x = (make-rat n d)
; THEN
; (numer x) / (denom x) = n/d

; This abstraction assumes we can reduce our set of `(n, d)` to an integer and consistently extract the pair back out again.
(define (make-rat n d)
      (* (expt 2 n) (expt 3 d)))

; I don't really know where to begin, so I am going to create some numbers to see if the roots become obvious. 
(make-rat 2 2)
; -> 36
; sqrt 36 = 6
; cuberoot()

(make-rat 2 3)
; -> 108

(make-rat 3 3)
; -> 216
(newline)


; The solutions for the roots did not become obvious.


; Looking up some solutions, this is the hint I wish someone could have given me:

; For example, if we evaluate (cons 5 6) we get a result of 23328.
; The corresponding implementation of car needs to take the value 23328 and tell us what that the original value of a was 5.
; We can do that by counting the number of times 23328 is evenly divisible by 2.
; Since 2 and 3 have no factors in common, once you divide all the 2s out of 23328 you'll be left with a power of 3.

; Stole the best abstracted solution I could find to understand how this works.
(define (largest-power-of-n-in-z n z) 
  (if (= (remainder z n) 0) 
      (+ 1 (largest-power-of-n-in-z n (/ z n))) 
      0)) 
  
(define (car z) 
  (largest-power-of-n-in-z 2 z)) 
  
(define (cdr z) 
  (largest-power-of-n-in-z 3 z)) 

(car (make-rat 2 3))
(cdr (make-rat 3 2))

; This solution was a bit easier to follow till I truely understood what was happening:
  
; (define (car z)            
;   (if (= (gcd z 2) 1)      
;     0                      
;     (+ 1 (car (/ z 2))))) 
;  
; (define (cdr z)           
;   (if (= (gcd z 3) 1)     
;     0                     
;     (+ 1 (cdr (/ z 3))))) 
