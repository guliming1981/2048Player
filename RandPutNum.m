
% put a num into the matrix's rand position

function new_board = RandPutNum(board, num)
	new_board = board;
	
	empty = find(board==0);
	len = length(empty);
	
	if len == 0
		error('Matrix is full\n');
		return;
	end
	
	r = ceil(len*rand(1));
	
	i = ceil(empty(r)/4);
	j = empty(r) - i * 4 + 4;
	
	new_board(j, i) = num;
end
