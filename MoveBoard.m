%Move board in the specified direction
%	direction: 1 left; 2 right; 3 up; 4 down;
%	return the new board after movement

function new_board = MoveBoard(board, direction)
	new_board = board;
	
	if ~CanMove(board, direction)
		return;
	end
	
	height = size(board, 1);
	width  = size(board, 2);
	
	switch direction
	case 1
		for i = 1:height
			new_board(i,:) = Move(board(i,:), 1, 1);
		end
	case 2
		for i = 1:height
			new_board(i,:) = Move(board(i,:), 4, -1);
		end
	case 3
		for i = 1:width
			new_board(:,i) = (Move(board(:,i), 1, 1))';
		end
	case 4
		for i = 1:width
			new_board(:,i) = (Move(board(:,i), 4, -1))';
		end
	end;
end

function new_line = Move(aLine, start, dif)
	i = start;
	j = start;
	len = length(aLine);
	new_line = zeros(1, len);
	while i > 0 && i <= len
		if aLine(i) != 0
			if new_line(j) == aLine(i)
				new_line(j) = 2*new_line(j);
				j = j + dif;
			elseif new_line(j) == 0
				new_line(j) = aLine(i);
			else
				j = j + dif;
				new_line(j) = aLine(i);
			end
		end
		i = i + dif;
	end
end
