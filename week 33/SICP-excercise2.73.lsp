; Explain what was done above. Why can’t we assimilate the predicates number? and variable? into the data-directed dispatch?
; Write the procedures for derivatives of sums and products, and the auxiliary code required to install them in the table used by the program above.
; Choose any additional differentiation rule that you like, such as the one for exponents (Exercise 2.56), and install it in this data-directed system.
; In this simple algebraic manipulator the type of an expression is the algebraic operator that binds it together. Suppose, however, we indexed the procedures in the opposite way, so that the dispatch line in deriv looked like
; ((get (operator exp) 'deriv)
;  (operands exp) var)
; What corresponding changes to the derivative system are required?

1) We are creating a generic procedure that pulls out the operator of an expression and gets a procedure  a . number and variable can't be assimilated because they have no operator to switch on.
