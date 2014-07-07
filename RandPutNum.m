
% put a num into the matrix's rand position

function new_board = RandPutNum(board, num)
	new_board = board;
	
	if ~any(board<=0)
		%printf('Matrix is full\n');
		return;
	end
	
	h = size(board, 1);
	w = size(board, 2);
	
	i = ceil(h*rand(1));
	j = ceil(w*rand(1));
	
	while board(i, j) != 0
		i = ceil(h*rand(1));
		j = ceil(w*rand(1));
	end
	
	new_board(i, j) = num;
end
