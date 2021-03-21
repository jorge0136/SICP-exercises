#lang sicp
; Exercise 2.46.  A two-dimensional vector v running from the origin to a point can be represented as
; a pair consisting of an x-coordinate and a y-coordinate. Implement a data abstraction for vectors
; by giving a constructor make-vect and corresponding selectors xcor-vect and ycor-vect. In terms of
; your selectors and constructor, implement procedures add-vect, sub-vect, and scale-vect that
; perform the operations vector addition, vector subtraction, and multiplying a vector by a scalar:

; I referenced back to 2.3 to investigate how we last represented vectors. 

(define (make-vect x y)
  (cons x y))
(define (xcor-vect point) (car point))
(define (ycor-vect point) (cdr point))

; reminder of what all this vector math is about: https://www.3blue1brown.com/essence-of-linear-algebra-page
; What is interesting about this is the maxim about linear algebra is that...

; It's alllll about Vector Addition and Scalar Multiplication. We can get all of the other operators from here. 

; vector summation is to add all Xn terms and all Yn terms.
(define (add-vect vect1 vect2)
  (make-vect (+ (xcor-vect vect1) (xcor-vect vect2))
              (+ (ycor-vect vect1) (ycor-vect vect2))))

; sub-vect
(define (sub-vect vect1 vect2)
  (make-vect (- (xcor-vect vect1) (xcor-vect vect2))
              (- (ycor-vect vect1) (ycor-vect vect2))))

; scale each coordinate of a vector by the scalar.

(define (scale-vect vect scalar)
  (make-vect (* (xcor-vect vect) vect)
              (* (ycor-vect vect) vect)))
