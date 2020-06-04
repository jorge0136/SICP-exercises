;; Exercise 1.13.  Prove that Fib(n) is the closest integer to n/5, where  = (1 + 5)/2.
;; Hint: Let  = (1 - 5)/2. Use induction and the definition of the Fibonacci numbers
;; (see section 1.2.2) to prove that Fib(n) = (n - n)/5.

fib(0)
(ψ⁰ - ϕ⁰) / √5
(1 - 1) / √5
0 / √5
0


fib(1)
ψ¹ - ϕ¹ / √5
((1 + √5)/2 - (1 − √5)/2) / √5
2√5/2 / √5
√5 / √5
1

Fib(n - 1) = (ϕn-1 - ψn-1)/√5
Fib(n)     = (ϕn - ψn)/√5

