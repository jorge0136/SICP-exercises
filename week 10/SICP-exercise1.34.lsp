;; Exercise 1.34: Suppose we define the procedure

(define (f g) (g 2))

;; Then we have

(f square)
4

(f (lambda (z) (* z (+ z 1))))
6

;; What happens if we (perversely) ask the interpreter to evaluate the combination (f f)? Explain.
;;
;; Using this trace
(f, f)
(f, 2) ;; g will be substituted with f
(2, 2) ;; on the second call g will be substituted with 2

;We can't apply 2 to 2 so we get an invalid procedure error;
