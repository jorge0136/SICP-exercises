#lang racket
(require racket/trace)
;; Shamelessly stolen from https://stackoverflow.com/questions/24226924/using-trace-to-display-a-procedure-in-racket.
;; I would prefer simple print debugging but I can't figure out how.

(define sum (λ (x y) (+ x y)))
(define multiply
  (λ (x y)
    (multiply-aux x y x)
    ))
(define multiply-aux (λ (x y res)
                       (if (= y 0) 0
                           (if (= y 1) res
                               (multiply-aux x (- y 1) (sum res x))))))
(trace sum)
(multiply 2 2)
