let g = [3;6;] in 
let f = [5; 7; 11;] in 


let rec lol thing tmp = 
	(match thing with
		  (5::tail) -> (lol tail (5::tmp))
		| (7::tail) -> (lol tail (7::tmp))
		| (_::tail) -> (lol tail tmp)
		| ([_]) -> tmp
		| (_) -> tmp )
in
List.iter print_int (lol f []);;