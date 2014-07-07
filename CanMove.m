% Judge if board can be moved in specified direction
% direction: 1 left; 2 right; 3 up; 4 down;

function res = CanMove(board, direction)
	res = 0;
	
	if direction < 1 || direction > 4
		%printf("Direction is error\n");
		return;
	end;
	
	height = size(board, 1);
	width  = size(board, 2);
	
	xdif = 0;
	ydif = 0;
	switch direction
	case 1
		xdif = -1;
	case 2
		xdif = 1;
	case 3
		ydif = -1;
	case 4
		ydif = 1;
	end;
	
	for i = 1:height
		for j = 1:width
			if i+ydif < 1 || i+ydif > 4 || j+xdif < 1 || j+xdif >4
				continue;
			end
			
			if IsMovable(board(i, j), board(i+ydif, j+xdif))
				res = 1;
				return
			end
		end
	end
	%printf("OK\n");
end

function move = IsMovable(self, nextPos)
	move = 0;
	
	if 0 == self
		return;
	end
	
	if 0 == nextPos || nextPos == self
		move = 1;
	end
end
