%!bp -g "['symbols.pro']"
%
% @author       Karsten Silkenbäumer
% @description  Solve a symbolic riddle of the following form (symbols replaced with letters)
%               VYVK  -  ZJZ  =  WVL
%                  -       *       +
%                 VX  *   ZL  =  XWJ
%               ====     ===     ===
%                 KI  +  ZZK  =  XYL
% @system       b-prolog
% @run          bp -g "['symbols.pro']"

:-
    write('------------------------------'),nl,
    statistics(runtime,[Start|_]),
    run,
    statistics(runtime,[End|_]),
    T is End-Start,
    write('------------------------------'),nl,
    write('execution time: '),write(T),write(' milliseconds'),nl.

run:-
    vars(Vars),
    labeling(Vars),
    display_board(Vars).

vars(Vars):-
    Vars=[V,W,X,Y,Z,I,J,K,L],
    Vars in 0..9,
    A1#=(V*1000+Y*100+V*10+K),
    A2#=(V*10+X),
    A3#=(K*10+I),
    A4#=(Z*100+J*10+Z),
    A5#=(Z*10+L),
    A6#=(Z*100+Z*10+K),
    A7#=(W*100+V*10+L),
    A8#=(X*100+W*10+J),
    A9#=(X*100+Y*10+L),
    A1/A2#=A3,
    A4+A5#=A6,
    A7-A8#=A9,
    A1-A4#=A7,
    A2*A5#=A8,
    A3+A6#=A9,
    alldifferent([V,W,X,Y,Z,I,J,K,L]).

display_board([V,W,X,Y,Z,I,J,K,L]):-
    write('Solution:'),nl,nl,
    write('V='),write(V),nl,
    write('W='),write(W),nl,
    write('X='),write(X),nl,
    write('Y='),write(Y),nl,
    write('Z='),write(Z),nl,
    write('I='),write(I),nl,
    write('J='),write(J),nl,
    write('K='),write(K),nl,
    write('L='),write(L),nl.
