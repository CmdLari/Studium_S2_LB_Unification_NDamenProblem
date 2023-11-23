:-[aufg4_test].

%------ UNIFIKATION ------%
%---- occurs_check/2 -----%

%A1
occurs_check(Variable, Term) :-
    var(Variable),
    var(Term),
    not(Variable == Term).
    
occurs_check(Variable, Term):-
    var(Variable),
    var(Term),
    Variable == Term,
    print("Substitution nicht möglich: Variable "),
    print(Variable),
    print("kommt in Term "),
    print(Term),
    print("vor"),
    nl,
    false.

%A2
occurs_check(Variable, Term) :-
    var(Variable),
    nonvar(Term),
    Term =.. [_OP | Args],
    occurs_check_list(Variable, Args).

occurs_check(Variable, Term) :-
    nonvar(Variable),
    var(Term),
    Variable =.. [_OP | Args],
    occurs_check_list(Term, Args).

occurs_check(Variable, Term) :-
    nonvar(Variable),
    nonvar(Term),
    Variable=..[_OP1|Args1],
    Term=..[_OP2|Args2],
    occurs_check_terms(Args1, Args2).

occurs_check_terms([A1H|A1T], [A2H|A2T]) :-
    occurs_check(A1H, A2H),
    occurs_check_terms(A1T, A2T).

occurs_check_terms([], []).

%A3, A4, A5
occurs_check_list(Variable, [Arg | Tail]) :-
    occurs_check(Variable, Arg),
    occurs_check_list(Variable, Tail).

occurs_check_list(_, []).


%----- my_unify/2 -----%

unifikator([Args1H|Args1T], [Args2H|Args2T]):-
    my_unify(Args1H, Args2H),
    unifikator(Args1T, Args2T).

unifikator([], []).

my_unify(Term1, Term2):-
    var(Term1),
    var(Term2),
    %print("Substitution: Variable "),
    %print(Term1),
    %print("mit Variable "),
    %print(Term2),
    Term1 = Term2.

my_unify(Term1, Term2):-
    var(Term1),
    nonvar(Term2),
    occurs_check(Term1, Term2),
    %print("Substitution: Variable "),
    %print(Term1),
    %print("mit Term "),
    %print(Term2),
    Term1 = Term2.

my_unify(Term1, Term2):-
    var(Term2),
    nonvar(Term1),
    occurs_check(Term2, Term1),
    Term1 = Term2.

my_unify(Term1, Term2):-
    nonvar(Term1),
    nonvar(Term2),
    occurs_check(Term1, Term2),
    Term1=..[OP1|Args1],
    Term2=..[OP2|Args2],
    OP1==OP2,
    length(Args1, Length1),
    length(Args2, Length2),
    Length1==Length2,
    unifikator(Args1, Args2).
