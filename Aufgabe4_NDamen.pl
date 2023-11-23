:-[aufg4_test].

%Löst das n-Damen-Problem durch eine Liste: Index=Spalte, Zahl=Reihe

%A2: Initialisiert indem Dame 1 auf die 1 gesetzt wird
queens_N(Anzahl, Ausgabe):- Output=[], Filler=[1], Letzte=1, append(Output, Filler, NeuerOutput), ndamenExec(Anzahl, NeuerOutput, Letzte, Ausgabe).
queens_8(Q):-queens_N(8, Ausgabe).

%%%%%Output%%%%%
ndamenExec(Anzahl, Output, _Letzte, Ausgabe):- length(Output, Laenge), Laenge==Anzahl, ndamen(Anzahl, Output, Output).
ndamen(Anzahl, Output, Ausgabe):-print(Output).

%Fragt die verschiedenen Schritte ab  A1: Ist die Liste abgearbeitet      %A3: Sonderfall n<4
ndamenExec(Anzahl, Output, Letzte, Ausgabe):- ndamenLaengenCheck(Anzahl, Output), Anzahl<4, ndamen2weiter(Anzahl, Output, Letzte, Ausgabe).
                                                                          %A4: Sonderfall n==4
ndamenExec(Anzahl, Output, Letzte, Ausgabe):- ndamenLaengenCheck(Anzahl, Output), Anzahl==4, length(Output, Laenge), Laenge\=3, ndamen2weiter(Anzahl, Output, Letzte, Ausgabe).
ndamenExec(Anzahl, Output, Letzte, Ausgabe):- ndamenLaengenCheck(Anzahl, Output), Anzahl==4, length(Output, Laenge), Laenge==3, ndamenAuf2(Anzahl, Output, Letzte, Ausgabe).
                                                                          %A5: Ungerade Anzahl
ndamenExec(Anzahl, Output, Letzte, Ausgabe):- ndamenLaengenCheck(Anzahl, Output), Anzahl>4, mod(Anzahl, 2)=:=1, length(Output, Laenge), Laenge\=((Anzahl+1)/2), ndamen2weiter(Anzahl, Output, Letzte, Ausgabe).
ndamenExec(Anzahl, Output, Letzte, Ausgabe):- ndamenLaengenCheck(Anzahl, Output), Anzahl>4, mod(Anzahl, 2)=:=1, length(Output, Laenge), Laenge==((Anzahl+1)/2), ndamenAuf2(Anzahl, Output, Letzte, Ausgabe).
                                                                          %A6: Gerade Anzahl
ndamenExec(Anzahl, Output, Letzte, Ausgabe):- ndamenLaengenCheck(Anzahl, Output), Anzahl>4, mod(Anzahl, 2)=:=0, length(Output, Laenge), Laenge\=(Anzahl/2), ndamen2weiter(Anzahl, Output, Letzte, Ausgabe).
ndamenExec(Anzahl, Output, Letzte, Ausgabe):- ndamenLaengenCheck(Anzahl, Output), Anzahl>4, mod(Anzahl, 2)=:=0, length(Output, Laenge), Laenge==(Anzahl+/2), ndamenAuf2(Anzahl, Output, Letzte, Ausgabe).

%Versetzen der Dame auf die 2
ndamenAuf2(Anzahl, Output, _Letzte, Ausgabe):-NeueLetzte is 2, NeueDame=[NeueLetzte], append(Output, NeueDame, NeuerOutput), ndamenExec(Anzahl, NeuerOutput, NeueLetzte, Ausgabe).

%Versetzen der Dame um 2
ndamen2weiter(Anzahl, Output, Letzte, Ausgabe):-NeueLetzte is Letzte+2, NeueDame=[NeueLetzte], append(Output, NeueDame, NeuerOutput), ndamenExec(Anzahl, NeuerOutput, NeueLetzte, Ausgabe).

ndamenLaengenCheck(Anzahl, Output):-length(Output, Laenge), Anzahl\=Laenge.
