-- create view
-- quando usar: salvar uma consulta como "tabela virtual"
-- obs prova: view nao armazena dados, roda a consulta toda vez que e acessada
--            simplifica consultas complexas e controla acesso

-- exemplo simples
create or replace view medicos_floripa as
select codm, nome, especialidade
from medico
where cidade = 'Florianopolis';

select * from medicos_floripa;

-- exemplo intermediario (view com filtro e alias)
create or replace view funcionarios_acima_media as
select nome, salario
from funcionario
where salario > (select avg(salario) from funcionario);

select * from funcionarios_acima_media;

-- exemplo estilo prova
-- view que mostra o resumo de consultas por medico
create or replace view resumo_consultas as
select m.codm, m.nome, m.especialidade, count(*) as total_consultas
from medico m
join consulta c on c.codm = m.codm
group by m.codm, m.nome, m.especialidade;

select * from resumo_consultas;
