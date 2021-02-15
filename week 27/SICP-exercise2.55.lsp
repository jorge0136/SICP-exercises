#lang sicp
; Exercise 2.55.  Eva Lu Ator types to the interpreter the expression

(car ''abracadabra)

;To her surprise, the interpreter prints back quote. Explain.


; ' is syntactic sugar for (quote).
; Here we are executing `(car (quote (quote ''abracadabra)))

; The outer most member of this list is the procedure `quote`.

; All that said I am confused by the weird footnote on https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-16.html#call_footnote_Temp_229
; Specifically the sentence...
; >  For instance, we could construct the expression (car '(a b c)), which is the same as (car (quote (a b c))), by evaluating (list 'car (list 'quote '(a b c))).

; Finally why is quote a shorthand for `list`? Arent' these distinct things?
