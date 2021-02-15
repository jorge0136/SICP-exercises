#lang sicp

;Exercise 2.53.  What would the interpreter print in response to evaluating each of the following expressions?

(list 'a 'b 'c) ; --> Provides a list of strings characters in a list. 

(list (list 'george)) ; --> Provides a list of lists, with the value of the single inner list containing the string 'george.

(cdr '((x1 x2) (y1 y2)))

(cadr '((x1 x2) (y1 y2)))
(pair? (car '(a short list)))

; Red doesn't seem to be a string, nor is it a variable. I don't get it. 
(memq 'red '((red shoes) (blue socks)))

(memq 'red '(red shoes blue socks))
