:- module(equacao, [
    delta/4,
    tipo_raizes/4,
    bhaskara/4,
    vertice/4,
    concavidade/2,
    intersecoes/4,
    soma_das_raizes/4,
    produto_das_raizes/4,
    forma_canonica/5
]).

% 1. Discriminante (delta)
delta(A, B, C, D) :- D is B * B - 4 * A * C.

% 2. Tipo de raízes
tipo_raizes(A, B, C, real_distintas) :- delta(A, B, C, D), D > 0.
tipo_raizes(A, B, C, real_iguais)    :- delta(A, B, C, D), D =:= 0.
tipo_raizes(A, B, C, complexas)      :- delta(A, B, C, D), D < 0.

% 3. Fórmula de Bhaskara
bhaskara(A, B, C, Resultado) :-
    delta(A, B, C, D),
    ( D < 0 ->
        Resultado = complexas
    ; D =:= 0 ->
        X is -B / (2 * A),
        Resultado = raiz_unica(X)
    ;
        X1 is (-B + sqrt(D)) / (2 * A),
        X2 is (-B - sqrt(D)) / (2 * A),
        Resultado = raizes(X1, X2)
    ).

% 4. Vértice da parábola
vertice(A, B, C, vertice(Xv, Yv)) :-
    Xv is -B / (2 * A),
    delta(A, B, C, D),
    Yv is -D / (4 * A).

% 5. Concavidade
concavidade(A, cima)  :- A > 0.
concavidade(A, baixo) :- A < 0.

% 6. Interseções com os eixos
intersecoes(A, B, C, intersecoes(Xs, Y)) :-
    ( bhaskara(A, B, C, raizes(X1, X2)) -> Xs = [X1, X2]
    ; bhaskara(A, B, C, raiz_unica(X)) -> Xs = [X]
    ; Xs = []
    ),
    Y is C.

% 7. Soma das raízes
soma_das_raizes(A, B, _C, S) :- A =\= 0, S is -B / A.

% 8. Produto das raízes
produto_das_raizes(A, _B, C, P) :- A =\= 0, P is C / A.

% 9. Forma canônica
forma_canonica(A, B, C, H, K) :-
    H is -B / (2 * A),
    delta(A, B, C, D),
    K is -D / (4 * A).
