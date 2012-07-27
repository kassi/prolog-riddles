%!bp -g "['mastermind32.pro']"
%
% @author       Karsten Silkenbäumer
% @description  Solve a Sudoku/Kakuro mixture like riddle
%               The riddle is given by solving MasterMind 3.
%               This is riddle no. 2.
% @system       b-prolog

:-
    write('------------------------------'),nl,
    statistics(runtime,[Start|_]),
    run,
    statistics(runtime,[End|_]),
    T is End-Start,
    write('------------------------------'),nl,
    write('execution time: '),write(T),write(' milliseconds'),nl.

run:-
    vars(Vars,Spez),
    labeling(Vars),
    display_board(Vars,Spez).

vars(Board,Spez):-
    % set up board boundaries
    Board = [
		A1,B1,C1,D1,E1,F1,G1,H1,I1,
		A2,B2,C2,D2,E2,F2,G2,H2,I2,
		A3,B3,C3,D3,E3,F3,G3,H3,I3,
		A4,B4,C4,D4,E4,F4,G4,H4,I4,
		A5,B5,C5,D5,E5,F5,G5,H5,I5,
		A6,B6,C6,D6,E6,F6,G6,H6,I6,
		A7,B7,C7,D7,E7,F7,G7,H7,I7,
		A8,B8,C8,D8,E8,F8,G8,H8,I8,
		A9,B9,C9,D9,E9,F9,G9,H9,I9
	],

    % define special fields for the result
    Spez = [
        E1,B2,H2,A3,F3,D4,H5,A6,F6,F8,H8,C9
    ],

    Board in 1..9,
    % in each row the numbers are unique
    alldifferent([A1,B1,C1,D1,E1,F1,G1,H1,I1]),
    alldifferent([A2,B2,C2,D2,E2,F2,G2,H2,I2]),
    alldifferent([A3,B3,C3,D3,E3,F3,G3,H3,I3]),
    alldifferent([A4,B4,C4,D4,E4,F4,G4,H4,I4]),
    alldifferent([A5,B5,C5,D5,E5,F5,G5,H5,I5]),
    alldifferent([A6,B6,C6,D6,E6,F6,G6,H6,I6]),
    alldifferent([A7,B7,C7,D7,E7,F7,G7,H7,I7]),
    alldifferent([A8,B8,C8,D8,E8,F8,G8,H8,I8]),
    alldifferent([A9,B9,C9,D9,E9,F9,G9,H9,I9]),
    alldifferent([A9,B9,C9,D9,E9,F9,G9,H9,I9]),
    % in each column the numbers are unique
	alldifferent([A1,A2,A3,A4,A5,A6,A7,A8,A9]),
	alldifferent([B1,B2,B3,B4,B5,B6,B7,B8,B9]),
	alldifferent([C1,C2,C3,C4,C5,C6,C7,C8,C9]),
	alldifferent([D1,D2,D3,D4,D5,D6,D7,D8,D9]),
	alldifferent([E1,E2,E3,E4,E5,E6,E7,E8,E9]),
	alldifferent([F1,F2,F3,F4,F5,F6,F7,F8,F9]),
	alldifferent([G1,G2,G3,G4,G5,G6,G7,G8,G9]),
	alldifferent([H1,H2,H3,H4,H5,H6,H7,H8,H9]),
	alldifferent([I1,I2,I3,I4,I5,I6,I7,I8,I9]),
	% given sums
	A1+B1 #= 3,
	C1+C2 #= 9,
	D1+E1+F1 #= 19,
	G1+H1 #= 10,
	I1+I2 #= 12,
	A2+A3+A4 #= 22,
	B2+B3 #= 13,
	D2+E2 #= 7,
	F2+G2 #= 9,
	H2+H3+I3+I4 #= 16,
	C3+D3 #= 13,
	E3+F3+F4 #= 8,
	G3+G4 #= 11,
	B4+C4 #= 10,
	D4+E4+D5 #= 21,
	H4+H5 #= 8,
	A5+A6 #= 4,
	B5+C5 #= 7,
	E5+F5+F6+G5 #= 28,
	I5+I6+I7 #= 8,
	B6+A7+B7 #= 21,
	C6+D6+E6 #= 17,
	G6+H6 #= 11,
	C7+C8 #= 8,
	D7+E7+E8 #= 12,
	F7+F8 #= 3,
	G7+G8+G9 #= 16,
	H7+H8 #= 13,
	A8+A9 #= 12,
	B8+B9+C9 #= 19,
	D8+D9 #= 8,
	I8+H9+I9 #= 18,
	E9+F9 #= 9.

display_board([A1,B1,C1,D1,E1,F1,G1,H1,I1,
		A2,B2,C2,D2,E2,F2,G2,H2,I2,
		A3,B3,C3,D3,E3,F3,G3,H3,I3,
		A4,B4,C4,D4,E4,F4,G4,H4,I4,
		A5,B5,C5,D5,E5,F5,G5,H5,I5,
		A6,B6,C6,D6,E6,F6,G6,H6,I6,
		A7,B7,C7,D7,E7,F7,G7,H7,I7,
		A8,B8,C8,D8,E8,F8,G8,H8,I8,
		A9,B9,C9,D9,E9,F9,G9,H9,I9],Spez):-nl,
    write([A1,B1,C1,D1,E1,F1,G1,H1,I1]),nl,
    write([A2,B2,C2,D2,E2,F2,G2,H2,I2]),nl,
    write([A3,B3,C3,D3,E3,F3,G3,H3,I3]),nl,
    write([A4,B4,C4,D4,E4,F4,G4,H4,I4]),nl,
    write([A5,B5,C5,D5,E5,F5,G5,H5,I5]),nl,
    write([A6,B6,C6,D6,E6,F6,G6,H6,I6]),nl,
    write([A7,B7,C7,D7,E7,F7,G7,H7,I7]),nl,
    write([A8,B8,C8,D8,E8,F8,G8,H8,I8]),nl,
    write([A9,B9,C9,D9,E9,F9,G9,H9,I9]),nl,
    nl,
    sumlist(Spez,S),
    write('Summe der speziellen Felder F = '),write(S),nl.
