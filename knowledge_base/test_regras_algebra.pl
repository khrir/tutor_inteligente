% test_regras_algebra.pl (Versão 100% Corrigida)

:- begin_tests(regras_algebra_expandido).
:- use_module(regras_algebra).

% -----------------------------------------------------------------------------
% Testes de Unidade para Transformações Específicas
% -----------------------------------------------------------------------------

% Testa a Regra 1: Eliminar denominador em equação com fração
test(fracao_limpa_denominador, [nondet]) :-
    EqInicial = eq(soma(x, div(6, x)), 5),
    EqEsperada = eq(mult(soma(x, div(6, x)), x), mult(5, x)),
    assertion(transforma(EqInicial, EqEsperada)).

% Testa a Regra 2: Expansão de potência de binômio (x - 3)^2
test(potencia_expande_quadrado, [nondet]) :-
    EqInicial = eq(pot(sub(x, 3), 2), 0),
    EqEsperada = eq(sub(soma(pot(x, 2), pot(3, 2)), mult(2, mult(x, 3))), 0),
    assertion(transforma(EqInicial, EqEsperada)).

% Testa a Regra 3: Expansão de produto de binômios (FOIL)
test(produto_binomios_aplica_foil, [nondet]) :-
    EqInicial = eq(mult(soma(x, 1), sub(x, 2)), 3),
    EqEsperada = eq(sub(soma(mult(x, x), mult(1, x)), soma(mult(x, 2), mult(1, 2))), 3),
    assertion(transforma(EqInicial, EqEsperada)).


% -----------------------------------------------------------------------------
% Testes de Integração: Sequência Completa até a Forma Padrão
% -----------------------------------------------------------------------------

% Caso 1: Equação com Fração
test(sequencia_completa_fracao, [nondet]) :-
    EqInicial = eq(soma(x, div(6, x)), 5),
    resolver(EqInicial, Passos),
    last(Passos, UltimoPasso),
    EqFinalEsperada = eq(sub(soma(pot(x, 2), 6), mult(5, x)), 0),
    assertion(UltimoPasso == EqFinalEsperada),
    !.

% Caso 2: Potência de Binômio
test(sequencia_completa_potencia, [nondet]) :-
    EqInicial = eq(mult(2, pot(sub(x, 3), 2)), 8),
    resolver(EqInicial, Passos),
    last(Passos, UltimoPasso),
    EqFinalEsperada = eq(sub(sub(soma(mult(2, pot(x, 2)), mult(2, pot(3, 2))), mult(2, mult(2, mult(x, 3)))), 8), 0),
    assertion(UltimoPasso == EqFinalEsperada),
    !.

% Caso 3: Produto de Binômios
test(sequencia_completa_produto_binomios, [nondet]) :-
    EqInicial = eq(mult(soma(x, 1), sub(x, 2)), 3),
    resolver(EqInicial, Passos),
    last(Passos, UltimoPasso),
    EqFinalEsperada = eq(sub(sub(soma(pot(x, 2), mult(1, x)), soma(mult(x, 2), mult(1, 2))), 3), 0),
    assertion(UltimoPasso == EqFinalEsperada),
    !.

% Caso 4: Produto Notável Simples (ex: x(x+5) = 6)
test(sequencia_completa_produto_simples, [nondet]) :-
    EqInicial = eq(mult(x, soma(x, 5)), 6),
    resolver(EqInicial, Passos),
    last(Passos, UltimoPasso),
    EqFinalEsperada = eq(sub(soma(pot(x, 2), mult(x, 5)), 6), 0),
    assertion(UltimoPasso == EqFinalEsperada),
    !.

% Caso 5: Reorganização para Forma Padrão (ex: 3x^2 + 5x = 10)
test(sequencia_completa_reorganiza, [nondet]) :-
    EqInicial = eq(soma(mult(3, pot(x, 2)), mult(5, x)), 10),
    resolver(EqInicial, Passos),
    last(Passos, UltimoPasso),
    EqFinalEsperada = eq(sub(soma(mult(3, pot(x, 2)), mult(5, x)), 10), 0),
    assertion(UltimoPasso == EqFinalEsperada),
    !.

:- end_tests(regras_algebra_expandido).
