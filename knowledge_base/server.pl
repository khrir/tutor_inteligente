:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(equacao).

:- http_handler('/delta', handle_delta, []).
:- http_handler('/raizes', handle_raizes, []).
:- http_handler('/tipo', handle_tipo, []).

handle_delta(Request) :-
    http_read_json_dict(Request, Dict),
    delta(Dict.a, Dict.b, Dict.c, D),
    reply_json_dict(_{delta: D}).

handle_tipo(Request) :-
    http_read_json_dict(Request, Dict),
    tipo_raizes(Dict.a, Dict.b, Dict.c, Tipo),
    reply_json_dict(_{tipo: Tipo}).

handle_raizes(Request) :-
    http_read_json_dict(Request, Dict),
    bhaskara(Dict.a, Dict.b, Dict.c, Resultado),
    reply_json_dict(_{resultado: Resultado}).

start_server :-
    http_server(http_dispatch, [port(5000)]),
    thread_get_message(_).  % impede que o servidor encerre

:- initialization(start_server, main).
