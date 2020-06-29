#lang racket
(require racket/trace)
; Exercise 1.26: Louis Reasoner is having great difficulty doing Exercise 1.24. His fast-prime?
; test seems to run more slowly than his prime? test. Louis calls his friend Eva Lu Ator over to
; help. When they examine Louis’s code, they find that he has rewritten the expmod procedure to use
; an explicit multiplication, rather than calling square:

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
          (* (expmod base (/ exp 2) m)
             (expmod base (/ exp 2) m))
          m))
        (else
         (remainder
          (* base
             (expmod base (- exp 1) m))
          m))))

(trace expmod)
(expmod 999 1009 1011)



; “I don’t see what difference that could make,” says Louis. “I do.” says Eva. “By writing the
; procedure like that, you have transformed the Θ(logn) process into a Θ(n) process.” Explain.

; We're calling expmod twice as many times now when the exp is even rather than squaring the result
; after expmod is recursively called. This is double the work of calling square which will only be
; evaluated after the recursive call.
