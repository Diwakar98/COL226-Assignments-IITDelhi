(*-----Assignment-------4*)
*)

In this assignment, all the functions I have made are defined recursively.
Most function have 2 or 3 helper functions. which made me easier for debugging.
In most queries for ranges I have made a helper function(f1) for first doing the same operation on t a row or a column and the used another recursive function(f2) which calls f1 with different row or columns to get do the operation on the range.

My spreadsheet is a 2D list, i.e. list of list of "data" type, data is either Null(which represents that a particular cell is empty) and Val(<float>)(which represents a floating value in the cell).
In my implementation, if we try to add two cells having Null and Null values, then the result is Null. However if we try to add two cell, one having Null and the other having a floating value say 5.2, then as is the case in Microsoft Excel, I am consider the initialy one to be ZERO, so the result is that floating value 5.2.
ADDITON:
Null + Null = Null
Null + <float a> = <float a>
<float a> + <float b> = <float (a+.b)>
SUBTRACTION:
Null - Null = Null
Null - <float a> = <float (-.a)>
<float a> - Null = <float (a)>
<float a> - <float b> = <float (a -. b)>
MULTIPLICATION:
Null * Null = Null
Null * <float a> = <float (0.0)>
<float a> * Null = <float (0.0)>
<float a> * <float b> = <float (a *. b)>
DIVISION:
Null / Null = Null
Null / <float a> = <float (0.0)>
<float a> / Null = <float (0.0)>
<float a> / <float b> = <float (a /. b)>
<float a> / <float 0.0> = <infinity>

A operation is done reading and writing in sheets parallely