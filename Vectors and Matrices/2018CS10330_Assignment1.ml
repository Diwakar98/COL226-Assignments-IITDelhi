(*
Assignment1
Name: Diwakar Prajapati
Entryno: 2018CS10330
*)

type vector =  float list;;
type matrix =  float list list;;

exception InvalidInput
exception UnequalVectorSize
exception UnequalMatrixShape
exception IncompatibleMatrixShape
exception SingularMatrix

(* Find the length of vector v.*)
let rec vdim (v:vector): int = match v with
          [] -> 0
     |    x :: xs -> 1 + vdim xs;;

(* Makes zero vector by adding 0.0 n times in an empty list  *)
let rec mkzerov (n:int): vector  = if n = 0 then [] else 0.0 :: mkzerov (n-1);;

(* If the head of the list is 0.0 then is check if the tail is zero of not. The moment it finds any non zero head, it return false without checking further. An empty list is vacuously zero vector*)
let rec iszerov (v:vector): bool = match v with
          [] -> true;
     |    [x] -> if x = 0.0 then true else false
     |    x :: xs -> if x = 0.0 then iszerov xs else false;;

(* If the vector are of same dimension then it adds the vector component wise (add the head and appends it to the rest of the list), else it raises and UnequalVectorSize Exception *)
let rec addv (v1:vector) (v2:vector): vector = if (List.length v1) != (List.length v2) then raise
          UnequalVectorSize else match v1, v2 with
          [],[] -> []
     |    x1 :: xs1, [] -> []
     |    [], x1::xs1 -> []
     |    x1 :: xs1, x2 :: xs2 -> (x1 +. x2) :: addv xs1 xs2;;

(* It multiplies head of each sublist and then appends it to the new empty list recursively *)
let rec scalarmultv (c:float) (v:vector): vector = match v with
          [] -> []
     |    x :: xs -> (x *. c) :: scalarmultv c xs;;

(*If the vectors are not of same dimension then it raises UnequalVectorSize Exception or else it multiplies head to each vector and add it to the the dot product of subvectors *)
let rec dotprodv (v1:vector) (v2:vector): float = if (List.length v1) != (List.length v2) then raise
          UnequalVectorSize else match v1, v2 with
          [],[] -> 0.0
     |    x1 :: xs1, [] -> 0.0
     |    [], x1 :: xs1 -> 0.0
     |    x1 :: xs1, x2 :: xs2 -> (x1 *. x2) +. dotprodv xs1 xs2;;

(*Instead of using inbuilt function List.nth I have made my own function with returns nth element of vector v. Index begins from 1 to the dimension of the vector. It raises an InvalidInput exception is index out of the bound is given as input.*)
let rec ithof v (n:int) = if n<1 || n>(List.length v) then raise InvalidInput else match n,v with
          1,x::xs -> x
     |    n,x::xs -> ithof (xs) (n-1);;

(*It returns the length of a list*)
let rec sizeof ls = match ls with
          [] -> 0
     |    x :: xs -> 1 + sizeof xs;;

(*It uses the formula to calculate the crossproduct of two 3D dimension. Is they are of different dimension the it raises exception. Only for 3 Dimensional vectors*)
let rec crossprodv (v1:vector) (v2:vector): vector =
          if (List.length v1) == (List.length v2) then (
          [( ithof v1 2 *. ithof v2 3 -. ithof v1 3 *. ithof v2 2 );
          -.( ithof v1 1 *. ithof v2 3 -. ithof v1 3 *. ithof v2 1 );
          ( ithof v1 1 *. ithof v2 2 -. ithof v1 2 *. ithof v2 1)] )
          else raise UnequalVectorSize;;

(*It return the tuple of (l1 , l2), where l1 = no of the columns and l2 = no of rows. Apparantly, l1 = length of  matrix and l2 = length of any element of the matrix which is another list.*)
let rec mdim (m:matrix): int*int = match m with
          [] -> 0,0
     |    x :: xs -> ((List.length xs)+1), (List.length x);;

(* It uses the previous function to make zero vector. It appandes zero vectors of size n to an empty list m times *)
let rec mkzerom (m_:int) (n_:int): matrix =  if m_ = 0 then [] else (mkzerov n_) :: (mkzerom (m_-1) (n_));;

(* It also uses the previous function for checking the zero vector, It takes each element of the matrix and check whether it is zero vector of not, if it is a zero vector then it checks for the ramaining matrix else it returns false. Similar to zero vector and empty matrix is vacuously zeromatrix which I have assumed. *)
let rec iszerom (m:matrix): bool = match m with
          []-> true;
     |    x :: xs -> if (iszerov x) then (iszerom xs) else false;;

(* It return a unit vector of m_ dimension, 1 at position i_ and zero at all other position. This is used in making Unit Matrix. *)
let rec mkunitv (m_: int) (i_: int): vector = if m_ = 0 then [] else if m_ = i_ then (1.0 ::
                                   (mkunitv (m_-1) i_))  else (0.0 :: (mkunitv (m_-1) i_)) ;;

(* It is an helper function to make unit matrix. It increments i at each recursion, makes a unit vector with 1 at i and appends it to an empty list to make unit vector of m x m dimension.*)
let rec mkunitm_helper (m_: int) (i_: int): matrix = if i_ = 0 then [] else ((mkunitv m_ i_) ::
                                   (mkunitm_helper m_ (i_-1)));;

(*It calls helper function to make unit matrix of m x m dimension*)
let rec mkunitm (m_:int): matrix = mkunitm_helper m_ m_;;

(* It checks wheter vector v is a unit vector of m dimension with 1 at i or not *)
let rec isunitv (v:vector) (m_:int) (i_:int): bool = if v =[] then false
                    else if ((List.length v) + i_ = m_ + 1) then (if List.hd v = 1.0 then true else false)
                    else ( if List.hd v = 0.0 then (isunitv (List.tl v) m_ i_) else false);;

(*It is a helper funtion for checking unit matrix. I have used the previous function of isunitv to check if whether each element of the matrix is an unit vector 1 at i *)
let rec isunitm_helper (m:matrix) (m_:int) (i_:int) = match m with
          [] -> true
     |    x::xs -> if (isunitv x m_ i_) = true then isunitm_helper xs m_ (i_+1) else false;;

(* It returns boolean value depending on wheter the given matrix in Unit Matrix or not *)
let rec isunitm (m:matrix): bool =
               let row=List.length m in
               let col=List.length (List.hd m) in
               if(row != col) then raise IncompatibleMatrixShape
               else isunitm_helper m (List.length m) 1;;

(*It adds correspoinf element of each matrix to form a new matrix which is the sum of the given two matrix. It also check whether the given matrix are compatible of not*)
let rec addm (m1:matrix) (m2:matrix): matrix =
          match m1,m2 with
          [],[] -> []
     |    a::b,[] -> []
     |    [], a::b -> []
     |    a::b, c::d -> (addv a c) :: addm b d ;;

(* Scales the matrix to c times *)
let rec scalarmultm (c:float) (m:matrix): matrix =  match m with
          [] -> []
     |    x :: xs -> (scalarmultv c x) :: (scalarmultm c xs);;

(* It uses map to transpose the matrix *)
let rec transm (list:matrix): matrix = match list with
       []             -> []
     | []   :: xss    -> transm xss
     | (x::xs) :: xss -> (x :: List.map List.hd xss) :: transm (xs :: List.map List.tl xss);;

(* It return the ith column of the matrix in a vector form. This is used in multiplication os the two matrix. *)
let rec ithcol m i = match m with
          [] -> []
     |    x :: xs -> ithof x i :: ithcol xs i;;

(* This is helper function for multiplication *)
let rec multm_helper (m1:matrix) (m2: matrix) (i:int) (j:int) acc = if j = 0 then
                                   (if i = (List.length m1) then acc :: []
                                   else acc :: (multm_helper m1 m2 (i+1) (List.length (List.hd m2)) []))
                              else
                                   (let temp = dotprodv (ithof m1 i) (ithcol m2 j) in
                                   let temp1 = temp :: acc in
                                   multm_helper m1 m2 i (j-1) temp1);;

(* It calls the helper function to multiply the two vectors *)
let rec multm (m1:matrix) (m2:matrix) =
                    let col1 = List.length (List.hd m1) in
                    let row2 = List.length m2 in
                    if(col1!=row2) then raise UnequalMatrixShape
                    else multm_helper m1 m2 1 (List.length (List.hd m2)) [];;

(* It removes the ath element of a given vector v, i is a temporary counter i=1 when this functin is called *)
let rec remove (v: vector) (i:int) (a: int) = if i=a then List.tl v
                         else List.hd v :: remove (List.tl v) (i+1) a;;

(* It gives a sub matrix after removing the the ath row and bth column. This is used in calculating the determinant of the matrix *)
let rec cofactorm (m1: matrix) (a:int) (b:int): matrix =
                         if m1 = [] then []
                         else if a = 1 then cofactorm (List.tl m1) (a-1) b
                         else (remove (List.hd m1) 1 b) :: cofactorm (List.tl m1) (a-1) b;;

(* This is a a helper function for calculating the determinant of the matrix where i = 1 when it is called.*)
let rec detm_helper (m: matrix) (i:int) = match m with
               []->1.0
          |    x::xs ->
                    (if i > List.length m then 0.0
                    else if i mod 2 = 1 then  (ithof (List.hd m) i) *. (detm_helper (cofactorm m 1 i) 1) +. detm_helper m (i+1)
                    else ((-1.0) *. (ithof (List.hd m) i)) *. (detm_helper (cofactorm m 1 i) 1) +. detm_helper m (i+1));;
(*It returns the determinant of the matrix*)
let rec detm (m:matrix): float =
                    let rowcount = List.length m in
                    let colcount = List.length (List.hd m) in
                    if rowcount != colcount then raise IncompatibleMatrixShape
                    else detm_helper m 1;;

(* It gives the positive determinant of the matrix if i is even else gives the negative determinant *)
let rec minor (m: matrix) (i:int) = if i mod 2 = 0 then detm m else (-1.0) *. detm m;;

(*It takes an input matrix and a-> as row number and find the cofactors of the ath row and return it in form of a vector*)
let rec cofactorrow (m: matrix) (i:int) (a:int) = if i > List.length m then []
                                   else (minor (cofactorm m a i) (i+a)) :: cofactorrow m (i+1) a;;

(*It ccalls the cofactorrow recursively to incrementing a and appends all the cofactor rows to am empty list to form a cofactor matrix*)
let rec cofactormatrix (m: matrix) (i:int) = if i > (List.length m) then []
                              else cofactorrow m 1 i :: cofactormatrix m (i+1);;

(* It returns the adjoint matrix of matrix m by making cofactor of matrix of m and then transposing the same *)
let rec adjoinm (m: matrix) =
                    let rowcount = List.length m in
                    let colcount = List.length (List.hd m) in
                    if rowcount != colcount then raise IncompatibleMatrixShape
                    else transm (cofactormatrix m 1);;

(*It calculate the determinant of the matrix and the adjoint and returns the inverse matrix by dividing the adjoin matrix with the determinant*)
let rec invm (m:matrix): matrix =
               let det = detm m in
               if det = 0.0 then raise SingularMatrix else
               scalarmultm (1.0 /. det) (adjoinm m);;


(*

Test Case 1: detm  [[1.0;2.0;43.0;4.0;5.0;0.0;0.0;4.0];
                    [0.0;7.0;8.0;9.0;9.0;0.0;3.0;4.0];
                    [5.0;6.0;7.0;6.0;5.0;4.0;3.0;2.0];
                    [0.0;9.0;8.0;7.0;0.0;1.0;2.0;3.0];
                    [4.0;5.0;5.0;6.0;7.0;8.0;9.0;0.0];
                    [0.0;0.0;0.0;0.0;5.0;6.0;8.0;9.0];
                    [9.0;8.0;8.0;9.0;9.0;1.0;0.0;3.0];
                    [5.0;6.0;4.0;1.0;1.0;1.0;1.0;1.0]];
Output: 6930540

Test Case 2: addm [[1.0;2.0];[3.0;4.0]] [[5.0;6.0];[7.0;8.0]]
Output: [[6.; 8.]; [10.; 12.]]

Test Case 3: multm [[1.0;2.0];[1.0;0.0];[3.0;2.0]] [[1.0;1.0;6.0;5.0];[0.0;0.0;3.0;2.0]]
Output: [[1.; 1.; 12.; 9.]; [1.; 1.; 6.; 5.]; [3.; 3.; 24.; 19.]]

Test Case 4: isunit [[1.0;0.0];[0.0;1.0]];;
Output: true

Test Case 5: invm [[1.0;2.0;3.0];[4.0;5.0;6.0];[7.0;8.0;9.0]]
Output: SingularMatrix.

*)
