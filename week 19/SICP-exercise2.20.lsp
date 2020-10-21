#lang sicp
;; Exercise 2.20.  The procedures +, *, and list take arbitrary numbers of arguments. One way to define such procedures is to use define with dotted-tail notation. In a procedure definition, a parameter list that has a dot before the last parameter name indicates that, when the procedure is called, the initial parameters (if any) will have as values the initial arguments, as usual, but the final parameter's value will be a list of any remaining arguments. For instance, given the definition

;; (define (f x y . z) <body>)

;; the procedure f can be called with two or more arguments. If we evaluate

;; (f 1 2 3 4 5 6)

;; then in the body of f, x will be 1, y will be 2, and z will be the list (3 4 5 6). Given the definition

;; (define (g . w) <body>)

;; the procedure g can be called with zero or more arguments. If we evaluate

;; (g 1 2 3 4 5 6)

;; then in the body of g, w will be the list (1 2 3 4 5 6).11

(define (same-parity a . z)
   (define (iter items answer)
     (if (null? items)
         answer
         (iter (cdr items)
               (if (= (remainder (car items) 2)
                      (remainder a 2))
                   (append answer (list (car items)))
                   answer))))
   (iter z (list a)))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)

