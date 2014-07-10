% the main file of 2048 player

function new_board = Main2048()
	new_board = zeros(4);
	new_board = RandPutNum(new_board, 2);
	new_board = RandPutNum(new_board, 2);
	
	round = 4;
	canMove = 1;
	while canMove	
		%direction = RandMove(new_board);
		
		[direction, value] = MaxMinMove(new_board, 1, realmax());
		if direction <= 0 || direction > 4
			canMove = 0;
			%disp(new_board);
			%error("Error1");
			continue;
		end
		
		[new_board, success] = MoveBoard(new_board, direction);
		
		if success
			new_board = RandPutNum(new_board, 2);
			round = round + 2;
			warning(sprintf("Round:%d", round/2));
		else
			canMove = 0;
			disp(direction);
			disp(new_board);
			error("Error2");
		end
	end
end

function [canMove, candidateDirection]  = GetCandidateDirection(board)
	canMove = 0;
	candidateDirection = zeros(1, 4);
	tmp = [4;1;2;3];
	for i=1:4
		if CanMove(board, tmp(i,1))
			canMove = canMove + 1;
			candidateDirection(1, canMove) = tmp(i,1);
		end
	end
end

function direction = RandMove(board)
	direction = 0;
	[canMoveCount, candidateDirection] = GetCandidateDirection(board);
	if 0 == canMoveCount
		return;
	end
	
	di = ceil(canMoveCount*rand(1));
	direction = candidateDirection(1, di);
end

function [direction, value] = MaxMinMove(board, depth, grandValue)
	%board
	%warning(sprintf("EnterMaxMin depth:%d", depth));
	
	[canMoveCount, candidateDirection]  = GetCandidateDirection(board);
	
	direction = 0;
	value = -realmax();
	for i = 1:canMoveCount
		new_direction        = candidateDirection(1, i);
		[new_board, success] = MoveBoard(board, new_direction);
		
		if ~success
			disp(new_direction);
			disp(new_board);
			error("Error3");
			continue;
		end
		
		new_val = realmax();
		nstep = find(0 == new_board);
		len   = length(nstep);
		%warning(sprintf("NextStep:%d", len));
		for m=1 : len
			x = ceil(nstep(m)/4);
			y = nstep(m) - x * 4 + 4;
			new_board1 = new_board;
			new_board1(y, x) = 2;
			
			tmp = new_val;
			if depth > 2
				tmp = CalculateValue(new_board1);
			else
				[dir, tmp] = MaxMinMove(new_board1, depth+1, new_val);
			end
			
			if tmp < value  %alpha beta prune
				new_val = -realmax();
				break;
			end;
			
			if tmp < new_val
				new_val = tmp;
			end
		end
		
		if realmax() == new_val
			error("Error4");
			continue;
		end
		
		if new_val > grandValue  %alpha beta prune
			value = realmax();
			break;
		end;
		
		if new_val > value
			value = new_val;
			direction = new_direction;
		end
	end
	
	%warning(sprintf("OutMaxMin depth:%d", depth));
end

function val = CalculateValue(board)
	%val = sum(all(board==0));
	%return;
	
	val = 0;
	[numCan, candidate] = GetCandidateDirection(board);
	if 0 == numCan
		val = 0;
		return;
	end
	
	l1 = [0.000000001 0.00000001 0.0000001 0.000001]; 
	l2 = [0.01 0.001 0.0001 0.00001]; 
	l3 = [0.1 1 10 100]; 
	l4 = [1000000 100000 10000 1000];
	
	l5 = [0.000001 0.0000001 0.00000001 0.000000001]; 
	l6 = [0.00001 0.0001 0.001 0.01]; 
	l7 = [100 10 1 0.1]; 
	l8 = [1000 10000 100000 1000000];
	
	q1 = [l1; l2; l3; l4];
	q2 = [l1' l2' l3' l4'];
	q3 = [l4; l3; l2; l1];
	q4 = [l4' l3' l2' l1'];
	q5 = [l5; l6; l7; l8];
	q6 = [l5' l6' l7' l8'];
	q7 = [l8; l7; l6; l5];
	q8 = [l8' l7' l6' l5'];
	
	q1 = q1 .* board;
	val_q1 = sum(sum(q1));
	
	%val = val_q1;
	%return;
	
	q2 = q2 .* board;
	val_q2 = sum(sum(q2));
	q3 = q3 .* board;
	val_q3 = sum(sum(q3));
	q4 = q4 .* board;
	val_q4 = sum(sum(q4));
	q5 = q5 .* board;
	val_q5 = sum(sum(q5));
	q6 = q6 .* board;
	val_q6 = sum(sum(q6));
	q7 = q7 .* board;
	val_q7 = sum(sum(q7));
	q8 = q8 .* board;
	val_q8 = sum(sum(q8));
	
	val_group = [val_q1 val_q2 val_q3 val_q4 val_q5 val_q6 val_q7 val_q8];
	val = max(val_group);
	
	#{
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
	#}
	%tmp = board;
	#{
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
	#}
	
	%val = val / sum(best);
	%if val >= 0.99
		%val
		%tmp
	%end
	
	%tmp
	%val
end
