#lang racket
(require racket/trace)
;; Exercise 1.34: Suppose we define the procedure

(define (f g) (g 2))

;; Then we have

;;(f square)
;; 4

;; (f (lambda (z) (* z (+ z 1))))

;;(* 2 (+ 2 1))))
;; 6

;; What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.

(f f)
(f 2)
(2 2)

;;  since 2 isn't a procedure we get an error informing us that it's not possible to apply the arguments.
