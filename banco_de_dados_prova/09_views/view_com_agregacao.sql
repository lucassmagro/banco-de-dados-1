-- view com agregacao
-- quando usar: encapsular relatorios com group by e having
-- obs prova: a view roda a agregacao toda vez, nao guarda resultado em cache

-- exemplo simples
-- total de medicos por especialidade
create or replace view medicos_por_especialidade as
select especialidade, count(*) as total
from medico
group by especialidade;

select * from medicos_por_especialidade;

-- exemplo intermediario
-- folha salarial por departamento
create or replace view folha_por_departamento as
select d.nome as departamento,
       count(*) as funcionarios,
       sum(f.salario) as total_salarios,
       round(avg(f.salario), 2) as media_salarial
from departamento d
join funcionario f on f.codd = d.codd
group by d.codd, d.nome;

select * from folha_por_departamento;

-- exemplo estilo prova
-- medicos com mais de 2 consultas e total por especialidade
create or replace view ranking_medicos as
select m.nome, m.especialidade, count(*) as total_consultas
from medico m
join consulta c on c.codm = m.codm
group by m.codm, m.nome, m.especialidade
having count(*) > 2;

select * from ranking_medicos;

-- limpeza
drop view if exists medicos_por_especialidade;
drop view if exists folha_por_departamento;
drop view if exists ranking_medicos;
