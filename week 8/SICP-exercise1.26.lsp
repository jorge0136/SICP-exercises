;; Exercise 1.26.  Louis Reasoner is having great difficulty doing exercise 1.24.
;; His fast-prime? test seems to run more slowly than his prime? test. Louis calls
;; his friend Eva Lu Ator over to help. When they examine Louis's code, they find
;; that he has rewritten the expmod procedure to use an explicit multiplication,
;; rather than calling square:

;; (define (expmod base exp m)
;;   (cond ((= exp 0) 1)
;;         ((even? exp)
;;          (remainder (* (expmod base (/ exp 2) m)
;;                        (expmod base (/ exp 2) m))
;;                     m))
;;         (else
;;          (remainder (* base (expmod base (- exp 1) m))
;;                     m))))

;; ``I don't see what difference that could make,'' says Louis. ``I do.'' says Eva.
;;  ``By writing the procedure like that, you have transformed the (log n) process
;;  into a (n) process.'' Explain.

  ;; Here is the implementation of square.
  (define ( square x ) (* x x))

  ;; Compare Louis's implementation against...
  ;; (define (expmod base exp m)
  ;;   (cond ((= exp 0) 1)
  ;;         ((even? exp)
  ;;         (remainder (square (expmod base (/ exp 2) m))
  ;;                     m))
  ;;         (else
  ;;         (remainder (* base (expmod base (- exp 1) m))
  ;;                     m))))

  ;; We have to compute `expmod base (/ exp 2)` an extra time for each iteration.
  ;; expmod in it's own right will end doing significant extra work computing duplicate steps.
  ;; This transforms our process from a linear recursive to a tree recursive process.

  ;; Ideally I'd like to have math to prove this (log n) --> (n) process but I am not sure how.
