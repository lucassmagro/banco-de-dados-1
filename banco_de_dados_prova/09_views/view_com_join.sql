-- view com join
-- quando usar: encapsular juncoes complexas numa view reutilizavel
-- obs prova: view com join e classica de prova (consulta com 3+ tabelas)

-- exemplo simples
-- consultas com nome do medico e paciente
create or replace view consultas_completas as
select m.nome as medico, p.nome as paciente, c.data, c.hora
from consulta c
join medico m on m.codm = c.codm
join paciente p on p.codp = c.codp;

select * from consultas_completas;

-- exemplo intermediario
-- medicos e seus ambulatorios (incluindo medicos sem ambulatorio)
create or replace view medicos_ambulatorios as
select m.nome, m.especialidade, a.nroa, a.andar
from medico m
left join ambulatorio a on a.nroa = m.nroa;

select * from medicos_ambulatorios;

-- exemplo estilo prova
-- funcionarios com nome do departamento, incluindo quem nao tem depto
create or replace view funcionarios_departamento as
select f.codf, f.nome, f.cargo, f.salario,
       coalesce(d.nome, 'sem departamento') as departamento
from funcionario f
left join departamento d on d.codd = f.codd;

select * from funcionarios_departamento;

-- limpeza
drop view if exists consultas_completas;
drop view if exists medicos_ambulatorios;
drop view if exists funcionarios_departamento;
