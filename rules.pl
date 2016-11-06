#include 'inputs.pl'.

%% Select
_select(X, [X|Xs], Xs).
_select(X, [Y|Ys], [Y|Zs]):-
    _select(X, Ys, Zs).

_select2(X1, X2, [X1, X2]).

%% Member
_member(X, [X|Ys]).
_member(X, [_|Ys]):-
    _member(X, Ys).

_run(Xss, Nationality, Gender, Result):-
    _select(Xs, Xss, _),
    _select2(X1, X2, Xs),
    _getEmoji(X1, X2, Nationality, Gender, Result).

_getEmoji(X1, X2, Nationality, Gender, Result):-
    data(Number, U, Name, As),
    _member(X1, As),
    _opposite_gender(Gender, OppositeGender),
    not _irrelevant_gender(OppositeGender, As),
    not _hates_flag(Nationality, Name, As),
    Result = U.

_hates_flag(N, Name, As):- _member(flag, As), N = united_states, Name = afghanistan.
_hates_flag(N, Name, As):- _member(flag, As), N = united_states, Name = russia.
_hates_flag(N, Name, As):- _member(flag, As), N = india, Name = pakistan.
_hates_flag(N, Name, As):- _member(flag, As), N = india, Name = venezuela.
_hates_flag(N, Name, As):- _member(flag, As), N = pakistan, Name = israel.

_opposite_gender(Gender, OppositeGender):- Gender = man, OppositeGender = woman.
_opposite_gender(Gender, OppositeGender):- Gender = woman, OppositeGender = man.

_irrelevant_gender(OppositeGender, As):- _member(OppositeGender, As).
