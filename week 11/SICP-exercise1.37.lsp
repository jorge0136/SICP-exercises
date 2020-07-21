#lang sicp

;; Exercise 1.37: An infinite continued fraction is an expression of the form f=N1D1+N2D2+N3D3+…. As
;; an example, one can show that the infinite continued fraction expansion with the Ni and the Di
;; all equal to 1 produces 1/φ, where φ is the golden ratio (described in 1.2.2). One way to
;; approximate an infinite continued fraction is to truncate the expansion after a given number of
;; terms. Such a truncation—a so-called finite continued fraction k-term finite continued
;; fraction—has the form N1D1+N2⋱+NkDk. Suppose that n and d are procedures of one argument (the
;; term index i) that return the Ni and Di of the terms of the continued fraction. Define a
;; procedure cont-frac such that evaluating (cont-frac n d k) computes the value of the k-term
;; finite continued fraction. Check your procedure by approximating 1/φ using


;; for successive values of k. How large must you make k in order to get an approximation that is
;; accurate to 4 decimal places?

;; If your cont-frac procedure generates a recursive process, write one that generates an iterative
;; process. If it generates an iterative process, write one that generates a recursive process.

(define (cont-frac n d k)
  (define (frac i)
    (if ( < i k)
        (/ (n i)(+ (d i) (frac (+ i 1))))
        (/ (n i)(d i))))
 (frac 1))



(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           5)

;; .625

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           10)

;; .6179


(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           11)

;; .6180


;; we're shooting for .6180

;; If your cont-frac procedure generates a recursive process, write one that generates an iterative
;; process. If it generates an iterative process, write one that generates a recursive process.

(define (cont-frac-iterative n d k)
  (define (frac i result)
    (if ( < i k)
        (/ (n i)(+ (d i) (frac (+ i 1) result)))
       result))
 (frac 1 (/ (n 1)(d 1))))

(cont-frac-iterative (lambda (i) 1.0)
           (lambda (i) 1.0)
           11)
