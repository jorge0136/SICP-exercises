#lang sicp

; Exercise 2.13: Show that under the assumption of small percentage tolerances there is a simple
; formula for the approximate percentage tolerance of the product of two intervals in terms of the
; tolerances of the factors. You may simplify the problem by assuming that all numbers are
; positive.

; After considerable work, Alyssa P. Hacker delivers her finished system. Several years later,
; after she has forgotten all about it, she gets a frenzied call from an irate user, Lem E.
; Tweakit. It seems that Lem has noticed that the formula for parallel resistors can be written in
; two algebraically equivalent ways:

; R1R2/R1+R2

; and

; 1 / (1/R1) + (1/R2)

; He has written the following two programs, each of which computes the parallel-resistors formula
; differently:

(define (par1 r1 r2)
  (div-interval
   (mul-interval r1 r2)
   (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one
     (add-interval
      (div-interval one r1)
      (div-interval one r2)))))



; Lem complains that Alyssa’s program gives different answers for the two ways of computing. This
; is a serious complaint.


 (define (make-interval a b) (cons a b))
 (define (upper-bound interval) (max (car interval) (cdr interval)))
 (define (lower-bound interval) (min (car interval) (cdr interval)))
 (define (center i) (/ (+ (upper-bound i) (lower-bound i)) 2))

(define (add-interval x y)
  (make-interval (+ (lower-bound x)
                    (lower-bound y))
                 (+ (upper-bound x)
                    (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x)
               (lower-bound y)))
        (p2 (* (lower-bound x)
               (upper-bound y)))
        (p3 (* (upper-bound x)
               (lower-bound y)))
        (p4 (* (upper-bound x)
               (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x
                (make-interval
                 (/ 1.0 (upper-bound y))
                 (/ 1.0 (lower-bound y)))))
