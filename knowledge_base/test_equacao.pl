:- begin_tests(equacao).
:- use_module(equacao).

% Testes para delta
test(delta_positivo) :- delta(1, -3, 2, D), assertion(D =:= 1).
test(delta_zero)     :- delta(1, -2, 1, D), assertion(D =:= 0).
test(delta_negativo) :- delta(1, 2, 5, D), assertion(D =:= -16).


% Testes para tipo de raízes
test(tipo_raizes_distintas) :- tipo_raizes(1, -3, 2, T), !, assertion(T == real_distintas).
test(tipo_raizes_iguais)    :- tipo_raizes(1, -2, 1, T), !, assertion(T == real_iguais).
test(tipo_raizes_complexas) :- tipo_raizes(1, 2, 5, T), !, assertion(T == complexas).


% Testes para bhaskara
test(bhaskara_complexas) :- bhaskara(1, 2, 5, R), assertion(R == complexas).
test(bhaskara_raiz_unica) :- bhaskara(1, -2, 1, raiz_unica(X)), assertion(X =:= 1.0).
test(bhaskara_raizes)     :- bhaskara(1, -3, 2, raizes(X1, X2)), assertion(X1 =:= 2.0), assertion(X2 =:= 1.0).


% Teste para vértice
test(vertice) :- vertice(1, -2, 1, vertice(X, Y)), assertion(X =:= 1.0), assertion(Y =:= 0.0).


% Teste para concavidade
test(concavidade_cima)  :- concavidade(2, cima).
test(concavidade_baixo) :- concavidade(-1, baixo).


% Teste para interseções
test(intersecoes_com_raizes) :-
    intersecoes(1, -3, 2, intersecoes(Xs, Y)),
    assertion(Xs == [2.0, 1.0]),
    assertion(Y == 2).

test(intersecoes_sem_raizes) :-
    intersecoes(1, 2, 5, intersecoes(Xs, Y)),
    assertion(Xs == []),
    assertion(Y == 5).


% Teste para soma e produto das raízes
test(soma_das_raizes)    :- soma_das_raizes(1, -3, 2, S), assertion(S =:= 3.0).
test(produto_das_raizes):- produto_das_raizes(1, -3, 2, P), assertion(P =:= 2.0).


% Teste da forma canônica
test(forma_canonica) :-
    forma_canonica(1, -2, 1, H, K),
    assertion(H =:= 1.0),
    assertion(K =:= 0.0).

:- end_tests(equacao).
