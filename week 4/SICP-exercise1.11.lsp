;; Exercise 1.11. A function f is defined by the rule that f(n) = n if n<3 and f(n) = f(n - 1) +
;2f(n - 2) + 3f(n - 3) if n> 3. Write a procedure that computes f by means of a recursive processed
;; Write a procedure that computes f by means of an iterative process.

;recursive process
f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3)
(define (recursive_n n)
  (if (< n 3)
      n
      (+ (recursive_n (- n 1)) (* 2 (recursive_n (- n 2))) (* 3 (recursive_n (- n 3))))

;iterative process

(define (f n)
  (if (< n 3)
  n
  (iterative_n 2 1 0 n)))

(define (iterative_n a b c n)
  (if (< n 3)
      a
      (iterative_n (+ a (* 2 b) (* 3 c))
                    a
                    b
                    (- n 1))))
