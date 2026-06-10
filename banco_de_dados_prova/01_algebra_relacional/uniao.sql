-- uniao (U)
-- quando usar: juntar os resultados de duas consultas
-- obs prova: as relacoes precisam ser compativeis (mesmo grau e dominios)
--            uniao elimina duplicatas, union all mantem
--            nomes das colunas do resultado vem da primeira consulta

-- exemplo simples
-- cpfs de medicos e pacientes
select cpf from medico
union
select cpf from paciente;

-- exemplo intermediario
-- mantendo duplicatas
select cidade from medico
union all
select cidade from paciente;

-- exemplo estilo prova
-- nome, cpf e idade de todas as pessoas (medicos, pacientes ou funcionarios) de Florianopolis
select nome, cpf, idade from medico where cidade = 'Florianopolis'
union
select nome, cpf, idade from paciente where cidade = 'Florianopolis'
union
select nome, cpf, idade from funcionario where cidade = 'Florianopolis';
