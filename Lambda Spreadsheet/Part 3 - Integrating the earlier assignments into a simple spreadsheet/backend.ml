open Printf
type data = Val of float | Null;;  (*UNUSED*)
type sheet = data list list ref;;     (*UNUSED*)

let m = int_of_string (Sys.argv.(2));;
let n = int_of_string (Sys.argv.(3));;

let testsheet : data list list ref = ref []
let test_sheet: sheet =
     ref [
          [Null;    Null;     Null;     Null;     Null;     Null;     Null;     Null];
          [Null;    Val(5.0); Val(2.0); Null;     Val(3.0); Null;     Val(7.0); Val(8.0)];
          [Null;    Val(1.0); Val(2.0); Val(3.0); Val(4.0); Null;     Val(5.0); Null];
          [Null;    Val(4.0); Null;     Null;     Val(6.0); Val(3.0); Null;     Null];
          [Null;    Val(10.0);Val(9.0); Val(2.0); Null;     Val(1.0); Null;     Null];
          [Null;    Null;     Val(4.0); Val(6.0); Null;     Val(5.0); Null;     Null];
          [Null;    Null;     Null;     Val(1.0); Null;     Val(0.5); Val(1.5); Null];
          [Null;    Val(3.0); Null;     Val(-2.0);Null;     Val(1.0); Val(8.0); Null];
          [Null;    Null;     Null;     Null;     Null;     Null;     Null;     Null];
          [Null;    Null;     Null;     Null;     Null;     Null;     Null;     Null]
     ];;
(*It takes a list of strings as input and convert it into a list of 'data' type, Null or Val(float)*)
let rec make_list list = match list with
[] -> []
| e::l -> (match e with
          "" ->  Null :: make_list l
          |" " ->  Null :: make_list l
          | s -> Val(float_of_string (s)) :: make_list l)

(*It uses the previous function and makes a sheet: data list list*)
let getvalue x = match x with
    Null ->0.0
 | Val(p) -> p;;
 (*PRINT SHEET*)
 (*Print a single row*)
let rec print_row row = match row with
      [] -> ()
      | x::xs -> if x=Null then (print_string "Null" ; print_string " " ; print_row xs)
                else (print_float (getvalue x) ; print_string " " ; print_row xs);;
     (*Uses previous function to print the entire sheet*)
let rec print_sheet s = match s with
      []   -> ()
      |x::xs    -> print_row x; print_string "\n"; print_sheet xs;;
(*PRINT SHEET*)

(*It acts as an accumulator to all the input rows*)
let make_sheet sheet list = sheet @ [list]

(*Reading CSV FILE*)
let _ =
     try
          let in_stream = open_in Sys.argv.(1) in
              for i=0 to (m-1) do
                let line = input_line in_stream in
                let split = Str.split (Str.regexp ",") in
                let values = split line in
                  testsheet := make_sheet !testsheet (make_list values);
              done;
              print_sheet !testsheet;
              print_string "----------------------------***----------------------------\n";
              close_in in_stream;
     with e ->
     Printf.printf "File not found!";
     raise e


(*INSERT DATA AT INDEX*)
(*Replaces a cell with data into a row at ib position, c is a counter with 1.0 initially*)
let rec insert_in_row row ib c data = match row with
     |    [] -> []
     |    x::xs -> if c=ib then Val(data) :: insert_in_row xs ib (c +. 1.0) data
                    else x :: insert_in_row xs ib (c +. 1.0) data;;

(*Inserts data into the sheet, i.e. replaces cell at (a,b) with data*)
let rec insert_in_sheet s (a,b) c data = match s with
     | [] -> []
     | x::xs -> if c=a then insert_in_row x b 0.0 data :: insert_in_sheet xs (a,b) (c+.1.0) data
                    else x::insert_in_sheet xs (a,b) (c+.1.0) data;;
(*INSERT DATA AT INDEX*)

(*GET DATA AT INDEX*)
(*Fetches a data from a row at a position*)
let rec get_from_row row a i = match row with
     []->Null
     | x::xs -> if i=a then x else get_from_row xs a (i+.1.0);;

(*Fetches the value at (a,b) from a sheet s*)
let rec get_from_sheet s (a,b) i = match s with
     [] -> Null
     | x::xs -> if i=a then get_from_row x b 0.0 else get_from_sheet xs (a,b) (i+.1.0);;

(*GET DATA AT INDEX*)

(*ROW COUNT*)
(*Counts no of valid entries in a row between sc=start column and ec=end column*)
let rec row_count_helper2 row sc ec i count= match row with
     | [] -> count
     | x::xs -> if (i>=sc && i<=ec) then (
                                   if x=Null then row_count_helper2 xs sc ec (i+.1.0) count
                                   else row_count_helper2 xs sc ec (i+.1.0) (count+.1.0)
                                   )
               else if i<sc then row_count_helper2 xs sc ec (i+.1.0) (count)
               else count;;

(*Counts no of valid entries in sheet in a range, inserts correspondingly in the sheet and returns final sheet*)
let rec row_count_helper1 s1 s2 ((sr,sc),(er,ec)) (ia,ib) i= match s2 with
     | [] -> s1
     | x::xs -> if (i>=sr && i<=er) then (
                         row_count_helper1 (insert_in_sheet s1 (ia,ib) 0.0 (row_count_helper2 x sc ec 0.0 0.0)) xs ((sr,sc),(er,ec)) (ia+.1.0,ib) (i+.1.0)
                         )
          else if (i>er) then s1
          else row_count_helper1 s1 xs ((sr,sc),(er,ec)) (ia,ib) (i+.1.0);;

let row_count s r i= row_count_helper1 s s r i 0.0;;
(*ROW COUNT*)

(*ROW SUM*)
(*Calculates sum of valid entries in a row between sc=start column and ec=end column*)
let rec row_sum_helper2 row sc ec i count= match row with
     | [] -> count
     | x::xs -> if (i>=sc && i<=ec) then (
                              if x=Null then row_sum_helper2 xs sc ec (i+.1.0) count
                              else row_sum_helper2 xs sc ec (i+.1.0) (count+. (getvalue x))
                                   )
               else if i<sc then row_sum_helper2 xs sc ec (i+.1.0) (count)
               else count;;
(*Calculates sum of valid entries in sheet in a range, inserts correspondingly in the sheet and returns final sheet*)
let rec row_sum_helper1 s1 s2 ((sr,sc),(er,ec)) (ia,ib) i= match s2 with
     | [] -> s1
     | x::xs -> if (i>=sr && i<=er) then (
                         row_sum_helper1 (insert_in_sheet s1 (ia,ib) 0.0 (row_sum_helper2 x sc ec 0.0 0.0)) xs ((sr,sc),(er,ec)) (ia+.1.0,ib) (i+.1.0)
                         )
          else if (i>er) then s1
          else row_sum_helper1 s1 xs ((sr,sc),(er,ec)) (ia,ib) (i+.1.0);;

let row_sum s r i= row_sum_helper1 s s r i 0.0;;
(*ROW SUM*)

(*ROW AVG*)
(*Uses row_count and row_sum to find the averages*)
let rec row_avg_helper1 s1 s2 ((sr,sc),(er,ec)) (ia,ib) i= match s2 with
     | [] -> s1
     | x::xs -> if (i>=sr && i<=er) then (
                    row_avg_helper1 (insert_in_sheet s1 (ia,ib) 0.0 ((row_sum_helper2 x sc ec 0.0 0.0)/.(row_count_helper2 x sc ec 0.0 0.0))) xs ((sr,sc),(er,ec)) (ia+.1.0,ib) (i+.1.0)
                         )
          else if (i>er) then s1
          else row_avg_helper1 s1 xs ((sr,sc),(er,ec)) (ia,ib) (i+.1.0);;

let row_avg s r i= row_avg_helper1 s s r i 0.0;;
(*ROW AVG*)

(*ROW MIN*)
(*Return the first valid entry between the sc and ec, for comparison*)
let rec getmin_helper2 r sc ec i = match r with
     [] -> Null
     |x::xs -> if(i>=sc && i<=ec) then (
                              if (x=Null) then getmin_helper2 xs sc ec (i+.1.0) else x
                              )
               else if i<sc then getmin_helper2 xs sc ec (i+.1.0)
               else Null;;

(*Returns the minimum value in a row between sc=startcolumn and ec=endcolumn*)
let rec getmin_helper1 r sc ec i min = match r with
     []   -> min
|    x::xs -> if (i<sc) then getmin_helper1 xs sc ec (i+.1.0) min
               else if (i>=sc && i <=ec) then (
                    if x=Null then getmin_helper1 xs sc ec (i+.1.0) min
                    else (
                              if (getvalue x) < min then (getmin_helper1 xs sc ec (i+.1.0) (getvalue x))
                              else getmin_helper1 xs sc ec (i+.1.0) min
                         )
                    )
               else min;;
(*Returns the minimum value in a range*)
let rec getmin_helper s1 s2 ((sr,sc),(er,ec)) (a,b) i = match s2 with
     []   -> s1
|    x::xs -> if (i<sr) then (getmin_helper s1 xs ((sr,sc),(er,ec)) (a,b) (i+.1.0))
               else if (i>=sr && i<=er) then
     getmin_helper (insert_in_sheet s1 (a,b) 0.0 (getmin_helper1 x sc ec 0.0 (getvalue (getmin_helper2 x sc ec 0.0)))) xs ((sr,sc),(er,ec)) (a+.1.0,b) (i+.1.0)
               else s1;;

let row_min s r i = getmin_helper s s r i 0.0;;
(*ROW MIN*)

(*ROW MAX*)
(*Return the first valid entry between the sc and ec, for comparison*)
let rec getmax_helper2 r sc ec i = match r with
     [] -> Null
     |x::xs -> if(i>=sc && i<=ec) then (
                              if (x=Null) then getmax_helper2 xs sc ec (i+.1.0) else x
                              )
               else if i<sc then getmax_helper2 xs sc ec (i+.1.0)
               else Null;;
(*Returns the maximum value in a row between sc=startcolumn and ec=endcolumn*)
let rec getmax_helper1 r sc ec i max = match r with
     []   -> max
|    x::xs -> if (i<sc) then getmax_helper1 xs sc ec (i+.1.0) max
               else if (i>=sc && i <=ec) then (
                    if x=Null then getmax_helper1 xs sc ec (i+.1.0) max
                    else (
                              if (getvalue x) > max then (getmax_helper1 xs sc ec (i+.1.0) (getvalue x))
                              else getmax_helper1 xs sc ec (i+.1.0) max
                         )
                    )
               else max;;
(*Returns the maximum value in a range*)
let rec getmax_helper s1 s2 ((sr,sc),(er,ec)) (a,b) i = match s2 with
     []   -> s1
|    x::xs -> if (i<sr) then (getmax_helper s1 xs ((sr,sc),(er,ec)) (a,b) (i+.1.0))
               else if (i>=sr && i<=er) then
     getmax_helper (insert_in_sheet s1 (a,b) 0.0 (getmax_helper1 x sc ec 0.0 (getvalue (getmax_helper2 x sc ec 0.0)))) xs ((sr,sc),(er,ec)) (a+.1.0,b) (i+.1.0)
               else s1;;

let row_max s r i = getmax_helper s s r i 0.0;;
(*ROW MAX*)

(*FULL COUNT*)
(*Counts the no of valid entries in a row between sc=start column and ec=end column*)
let rec full_count_helper2 row sc ec i count= match row with
     | [] -> count
     | x::xs -> if (i>=sc && i<=ec) then (
                                   if x=Null then full_count_helper2 xs sc ec (i+.1.0) count
                                   else full_count_helper2 xs sc ec (i+.1.0) (count+.1.0)
                                   )
               else if i<sc then full_count_helper2 xs sc ec (i+.1.0) (count)
               else count;;
(*Counts the no of valid entries in a row in a range*)
let rec full_count_helper1 s ((sr,sc),(er,ec)) i count = match s with
     | [] -> count
     | x::xs -> if (i<sr) then full_count_helper1 xs ((sr,sc),(er,ec)) (i+.1.0) count
               else if (i>=sr && i<=er) then (
               full_count_helper1 xs ((sr,sc),(er,ec)) (i+.1.0) (count+.(full_count_helper2 x sc ec 0.0 0.0))
                    )
               else count;;
let full_count s r i = (insert_in_sheet s i 0.0 (full_count_helper1 s r 0.0 0.0));;
(*FULL COUNT*)

(*FULL SUM*)
(*Calculates the sum of valid entries in a row between sc=start column and ec=end column*)
let rec full_sum_helper2 row sc ec i sum= match row with
     | [] -> sum
     | x::xs -> if (i>=sc && i<=ec) then (
                              if x=Null then full_sum_helper2 xs sc ec (i+.1.0) sum
                              else full_sum_helper2 xs sc ec (i+.1.0) (sum+.(getvalue x))
                              )
               else if i<sc then full_sum_helper2 xs sc ec (i+.1.0) (sum)
               else sum;;
(*Calculates the sum of all the valid enties in a range*)
let rec full_sum_helper1 s ((sr,sc),(er,ec)) i sum = match s with
     | [] -> sum
     | x::xs -> if (i<sr) then full_sum_helper1 xs ((sr,sc),(er,ec)) (i+.1.0) sum
               else if (i>=sr && i<=er) then (
               full_sum_helper1 xs ((sr,sc),(er,ec)) (i+.1.0) (sum+.(full_sum_helper2 x sc ec 0.0 0.0))
                    )
               else sum;;
let full_sum s r i = (insert_in_sheet s i 0.0 (full_sum_helper1 s r 0.0 0.0));;
(*FULL SUM*)

(*FULL AVG*)
(*Uses full_count and full_sum to calculate the average o all the valid entries*)
let full_avg s r i = (insert_in_sheet s i 0.0 ((full_sum_helper1 s r 0.0 0.0)/.(full_count_helper1 s r 0.0 0.0)));;
(*FULL AVG*)

(*FULL MIN*)
(*Returns the minimum of the first row, for comparison*)
let rec full_min_helper3 s i ((sr,sc),(er,ec)) = match s with
     []   -> 0.0
|    x::xs -> if (i<sr) then full_min_helper3 xs (i+.1.0) ((sr,sc),(er,ec))
               else getmin_helper1 x sc ec 0.0 (getvalue (getmin_helper2 x sc ec 0.0));;
(*Returns the minimum in the range*)
let rec full_min_helper2 s ((sr,sc),(er,ec)) i min = match s with
          [] -> min
     |   x::xs -> if (i<sr) then full_min_helper2 xs ((sr,sc),(er,ec)) (i+.1.0) min
               else if (i>=sr && i<=er) then (
                    if (getmin_helper1 x sc ec 0.0 (getvalue (getmin_helper2 x sc ec 0.0))) < min then full_min_helper2 xs ((sr,sc),(er,ec)) (i+.1.0) (getmin_helper1 x sc ec 0.0 (getvalue (getmin_helper2 x sc ec 0.0)))
                    else full_min_helper2 xs ((sr,sc),(er,ec)) (i+.1.0) min
                         )
               else min;;
let full_min s r i = insert_in_sheet s i 0.0 (full_min_helper2 s r 0.0 (full_min_helper3 s 0.0 r));;
(*FULL MIN*)

(*FULL MAX*)
(*Returns the maximum of the first row, for comparison*)
let rec full_max_helper3 s i ((sr,sc),(er,ec)) = match s with
     []   -> 0.0
|    x::xs -> if (i<sr) then full_max_helper3 xs (i+.1.0) ((sr,sc),(er,ec))
               else getmax_helper1 x sc ec 0.0 (getvalue (getmax_helper2 x sc ec 0.0));;
(*Returns the maximum in the range*)
let rec full_max_helper2 s ((sr,sc),(er,ec)) i max = match s with
          [] -> max
     |   x::xs -> if (i<sr) then full_max_helper2 xs ((sr,sc),(er,ec)) (i+.1.0) max
               else if (i>=sr && i<=er) then (
                    if (getmax_helper1 x sc ec 0.0 (getvalue (getmax_helper2 x sc ec 0.0))) > max then full_max_helper2 xs ((sr,sc),(er,ec)) (i+.1.0) (getmax_helper1 x sc ec 0.0 (getvalue (getmax_helper2 x sc ec 0.0)))
                    else full_max_helper2 xs ((sr,sc),(er,ec)) (i+.1.0) max
                         )
               else max;;
let full_max s r i = insert_in_sheet s i 0.0 (full_max_helper2 s r 0.0 (full_max_helper3 s 0.0 r));;
(*FULL MAX*)

(*TRANSPOSE*)
(*I have done all the query on column using the previously made functions for row, but first transposing the sheet and tranposing the result*)
let rec transpose list = match list with
       []             -> []
     | []   :: xss    -> transpose xss
     | (x::xs) :: xss -> (x :: List.map List.hd xss) :: transpose (xs :: List.map List.tl xss);;
(*TRANSPOSE*)

(*COL COUNT*)
let col_count_helper s ((sr,sc),(er,ec)) (a,b) = transpose (row_count (transpose s) ((sc,sr),(ec,er)) (b,a));;
let col_count s r i = col_count_helper s r i;;
(*COL COUNT*)

(*COL SUM*)
let col_sum_helper s ((sr,sc),(er,ec)) (a,b) = transpose (row_sum (transpose s) ((sc,sr),(ec,er)) (b,a));;
let col_sum s r i = col_sum_helper s r i;;
(*COL SUM*)

(*COL AVG*)
let col_avg_helper s ((sr,sc),(er,ec)) (a,b) = transpose (row_avg (transpose s) ((sc,sr),(ec,er)) (b,a));;
let col_avg s r i = col_avg_helper s r i;;
(*COL AVG*)

(*COL MIN*)
let col_min_helper s ((sr,sc),(er,ec)) (a,b) = transpose (row_min (transpose s) ((sc,sr),(ec,er)) (b,a));;
let col_min s r i = col_min_helper s r i;;
(*COL MIN*)

(*COL MAX*)
let col_max_helper s ((sr,sc),(er,ec)) (a,b) = transpose (row_max (transpose s) ((sc,sr),(ec,er)) (b,a));;
let col_max s r i = col_max_helper s r i;;
(*COL MIN*)


(*ADD CONSTANT*)
(*Adds constant c to the cell (a,b) and the returns it*)
let add_const_helper2 s (a,b) c = let x = get_from_sheet s (a,b) 0.0 in
     if(x=Null) then c
     else ((getvalue x)+.c);;

(*Add the constant to a single column and fills accordingly in the sheet and returns the sheet*)
let rec add_const_helper3_col s sr sc er sc (a,b) c = if (sr<=er) then (
               add_const_helper3_col (insert_in_sheet s (a,b) 0.0 (add_const_helper2 s (sr,sc) c)) (sr+.1.0) sc er sc (a+.1.0,b) c)
          else s;;
(*Using the previously made column added, it add every columns and stores it in the sheet and returns it*)
let rec add_const_helper1 s ((sr,sc),(er,ec)) (a,b) c= if (sc<=ec) then (
     add_const_helper1 (add_const_helper3_col s sr sc er sc (a,b) c) ((sr,(sc+.1.0)),(er,ec)) (a,b+.1.0) c
               )
               else s;;

let add_const s r c i = add_const_helper1 s r i c;;
(*ADD CONSTANT*)
(*All the functions for adding constant are done similar way except changing the operator*)
(*SUBT CONSTANT*)
(*Subtracts constant c to the cell (a,b) and the returns it*)
let subt_const_helper2 s (a,b) c = let x = get_from_sheet s (a,b) 0.0 in
     if(x=Null) then -.c
     else ((getvalue x)-.c);;

let rec subt_const_helper3_col s sr sc er sc (a,b) c = if (sr<=er) then (
               subt_const_helper3_col (insert_in_sheet s (a,b) 0.0 (subt_const_helper2 s (sr,sc) c)) (sr+.1.0) sc er sc (a+.1.0,b) c)
          else s;;

let rec subt_const_helper1 s ((sr,sc),(er,ec)) (a,b) c= if (sc<=ec) then (
     subt_const_helper1 (subt_const_helper3_col s sr sc er sc (a,b) c) ((sr,(sc+.1.0)),(er,ec)) (a,b+.1.0) c
               )
               else s;;
let subt_const s r c i = subt_const_helper1 s r i c;;
(*SUBT CONSTANT*)

(*MULT CONSTANT*)
let mult_const_helper2 s (a,b) c = let x = get_from_sheet s (a,b) 0.0 in
     if(x=Null) then 0.0
     else ((getvalue x)*.c);;

let rec mult_const_helper3_col s sr sc er sc (a,b) c = if (sr<=er) then (
               mult_const_helper3_col (insert_in_sheet s (a,b) 0.0 (mult_const_helper2 s (sr,sc) c)) (sr+.1.0) sc er sc (a+.1.0,b) c)
          else s;;

let rec mult_const_helper1 s ((sr,sc),(er,ec)) (a,b) c= if (sc<=ec) then (
     mult_const_helper1 (mult_const_helper3_col s sr sc er sc (a,b) c) ((sr,(sc+.1.0)),(er,ec)) (a,b+.1.0) c
               )
               else s;;
let mult_const s r c i = mult_const_helper1 s r i c;;
(*MULT CONSTANT*)

(*DIV CONSTANT*)
let div_const_helper2 s (a,b) c = let x = get_from_sheet s (a,b) 0.0 in
     if(x=Null) then 0.0
     else ((getvalue x)/.c);;

let rec div_const_helper3_col s sr sc er sc (a,b) c = if (sr<=er) then (
               div_const_helper3_col (insert_in_sheet s (a,b) 0.0 (div_const_helper2 s (sr,sc) c)) (sr+.1.0) sc er sc (a+.1.0,b) c)
          else s;;

let rec div_const_helper1 s ((sr,sc),(er,ec)) (a,b) c= if (sc<=ec) then (
     div_const_helper1 (div_const_helper3_col s sr sc er sc (a,b) c) ((sr,(sc+.1.0)),(er,ec)) (a,b+.1.0) c
               )
               else s;;
let div_const s r c i = div_const_helper1 s r i c;;
(*DIV CONSTANT*)

(*ADD RANGE*)
(*It add values at two indices and returns it*)
let add_range_helper2 s (a,b) (c,d) = let x = get_from_sheet s (a,b) 0.0 in
                                        let y = get_from_sheet s (c,d) 0.0 in
     if(x=Null && y=Null) then 0.0
     else if (x=Null) then getvalue y
     else if (y=Null) then getvalue x
     else ((getvalue x)+.(getvalue y));;
(*It adds two columns and stores it in the sheet and returns it*)
let rec add_range_helper3_col s sr1 sc1 er1 (a,b) sr2 sc2 er2 = if (sr1<=er1) then (
                    add_range_helper3_col (insert_in_sheet s (a,b) 0.0 (add_range_helper2 s (sr1,sc1) (sr2,sc2))) (sr1+.1.0) sc1 er1 (a+.1.0,b) (sr2+.1.0) sc2 er2
                    )
                    else s;;
(*Using previuous made column added, it adds all the columns and stores int the sheet and returns it*)
let rec add_range_helper s ((sr1,sc1),(er1,ec1)) (a,b) ((sr2,sc2),(er2,ec2)) = if (sc1<=ec1) then (
               add_range_helper (add_range_helper3_col s sr1 sc1 er1 (a,b) sr2 sc2 er2) ((sr1,sc1+.1.0),(er1,ec1)) (a,b+.1.0) ((sr2,sc2+.1.0),(er2,ec2))
               )
               else s;;
let add_range s r1 r2 i = add_range_helper s r1 i r2;;
(*ADD RANGE*)
(*All the below are similar implementations except the operator is changed*)
(*SUBT RANGE*)
let subt_range_helper2 s (a,b) (c,d) = let x = get_from_sheet s (a,b) 0.0 in
                                        let y = get_from_sheet s (c,d) 0.0 in
     if(x=Null && y=Null) then 0.0
     else if (x=Null) then (-.getvalue y)
     else if (y=Null) then (getvalue x)
     else ((getvalue x)-.(getvalue y));;

let rec subt_range_helper3_col s sr1 sc1 er1 (a,b) sr2 sc2 er2 = if (sr1<=er1) then (
                    subt_range_helper3_col (insert_in_sheet s (a,b) 0.0 (subt_range_helper2 s (sr1,sc1) (sr2,sc2))) (sr1+.1.0) sc1 er1 (a+.1.0,b) (sr2+.1.0) sc2 er2
                    )
                    else s;;

let rec subt_range_helper s ((sr1,sc1),(er1,ec1)) (a,b) ((sr2,sc2),(er2,ec2)) = if (sc1<=ec1) then (
               subt_range_helper (subt_range_helper3_col s sr1 sc1 er1 (a,b) sr2 sc2 er2) ((sr1,sc1+.1.0),(er1,ec1)) (a,b+.1.0) ((sr2,sc2+.1.0),(er2,ec2))
               )
               else s;;
let subt_range s r1 r2 i = subt_range_helper s r1 i r2;;
(*SUBT RANGE*)

(*MULT RANGE*)
let mult_range_helper2 s (a,b) (c,d) = let x = get_from_sheet s (a,b) 0.0 in
                                        let y = get_from_sheet s (c,d) 0.0 in
     if(x=Null && y=Null) then 0.0
     else if (x=Null) then 0.0
     else if (y=Null) then 0.0
     else ((getvalue x)*.(getvalue y));;

let rec mult_range_helper3_col s sr1 sc1 er1 (a,b) sr2 sc2 er2 = if (sr1<=er1) then (
                    mult_range_helper3_col (insert_in_sheet s (a,b) 0.0 (mult_range_helper2 s (sr1,sc1) (sr2,sc2))) (sr1+.1.0) sc1 er1 (a+.1.0,b) (sr2+.1.0) sc2 er2
                    )
                    else s;;

let rec mult_range_helper s ((sr1,sc1),(er1,ec1)) (a,b) ((sr2,sc2),(er2,ec2)) = if (sc1<=ec1) then (
               mult_range_helper (mult_range_helper3_col s sr1 sc1 er1 (a,b) sr2 sc2 er2) ((sr1,sc1+.1.0),(er1,ec1)) (a,b+.1.0) ((sr2,sc2+.1.0),(er2,ec2))
               )
               else s;;
let mult_range s r1 r2 i = mult_range_helper s r1 i r2;;
(*MULT RANGE*)

(*DIV RANGE*)
let div_range_helper2 s (a,b) (c,d) = let x = get_from_sheet s (a,b) 0.0 in
                                        let y = get_from_sheet s (c,d) 0.0 in
     if(x=Null && y=Null) then 0.0
     else if (x=Null) then 0.0
     else if (y=Null) then 0.0
     else ((getvalue x)/.(getvalue y));;

let rec div_range_helper3_col s sr1 sc1 er1 (a,b) sr2 sc2 er2 = if (sr1<=er1) then (
                    div_range_helper3_col (insert_in_sheet s (a,b) 0.0 (div_range_helper2 s (sr1,sc1) (sr2,sc2))) (sr1+.1.0) sc1 er1 (a+.1.0,b) (sr2+.1.0) sc2 er2
                    )
                    else s;;

let rec div_range_helper s ((sr1,sc1),(er1,ec1)) (a,b) ((sr2,sc2),(er2,ec2)) = if (sc1<=ec1) then (
               div_range_helper (div_range_helper3_col s sr1 sc1 er1 (a,b) sr2 sc2 er2) ((sr1,sc1+.1.0),(er1,ec1)) (a,b+.1.0) ((sr2,sc2+.1.0),(er2,ec2))
               )
               else s;;
let div_range s r1 r2 i = div_range_helper s r1 i r2;;
(*DIV RANGE*)