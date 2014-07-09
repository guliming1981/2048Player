% the main file of 2048 player

function new_board = Main2048()
	new_board = zeros(4);
	new_board = RandPutNum(new_board, 2);
	new_board = RandPutNum(new_board, 2);
	
	round = 4;
	canMove = 1;
	while canMove
		[canMove, candidateDirection] = GetCandidateDirection(new_board);
		
		if ~canMove
			break;
		end;
		
		%direction = RandMove(candidateDirection, canMove);
		direction = AggresasiveMove(new_board, candidateDirection, canMove, round);
		[new_board, success] = MoveBoard(new_board, direction);
		
		if success
			new_board = RandPutNum(new_board, 2);
			round = round + 2;
		else
			printf("Can not move\n");
		end
		
		%new_board
	end
end

function [canMove, candidateDirection]  = GetCandidateDirection(board)
	canMove = 0;
	candidateDirection = zeros(1, 4);
	for i=1:4
		if CanMove(board, i)
			canMove = canMove + 1;
			candidateDirection(1, canMove) = i;
		end
	end
end

function direction = RandMove(candidateDirection, canMoveCount)
	di = ceil(canMoveCount*rand(1));
	direction = candidateDirection(1, di);
end

function direction = AggresasiveMove(board, candidateDirection, canMoveCount, round)
	direction = 0;
	val = 0;
	for i = 1:canMoveCount
		new_direction        = candidateDirection(1, i);
		[new_board, success] = MoveBoard(board, new_direction);
		
		if ~success
			continue;
		end
			
		new_val = CalDensityValue(new_board, round);
		if new_val > val
			val = new_val;
			direction = new_direction;
		end
	end
end

function direction = SmartMove(board, candidateDirection, canMoveCount, round)
	direction = 0;
end

function val = CalDensityValue(board, roundVal)
	tmp = board;
	val = 0;
	height = size(board, 1);
	width  = size(board, 2);
	for i = 1:height
		for j = 1:width
			if board(i, j) > 0
				n = log2(board(i, j));
				board(i, j) = n;
			else
				%val = val + 1;
			end
		end
	end
	
	%board
	quan  = [1 1 1 1; 1 1 1 1; 1 1 1 1; 10000 1000 100 10];
	board = quan .* board;
	val = sum(sum(board));
	
	best = zeros(1, 4);
	for i = 1:4
		if roundVal <= 0
			break;
		end
		
		n = floor(log2(roundVal));
		if n > 0
			best(1, i) = n*quan(4, i);
			roundVal = roundVal - 2^n;
		else
			break;
		end
	end
	
	val = val / sum(best);
	%if val >= 0.99
		%val
		%tmp
	%end
end
