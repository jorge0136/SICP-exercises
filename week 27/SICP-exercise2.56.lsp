#lang sicp

; Exercise 2.56.  Show how to extend the basic differentiator to handle more kinds of expressions.
; For instance, implement the differentiation rule ... see book for graphic

;; by adding a new clause to the deriv program and defining appropriate procedures exponentiation?, base, exponent, and make-exponentiation. (You may use the symbol ** to denote exponentiation.) Build in the rules that anything raised to the power 0 is 1 and anything raised to the power 1 is the thing itself.
;

; Bit of coverage of the math that is being done here: 
; https://www.youtube.com/watch?v=OpB6rULADSU
; It immediately begs the question of familiarity with several concepts:

; 1. Product rule
; 2. Quotient rule
; 3. Chain rule

; Diving into calc again makes me reference a few resources immediately:

; Originally a book by SILVANUS P. THOMPSON
; 1. http://calculusmadeeasy.org/

