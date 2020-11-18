; Exercise 2.22: Louis Reasoner tries to rewrite the first square-list procedure of Exercise 2.21
; so that it evolves an iterative process:

; (define (square-list items) (define (iter things answer) (if (null? things) answer (iter (cdr
; things) (cons (square (car things)) answer)))) (iter items nil)) Unfortunately, defining
; square-list this way produces the answer list in the reverse order of the one desired. Why?

; Louis then tries to fix his bug by interchanging the arguments to cons:

; (define (square-list items) (define (iter things answer) (if (null? things) answer (iter (cdr
; things) (cons answer (square (car things)))))) (iter items nil)) This doesn’t work either.



; Explain.

1. Each iteration conses the square of car to the answer starting with the first item in the list. This reverses the list.

2. Consing the list to the square creates a deeply nested list. We need to reverse the items before we process them.
