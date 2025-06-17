% Declara este arquivo como um módulo, exportando os predicados públicos.
:- module(regras_algebra, [
    transforma/2,
    resolver_passo_a_passo/1,
    resolver/2
]).

% -----------------------------------------------------------------------------
% PREDICADO PRINCIPAL DE TRANSFORMAÇÃO (PÚBLICO)
% -----------------------------------------------------------------------------

% REGRA 1: Elimina denominador na equação com divisão (A/B = C => A = C * B)
transforma(eq(div(LHS, Den), RHS), eq(LHS, mult(RHS, Den))) :- !.

% REGRA 2: Tenta simplificar o lado esquerdo da equação
transforma(eq(LHS, RHS), eq(NovoLHS, RHS)) :-
    simplifica_passo(LHS, NovoLHS), !.

% REGRA 3: Se LHS não pode ser simplificado, tenta simplificar RHS
transforma(eq(LHS, RHS), eq(LHS, NovoRHS)) :-
    \+ simplifica_passo(LHS, _),
    simplifica_passo(RHS, NovoRHS), !.

% REGRA 4: Se ambos os lados estão simplificados e RHS diferente de zero, passa tudo para LHS
transforma(eq(LHS, RHS), eq(sub(LHS, RHS), 0)) :-
    \+ simplifica_passo(LHS, _),
    \+ simplifica_passo(RHS, _),
    RHS \== 0.

% Regra específica para frações na soma: multiplica ambos os lados pelo denominador
transforma(eq(soma(A, div(B, C)), RHS), eq(mult(soma(A, div(B, C)), C), mult(RHS, C))) :- !.


% -----------------------------------------------------------------------------
% LÓGICA DE SIMPLIFICAÇÃO DE EXPRESSÕES (PREDICADOS INTERNOS)
% -----------------------------------------------------------------------------

% Distributividade da multiplicação sobre subtração: a*(b-c) = a*b - a*c
simplifica_passo(mult(A, sub(B, C)), sub(mult(A, B), mult(A, C))).

% Frações combinadas: a + b/c => (a*c + b)/c
simplifica_passo(soma(A, div(B, C)), div(soma(mult(A, C), B), C)).

% Expansão distributiva e outras simplificações básicas
simplifica_passo(mult(soma(A, B), C), soma(mult(A, C), mult(B, C))).
simplifica_passo(pot(sub(A, B), 2), sub(soma(pot(A, 2), pot(B, 2)), mult(2, mult(A, B)))).
simplifica_passo(pot(soma(A, B), 2), soma(soma(pot(A, 2), pot(B, 2)), mult(2, mult(A, B)))).
simplifica_passo(mult(soma(A,B), sub(C,D)), sub(soma(mult(A,C), mult(B,C)), soma(mult(A,D), mult(B,D)))).
simplifica_passo(mult(A, soma(B, C)), soma(mult(A, B), mult(A, C))).
simplifica_passo(mult(X, X), pot(X, 2)).

% Simplifica multiplicação de fração pelo denominador: (a/b)*b = a
simplifica_passo(mult(div(A, B), B), A).

% Caso específico: multiplica soma que contém fração pelo denominador
simplifica_passo(mult(soma(A, div(B, C)), C), soma(mult(A, C), B)).

% Recorrência: tenta simplificar recursivamente dentro das expressões
simplifica_passo(soma(A, B), soma(NovoA, B)) :- simplifica_passo(A, NovoA).
simplifica_passo(soma(A, B), soma(A, NovoB)) :- \+ simplifica_passo(A, _), simplifica_passo(B, NovoB).

simplifica_passo(sub(A, B), sub(NovoA, B)) :- simplifica_passo(A, NovoA).
simplifica_passo(sub(A, B), sub(A, NovoB)) :- \+ simplifica_passo(A, _), simplifica_passo(B, NovoB).

simplifica_passo(mult(A, B), mult(NovoA, B)) :- simplifica_passo(A, NovoA).
simplifica_passo(mult(A, B), mult(A, NovoB)) :- \+ simplifica_passo(A, _), simplifica_passo(B, NovoB).


% -----------------------------------------------------------------------------
% PREDICADOS DE RESOLUÇÃO (PÚBLICOS)
% -----------------------------------------------------------------------------

% Resolve imprimindo passo a passo
resolver_passo_a_passo(Eq) :-
    write('Equação Inicial: '), writeln(Eq),
    resolver_recursivo_imprime(Eq).

resolver_recursivo_imprime(EqFinal) :-
    \+ transforma(EqFinal, _), !,
    write('Forma final: '), writeln(EqFinal).

resolver_recursivo_imprime(EqAtual) :-
    transforma(EqAtual, ProxEq),
    write('   Transforma -> '), writeln(ProxEq),
    resolver_recursivo_imprime(ProxEq).

% Resolve gerando lista dos passos
resolver(EqInicial, Passos) :-
    resolver_recursivo_lista(EqInicial, [EqInicial], PassosInvertidos),
    reverse(PassosInvertidos, Passos).

resolver_recursivo_lista(EqFinal, Acc, Acc) :- \+ transforma(EqFinal, _), !.
resolver_recursivo_lista(EqAtual, Acc, Passos) :-
    transforma(EqAtual, ProxEq),
    resolver_recursivo_lista(ProxEq, [ProxEq|Acc], Passos).
