#lang racket
(require racket/trace)
; Exercise 1.17: The exponentiation algorithms in this section are based on performing exponentiation
; by means of repeated multiplication. 
; In a similar way, one can perform integer multiplication by means of repeated addition. 
; The following multiplication procedure (in which it is assumed that our language can only add, not multiply) 
; is analogous to the expt procedure:

; (define (* a b)
;   (if (= b 0)
;       0
;       (+ a (* a (- b 1)))))
; This algorithm takes a number of steps that is linear in b. Now suppose we include, 
; together with addition, operations double, which doubles an integer, and halve, which divides an 
; (even) integer by 2. Using these, design a multiplication procedure analogous to fast-expt that 
; uses a logarithmic number of steps.

  ; It wasn't specific about if it should be linear recursive or linear iterative.
  ; Let's assume linear recursive will work to start. 
  ;; (define (fast-expt b n)
  ;;   (cond ((= n 0) 1)
  ;;         ((even? n) (square (fast-expt b (/ n 2))))
  ;;         (else (* b (fast-expt b (- n 1))))))
  
  (define (double x) (* x 2))
  
  ; TODO: Create an odd number guard clause. 
  (define (halve x) (/ x 2))
  (define (even? n)(= (remainder n 2) 0))

  (define (faster* a b)
    (cond ((= b 1) a)
        ((even? b) (faster* (double a) (halve b)))
        (else (+ a (faster* a (- b 1))))))
  
  (trace faster*)
  (faster* 2 2)
  (faster* 4 2)
  (faster* 4 4)
  (faster* 4 6)
  (faster* 450 18)
