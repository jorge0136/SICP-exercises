; Using the results of Exercise 1.16 and Exercise 1.17, devise a procedure that generates an iterative process for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number of steps.

; a = 5
; b = 6
;
; a    b    c
; ________________________
; 5  * 6 +  0 = 30
; 10 * 3 +  0 = 30
; 10 * 2 + 10 = 30
; 20 * 1 + 10 = 30
;
; even = {
;   a = a * 2
;   b = b / 2
;   c = 0
; }
;
; odd = {
;   a = a
;   b = b - 1
;   c = a + c
; }

(define (* a b)
  (*-iter a b 0))

(define (*-iter a b c)
  (cond ((= b 0) c)
    ((even? b)
     (*-iter (+ a a) (/ b 2) c))
    (else (*-iter a (- b 1) (+ a c)))))
