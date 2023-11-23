:-[aufg4_test].

%%%%%%%% AUFGABE 4 %%%%%%%%

%%%%%% occurs_check %%%%%%%
% prüft ob eine Variable im Term vorkommt scheitert, falls die Variable im Term vorkommt

%% A1
occurs_check(Variable, Term):- var(Variable), var(Term), not(Variable==Term).

%% A2
occurs_check(Variable, Term):- nonvar(Term), Term=..[OP|Args], occurs_check_list(Variable, Args).

%% A3
occurs_check_list(Variable, [Arg|Tail]):- occurs_check(Variable, Arg), occurs_check_list(Variable, Tail).
%%% Abbruchbedingung für A3
occurs_check_list(Variable, []):-true.

%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% my_unify %%%%%%%%

my_unify(Term1, Term2):-unifiziere(Term1, Term2).

% UNIFIZIERT TERME REKURSIV
unifiziere(Term1, Term2) :- var(Term1), var(Term2), Term1 \= Term2, Term1 = Term2.
unifiziere(Term1, Term2) :- var(Term1), nonvar(Term2), occurs_check(Term1, Term2), Term1 = Term2.
unifiziere(Term1, Term2) :- nonvar(Term1), var(Term2), occurs_check(Term2, Term1), Term2 = Term1.

% HILFPRÄDIKATE
% KONTROLLIERT LÄNGE ZWEIER TERME UND OP DER OPERTOR IDENTISCH IST
length_check(Term1, Term2):-Term1=..[OP1|Args1], Term2=..[OP2|Args2], OP1==OP2, length(Args1, L1), length(Args2, L2), L1==L2.

% BEREITET TERME AUF FÜR occurs_check
occurs_check_checker(Term1, Term2):-Term2=..[OP2|Args2], occurs_check_checker_really(Term1, Args2).
occurs_check_checker_really(Term1, [Args2Head|Args2Tail]):-occurs_check(Args2Head, Term1), occurs_check_checker_really(Term1, Args2Tail).
occurs_check_checker_really(Term1, []):-true.
