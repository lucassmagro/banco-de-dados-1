-- materialized view
-- quando usar: armazenar o resultado fisicamente (como cache)
-- obs prova: diferente da view normal, materialized view guarda os dados
--            precisa de refresh manual para atualizar
--            util para consultas pesadas que nao mudam toda hora

-- exemplo simples
-- total de consultas por medico (dados ficam salvos)
create materialized view mv_consultas_medico as
select m.codm, m.nome, count(*) as total
from medico m
join consulta c on c.codm = m.codm
group by m.codm, m.nome;

select * from mv_consultas_medico;

-- exemplo intermediario
-- atualizar a materialized view apos mudancas nos dados
refresh materialized view mv_consultas_medico;

-- materialized view com indice para acelerar consultas
create unique index idx_mv_consultas on mv_consultas_medico (codm);
refresh materialized view concurrently mv_consultas_medico;

-- exemplo estilo prova
-- materialized view com resumo de departamentos
create materialized view mv_resumo_departamento as
select d.codd, d.nome,
       count(f.codf) as total_funcionarios,
       coalesce(sum(f.salario), 0) as folha_salarial,
       coalesce(round(avg(f.salario), 2), 0) as media_salarial
from departamento d
left join funcionario f on f.codd = d.codd
group by d.codd, d.nome;

select * from mv_resumo_departamento;

-- comparacao: view normal vs materialized
-- view normal: roda a consulta toda vez
-- materialized: retorna dados ja calculados, mais rapido

-- limpeza
drop materialized view if exists mv_consultas_medico;
drop materialized view if exists mv_resumo_departamento;
