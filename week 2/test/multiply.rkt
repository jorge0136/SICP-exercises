#lang racket

(define sum (λ (x y) (+ x y)))
(define multiply
  (λ (x y)
    (multiply-aux x y x)
    ))
(define multiply-aux (λ (x y res)
                       (if (= y 0) 0
                           (if (= y 1) res
                               (multiply-aux x (- y 1) (sum res x))))))
(provide sum
         multiply)
