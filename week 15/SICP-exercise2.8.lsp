; Exercise 2.8: Using reasoning analogous to Alyssa’s, describe how the difference of two
; intervals may be computed. Define a corresponding subtraction procedure, called sub-interval.



(define (make-interval a b) (cons a b))

; Lower bound selector returns the first element of the interval.
(define (lower-bound interval)
  (car interval))

; Upper bound selector returns the second element of the interval.
(define (upper-bound interval)
  (cdr interval))

(define x (make-interval 1 10))
(define y (make-interval 2 20))

; Interval  Midpoint  +- Delta
; [3, 7]       5         2
; [2, 4]       3         1

; [1, 3]       2         1  lower x - lower x, upper y - upper y
; [5, -1]      2         3  lower x - upper, upper x - lower y



(define (sub-interval x y)
  (make-interval (- (lower-bound x)
                    (upper-bound y))
                 (- (upper-bound x)
                    (lower-bound y))))

(sub-interval x y) ; -19, 8
