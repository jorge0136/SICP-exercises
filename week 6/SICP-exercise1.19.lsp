#lang racket
(require racket/trace)
; Exercise 1.19.   There is a clever algorithm for computing the Fibonacci numbers in a logarithmic number of steps.
; Recall the transformation of the state variables a and b in the fib-iter process
; of section 1.2.2: a <- a + b and b <- a. Call this transformation T, and observe that applying T over
; and over again n times, starting with 1 and 0, produces the pair Fib(n + 1) and Fib(n). In other
; words, the Fibonacci numbers are produced by applying Tn, the nth power of the transformation T,
; starting with the pair (1,0). Now consider T to be the special case of p = 0 and q = 1 in a family
;  of transformations Tpq, where Tpq transforms the pair (a,b) according to a  bq + aq + ap and b
; bp + aq. Show that if we apply such a transformation Tpq twice, the effect is the same as using
; a single transformation Tp'q' of the same form, and compute p' and q' in terms of p and q.
; This gives us an explicit way to square these transformations, and thus we can compute Tn using
; successive squaring, as in the fast-expt procedure. Put this all together to complete the
; following procedure, which runs in a logarithmic number of steps:41

  ; My notes on linear algebra that leads into 1.19.
  ; There are two fundamental operations of linear algebra.
    ; Scalar multiplication and vector addition.
  ; With these two operations we can construct linear transformations.
  ; Linear transformations are compositional, they can be function chained together.
  ; Linear transformations are fundamentally matrix multiplication.
  ; This allows us to do some arbitrary transformation multiple times.
  ; Note that linear tranforms are not commutative, order matters.

  ; An excellent primer on what is happening here: http://www.youtube.com/watch?v=kYB8IZa5AuE&t=5m35s
  ; The original transformation (T) started with the vector (1, 0).
  ; T(a, b) = ((a + b), (a))
  ; We can express this linear transformation with the matrix:
    ; 1	1   against the initial vector 1
    ; 1	0                              0
    ; Let's show how this is computed.
    ; 1 [1, 1] + 0[1, 0] = 1, 0 = 1 + 0 = 1
    ;                      1, 0   1 + 0 = 1
    ; Then we would do the 1, 1 transform over again. Which yields
    ;                      1, 0

    ; 1 [1, 1] + 1 [1, 0] = 1, 1 = 1 + 1 = 2
    ;                       1, 0 = 1 + 0 = 1

    ; One more time to express the point.
    ; 2 [1, 1] + 1 [1, 0] = 2, 1 = 2 + 1 = 3
    ;                       2, 0   2 + 0 = 2
    ; And so we can continue this linear transform to the n, yielding fib(n).

  ; Exercise 1.19:
    ; Tpq(a, b) = ((bq + aq + ap), (bp + aq))
    ; Expressed as a matrix we have
    ; p+q,	q
    ; q,	  p

    ; Let's find  Tpq(Tpq(a,b)) aka p' and q'.
    ; p+q, q against the initial vector (bq + aq + ap)
    ; q,   p                            (bp + aq)

    ; (bq + aq + ap)[(p + q), q] + (bp + aq)[q, p] = (bq + aq + ap)(p + q),(bp + aq)(q) = (bq + aq + ap)(p + q) + (bp + aq)(q) = bpq+aq2+bq2+aq2+aqp+bqp+aqp+ap2
    ;                                                (bq + aq + ap)(q), (bp + aq)(p) = (bq + aq + ap)(q) + (bp + aq)(p) = bp2+aqp+bq2+aq2+aqp
    ; Which can be rewritten as:
    ; Tpq(Tpq(a,b))=(b(2qp+q2)+a(q2+p2)+a(2qp+q2),b(p2+q2)+a(2qp+q2))=Tp′q′
    ; p′=p2+q2
    ; q′=2qp+q2

(define ( square x ) (* x x))

(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))
                   (+ (* 2 (* q p)) (square q))
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

;(trace fib-iter)
(fib 0)
(fib 1)
(fib 2)
(fib 3)
(fib 4)
(fib 5)
(fib 6)
(fib 7)

