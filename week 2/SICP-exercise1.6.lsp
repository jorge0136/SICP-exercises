; Excersise 1.6

; (define (sqrt-iter guess x)
;   (new-if (good-enough? guess x)
;           guess
;           (sqrt-iter (improve guess x) x)))a

; The special form  of `if` has the property that it only evaluates one of it’s parameters, not
; both.  The `new-if` doesn't have this property. It will always evaluate the second parameter and
; therefore continuously call itself because of the last parameter.
