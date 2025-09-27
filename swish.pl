:- dynamic ponto/2.

trilha(analise_de_dados, 'Analisar grandes numeros de dados').
trilha(machine_learning, 'Desenvolvimento e aprendizado de maquinas').
trilha(seguranca_da_informacao, 'Desenvolvimento de sistemas seguros').
trilha(tic, 'Desenvolvimento de softwares e infraestrutura').
trilha(sistemas_ciberfisicos, 'Desenvolvimento com hardware e IOT').

perfil(analise_de_dados, big_data, 5).
perfil(analise_de_dados, ciencia_de_dados, 3).
perfil(analise_de_dados, sistemas_de_redes, 1).

perfil(machine_learning, desenvolvimento_de_ias, 5).
perfil(machine_learning, programacao_orientada_objetos, 3).
perfil(machine_learning, programacao_logica, 1).

perfil(seguranca_da_informacao, programacao_orientada_objetos, 5).
perfil(seguranca_da_informacao, sistemas_embarcados, 3).
perfil(seguranca_da_informacao, iot, 1).

perfil(tic, sistemas_de_redes, 5).
perfil(tic, iot, 3).
perfil(tic, sistemas_tempo_real, 1).

perfil(sistemas_ciberfisicos, iot, 5).
perfil(sistemas_ciberfisicos, sistemas_de_redes, 4).
perfil(sistemas_ciberfisicos, sistemas_tempo_real, 5).

pergunta(1, 'Teria afinidade com Big Data?', big_data).
pergunta(2, 'Teria afinidade com Programação Lógica e Funcional?', programacao_logica).
pergunta(3, 'Teria afinidade com Redes Convergentes?', sistemas_de_redes).
pergunta(4, 'Teria afinidade com Inteligência Artificial?', desenvolvimento_de_ias).
pergunta(5, 'Teria afinidade com Programação Orientada a Objetos?', programacao_orientada_objetos).
pergunta(6, 'Teria afinidade com Data Science?', ciencia_de_dados).
pergunta(7, 'Teria afinidade com Performance em Sistemas Ciberfísicos?', sistemas_embarcados).
pergunta(8, 'Teria afinidade com Clínica de TIC?', iot).
pergunta(9, 'Teria afinidade com Sistemas Operacionais Ciberfísicos?', sistemas_tempo_real).

iniciar :-
    writeln('Formulário de Carreiras da Computação - Responda s ou n'), nl,
	iniciar_questionario,
	writeln('Obrigado por responder'), nl, 
	seu_resultado.


iniciar_questionario :-
    forall(pergunta(ID, Texto, Disciplina),
           (
               % COMENTADO PARA TESTE MANUAL!!
               % PARA TESTAR OS EXEMPLOS, BASTA COMENTAR A LINHA INDICADA!!
               % (resposta(ID, R) -> true
               % ; format('~w (s/n): ', [Texto]), read_line_to_string(user_input, R)),

               % COMENTE A LINHA ABAIXO PARA TESTAR O MODO DE EXEMPLOS:
               format('~w (s/n): ', [Texto]), read_line_to_string(user_input, R),

               ( member(R, ["s","sim"]) ->
                     forall(perfil(Trilha, Disciplina, Peso),
                            assertz(ponto(Trilha, Peso)))
               ; true ),
               nl
           )
    ).
                                    
seu_resultado :-
    findall((Trilha,Total), 
            (trilha(Trilha,_), findall(P, ponto(Trilha,P), Ps), sum_list(Ps, Total)), 
            Pontuacoes),
    max_pontuacao(Pontuacoes, Max),
    writeln('Melhor afinidade(s):'),
    mostrar_melhor(Pontuacoes, Max).

max_pontuacao(Pontuacoes, Max) :-
    findall(T, member((_,T), Pontuacoes), Totais),
    max_list(Totais, Max).

mostrar_melhor([], _).
mostrar_melhor([(Trilha,Total)|Resto], Max) :-
    Total =:= Max,
    trilha(Trilha, Descricao),
    format('~w - ~w pontos (~w)~n', [Trilha, Total, Descricao]),
    mostrar_melhor(Resto, Max).
mostrar_melhor([_|Resto], Max) :-
    mostrar_melhor(Resto, Max).    
   

