%!bp -g "['mastermind42.pro']"
%
% @author       Karsten Silkenbäumer
% @description  Solve a Sudoku like riddle
%               The riddle is given by solving MasterMind 4.
%               This is riddle no. 2.
%               - and | define fields
%               = and ‖ define regions
%               place caches into the fields, so that
%               * each row and each column must contain exactly 2 caches
%               * each region must contain exactly 2 caches
%               * adjacent fields (horizontal, verticla, diagonal) must not
%				  contain 2 caches
%               the result is the sum of the caches in fields marked with x
%               And now, some utf-8 "ascii" chart :-)
%				+=======================================+
%				‖ x |   |   |   | x | x ‖   |   ‖   | x ‖
%				‖---+---+========================---+---‖
%				‖   | x ‖   |   |   |   ‖   |   ‖ x |   ‖
%				‖---+---+========---+---+---+---=====---‖
%				‖   |   ‖ x |   ‖   |   |   | x |   ‖   ‖
%				‖---+---+===+---+===+---+=======+====---‖
%				‖   |   |   ‖ x |   ‖   ‖ x |   ‖   |   ‖
%				‖=======+=======+---+===+---+===+=======‖
%				‖ x |   ‖   |   ‖ x | x |   ‖   |   | x ‖
%				‖---+---+===+---+---+---+===+---+=======‖
%				‖ x |   |   ‖   ‖ x | x ‖   |   ‖   | x ‖
%				‖---+---+===+---+---+===+---+===+---+---‖
%				‖   |   ‖   | x ‖   ‖   | x ‖   |   |   ‖
%				‖===+===+---+===+===+=======+---+---+---‖
%				‖   ‖   | x ‖   ‖   |   |   | x |   |   ‖
%				‖---+=======+---============+-------+---‖
%				‖   | x |   |   |   ‖   |   ‖   | x |   ‖
%				‖---+---+---+=======+---+---+===+---+---‖
%				‖ x |   |   ‖   | x | x |   |   ‖   | x ‖
%				+===================‖===================+
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
    Board = [
		A1,B1,C1,D1,E1,F1,G1,H1,I1,J1,
		A2,B2,C2,D2,E2,F2,G2,H2,I2,J2,
		A3,B3,C3,D3,E3,F3,G3,H3,I3,J3,
		A4,B4,C4,D4,E4,F4,G4,H4,I4,J4,
		A5,B5,C5,D5,E5,F5,G5,H5,I5,J5,
		A6,B6,C6,D6,E6,F6,G6,H6,I6,J6,
		A7,B7,C7,D7,E7,F7,G7,H7,I7,J7,
		A8,B8,C8,D8,E8,F8,G8,H8,I8,J8,
		A9,B9,C9,D9,E9,F9,G9,H9,I9,J9,
		A0,B0,C0,D0,E0,F0,G0,H0,I0,J0
	],
	% defined marked fields
	Spez = [A1,E1,F1,J1,B2,I2,C3,H3,D4,G4,A5,E5,F5,J5,A6,E6,F6,J6,D7,G7,C8,H8,B9,I9,A0,E0,F0,J0],
	% define regions
	Geb1 = [A1,B1,C1,D1,E1,F1,A2,B2,A3,B3,A4,B4,C4],
	Geb2 = [G1,H1,I1,J1,I2,J2,J3,I4,J4],
	Geb3 = [C2,D2,E2,F2,G2,H2,E3,F3,G3,H3,I3,F4],
	Geb4 = [C3,D3,D4,E4,E5,F5,G5,G4,H4,E6,F6,E7],
	Geb5 = [A5,B5,A6,B6,C6,A7,B7],
	Geb6 = [C5,D5,D6,C7,D7,B8,C8],
	Geb7 = [H5,I5,J5,G6,H6,F7,G7],
	Geb8 = [A8,A9,B9,C9,D9,E9,D8,A0,B0,C0],
	Geb9 = [I6,J6,H7,I7,J7,E8,F8,G8,H8,I8,J8,H9,I9,J9,I0,J0],
	Geb0 = [F9,G9,D0,E0,F0,G0,H0],
	sum(Geb1) #= 2,
	sum(Geb2) #= 2,
	sum(Geb3) #= 2,
	sum(Geb4) #= 2,
	sum(Geb5) #= 2,
	sum(Geb6) #= 2,
	sum(Geb7) #= 2,
	sum(Geb8) #= 2,
	sum(Geb9) #= 2,
	sum(Geb0) #= 2,
	% rows and columns
	sum([A1,A2,A3,A4,A5,A6,A7,A8,A9,A0]) #= 2,
	sum([B1,B2,B3,B4,B5,B6,B7,B8,B9,B0]) #= 2,
	sum([C1,C2,C3,C4,C5,C6,C7,C8,C9,C0]) #= 2,
	sum([D1,D2,D3,D4,D5,D6,D7,D8,D9,D0]) #= 2,
	sum([E1,E2,E3,E4,E5,E6,E7,E8,E9,E0]) #= 2,
	sum([F1,F2,F3,F4,F5,F6,F7,F8,F9,F0]) #= 2,
	sum([G1,G2,G3,G4,G5,G6,G7,G8,G9,G0]) #= 2,
	sum([H1,H2,H3,H4,H5,H6,H7,H8,H9,H0]) #= 2,
	sum([I1,I2,I3,I4,I5,I6,I7,I8,I9,I0]) #= 2,
	sum([J1,J2,J3,J4,J5,J6,J7,J8,J9,J0]) #= 2,

	sum([A1,B1,C1,D1,E1,F1,G1,H1,I1,J1]) #= 2,
	sum([A2,B2,C2,D2,E2,F2,G2,H2,I2,J2]) #= 2,
	sum([A3,B3,C3,D3,E3,F3,G3,H3,I3,J3]) #= 2,
	sum([A4,B4,C4,D4,E4,F4,G4,H4,I4,J4]) #= 2,
	sum([A5,B5,C5,D5,E5,F5,G5,H5,I5,J5]) #= 2,
	sum([A6,B6,C6,D6,E6,F6,G6,H6,I6,J6]) #= 2,
	sum([A7,B7,C7,D7,E7,F7,G7,H7,I7,J7]) #= 2,
	sum([A8,B8,C8,D8,E8,F8,G8,H8,I8,J8]) #= 2,
	sum([A9,B9,C9,D9,E9,F9,G9,H9,I9,J9]) #= 2,
	sum([A0,B0,C0,D0,E0,F0,G0,H0,I0,J0]) #= 2,

	% greedy adjacent check
	frei(A1, [B1,A2,B2]),
	frei(A2, [A1,A3,B1,B2,B3]),
	frei(A3, [A2,A4,B2,B3,B4]),
	frei(A4, [A3,A5,B3,B4,B5]),
	frei(A5, [A4,A6,B4,B5,B6]),
	frei(A6, [A5,A7,B5,B6,B7]),
	frei(A7, [A6,A8,B6,B7,B8]),
	frei(A8, [A7,A9,B7,B8,B9]),
	frei(A9, [A8,A0,B8,B9,B0]),
	frei(A0, [A9,A4,B9,B0]),

	frei(B1, [A1,A2,B2,C1,C2]),
	frei(B2, [A1,A2,A3,B1,B3,C1,C2,C3]),
	frei(B3, [A2,A3,A4,B2,B4,C2,C3,C4]),
	frei(B4, [A3,A4,A5,B3,B5,C3,C4,C5]),
	frei(B5, [A4,A5,A6,B4,B6,C4,C5,C6]),
	frei(B6, [A5,A6,A7,B5,B7,C5,C6,C7]),
	frei(B7, [A6,A7,A8,B6,B8,C6,C7,C8]),
	frei(B8, [A7,A8,A9,B7,B9,C7,C8,C9]),
	frei(B9, [A8,A9,A0,B8,B0,C8,C9,C0]),
	frei(B0, [A9,A0,B9,C9,C0]),

	frei(C1, [B1,B2,C2,D1,D2]),
	frei(C2, [B1,B2,B3,C1,C3,D1,D2,D3]),
	frei(C3, [B2,B3,B4,C2,C4,D2,D3,D4]),
	frei(C4, [B3,B4,B5,C3,C5,D3,D4,D5]),
	frei(C5, [B4,B5,B6,C4,C6,D4,D5,D6]),
	frei(C6, [B5,B6,B7,C5,C7,D5,D6,D7]),
	frei(C7, [B6,B7,B8,C6,C8,D6,D7,D8]),
	frei(C8, [B7,B8,B9,C7,C9,D7,D8,D9]),
	frei(C9, [B8,B9,B0,C8,C0,D8,D9,D0]),
	frei(C0, [B9,B0,C9,D9,D0]),

	frei(D1, [C1,C2,D2,E1,E2]),
	frei(D2, [C1,C2,C3,D1,D3,E1,E2,E3]),
	frei(D3, [C2,C3,C4,D2,D4,E2,E3,E4]),
	frei(D4, [C3,C4,C5,D3,D5,E3,E4,E5]),
	frei(D5, [C4,C5,C6,D4,D6,E4,E5,E6]),
	frei(D6, [C5,C6,C7,D5,D7,E5,E6,E7]),
	frei(D7, [C6,C7,C8,D6,D8,E6,E7,E8]),
	frei(D8, [C7,C8,C9,D7,D9,E7,E8,E9]),
	frei(D9, [C8,C9,C0,D8,D0,E8,E9,E0]),
	frei(D0, [C9,C0,D9,E9,E0]),

	frei(E1, [D1,D2,E2,F1,F2]),
	frei(E2, [D1,D2,D3,E1,E3,F1,F2,F3]),
	frei(E3, [D2,D3,D4,E2,E4,F2,F3,F4]),
	frei(E4, [D3,D4,D5,E3,E5,F3,F4,F5]),
	frei(E5, [D4,D5,D6,E4,E6,F4,F5,F6]),
	frei(E6, [D5,D6,D7,E5,E7,F5,F6,F7]),
	frei(E7, [D6,D7,D8,E6,E8,F6,F7,F8]),
	frei(E8, [D7,D8,D9,E7,E9,F7,F8,F9]),
	frei(E9, [D8,D9,D0,E8,E0,F8,F9,F0]),
	frei(E0, [D9,D0,E9,F9,F0]),

	frei(F1, [E1,E2,F2,G1,G2]),
	frei(F2, [E1,E2,E3,F1,F3,G1,G2,G3]),
	frei(F3, [E2,E3,E4,F2,F4,G2,G3,G4]),
	frei(F4, [E3,E4,E5,F3,F5,G3,G4,G5]),
	frei(F5, [E4,E5,E6,F4,F6,G4,G5,G6]),
	frei(F6, [E5,E6,E7,F5,F7,G5,G6,G7]),
	frei(F7, [E6,E7,E8,F6,F8,G6,G7,G8]),
	frei(F8, [E7,E8,E9,F7,F9,G7,G8,G9]),
	frei(F9, [E8,E9,E0,F8,F0,G8,G9,G0]),
	frei(F0, [E9,E0,F9,G9,G0]),

	frei(G1, [F1,F2,G2,H1,H2]),
	frei(G2, [F1,F2,F3,G1,G3,H1,H2,H3]),
	frei(G3, [F2,F3,F4,G2,G4,H2,H3,H4]),
	frei(G4, [F3,F4,F5,G3,G5,H3,H4,H5]),
	frei(G5, [F4,F5,F6,G4,G6,H4,H5,H6]),
	frei(G6, [F5,F6,F7,G5,G7,H5,H6,H7]),
	frei(G7, [F6,F7,F8,G6,G8,H6,H7,H8]),
	frei(G8, [F7,F8,F9,G7,G9,H7,H8,H9]),
	frei(G9, [F8,F9,F0,G8,G0,H8,H9,H0]),
	frei(G0, [F9,F0,G9,H9,H0]),

	frei(H1, [G1,G2,H2,I1,I2]),
	frei(H2, [G1,G2,G3,H1,H3,I1,I2,I3]),
	frei(H3, [G2,G3,G4,H2,H4,I2,I3,I4]),
	frei(H4, [G3,G4,G5,H3,H5,I3,I4,I5]),
	frei(H5, [G4,G5,G6,H4,H6,I4,I5,I6]),
	frei(H6, [G5,G6,G7,H5,H7,I5,I6,I7]),
	frei(H7, [G6,G7,G8,H6,H8,I6,I7,I8]),
	frei(H8, [G7,G8,G9,H7,H9,I7,I8,I9]),
	frei(H9, [G8,G9,G0,H8,H0,I8,I9,I0]),
	frei(H0, [G9,G0,H9,I9,I0]),

	frei(I1, [H1,H2,I2,J1,J2]),
	frei(I2, [H1,H2,H3,I1,I3,J1,J2,J3]),
	frei(I3, [H2,H3,H4,I2,I4,J2,J3,J4]),
	frei(I4, [H3,H4,H5,I3,I5,J3,J4,J5]),
	frei(I5, [H4,H5,H6,I4,I6,J4,J5,J6]),
	frei(I6, [H5,H6,H7,I5,I7,J5,J6,J7]),
	frei(I7, [H6,H7,H8,I6,I8,J6,J7,J8]),
	frei(I8, [H7,H8,H9,I7,I9,J7,J8,J9]),
	frei(I9, [H8,H9,H0,I8,I0,J8,J9,J0]),
	frei(I0, [H9,H0,I9,J9,J0]),

	frei(J1, [I1,I2,J2]),
	frei(J2, [I1,I2,I3,J1,J3]),
	frei(J3, [I2,I3,I4,J2,J4]),
	frei(J4, [I3,I4,I5,J3,J5]),
	frei(J5, [I4,I5,I6,J4,J6]),
	frei(J6, [I5,I6,I7,J5,J7]),
	frei(J7, [I6,I7,I8,J6,J8]),
	frei(J8, [I7,I8,I9,J7,J9]),
	frei(J9, [I8,I9,I0,J8,J0]),
	frei(J0, [I9,I0,J9]),

    Board in 0..1.

frei(X,List):-X #= 0.
frei(X,List):-X #= 1, sum(List) #= 0.

display_board([A1,B1,C1,D1,E1,F1,G1,H1,I1,J1,
		A2,B2,C2,D2,E2,F2,G2,H2,I2,J2,
		A3,B3,C3,D3,E3,F3,G3,H3,I3,J3,
		A4,B4,C4,D4,E4,F4,G4,H4,I4,J4,
		A5,B5,C5,D5,E5,F5,G5,H5,I5,J5,
		A6,B6,C6,D6,E6,F6,G6,H6,I6,J6,
		A7,B7,C7,D7,E7,F7,G7,H7,I7,J7,
		A8,B8,C8,D8,E8,F8,G8,H8,I8,J8,
		A9,B9,C9,D9,E9,F9,G9,H9,I9,J9,
		A0,B0,C0,D0,E0,F0,G0,H0,I0,J0
		],Spez):-nl,
    write([A1,B1,C1,D1,E1,F1,G1,H1,I1,J1]),nl,
    write([A2,B2,C2,D2,E2,F2,G2,H2,I2,J2]),nl,
    write([A3,B3,C3,D3,E3,F3,G3,H3,I3,J3]),nl,
    write([A4,B4,C4,D4,E4,F4,G4,H4,I4,J4]),nl,
    write([A5,B5,C5,D5,E5,F5,G5,H5,I5,J5]),nl,
    write([A6,B6,C6,D6,E6,F6,G6,H6,I6,J6]),nl,
    write([A7,B7,C7,D7,E7,F7,G7,H7,I7,J7]),nl,
    write([A8,B8,C8,D8,E8,F8,G8,H8,I8,J8]),nl,
    write([A9,B9,C9,D9,E9,F9,G9,H9,I9,J9]),nl,
    write([A0,B0,C0,D0,E0,F0,G0,H0,I0,J0]),nl,
    nl,
	Sum is sum(Spez),
    write('Summe der belegten speziellen Felder: '),write(Sum),nl.
