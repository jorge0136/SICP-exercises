#lang sicp

; Exercise 2.27: Modify your reverse procedure of Exercise 2.18 to produce a deep-reverse procedure
; that takes a list as argument and returns as its value the list with its elements reversed and
; with all sublists deep-reversed as well. For example,

(define x
  (list (list 1 2) (list 3 4)))

; x
; ((1 2) (3 4))


; ((3 4) (1 2))


; (append (cdr x)(list (car x)))

(define (reverse list)
  (define (reverse-iter input result)
    (if (null? input)
        result
        (reverse-iter (cdr input) (cons (car input) result))))
  (reverse-iter list nil))

; (reverse x)

(define y
  (list (list 1 2) (list 3 4) (list 5 6)))

; (reverse y)

(define (deep-reverse list)
  (define (reverse-iter input result)
    (cond ((null? input) result)
          ((pair? input)
           (reverse-iter (deep-reverse (cdr input)) (cons (deep-reverse (car input)) result))
          (reverse-iter (cdr input) (cons (car input) result)))))
  (reverse-iter list nil))


(deep-reverse x)
; ((4 3) (2 1))