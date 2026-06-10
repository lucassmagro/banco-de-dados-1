-- inner join
-- quando usar: combinar tabelas trazendo so as linhas que casam
-- obs prova: join = inner join (inner e opcional)
--            equivale a produto cartesiano + filtro de igualdade

-- exemplo simples
select *
from paciente join consulta on paciente.codp = consulta.codp;

-- exemplo intermediario (com alias e filtro)
-- nome dos medicos com consulta no dia 13/10/2018
select m.nome
from medico m join consulta c on m.codm = c.codm
where c.data = '2018-10-13';

-- tres tabelas
-- nome do medico, nome do paciente e data da consulta
select m.nome as medico, p.nome as paciente, c.data
from consulta c
join medico m on m.codm = c.codm
join paciente p on p.codp = c.codp;

-- exemplo estilo prova (self join)
-- pares (codigo, nome) de funcionarios e medicos que moram na mesma cidade
select f.codf, f.nome, m.codm, m.nome
from funcionario f join medico m on f.cidade = m.cidade;

-- numero e andar dos ambulatorios usados por ortopedistas
select distinct a.nroa, a.andar
from ambulatorio a join medico m on m.nroa = a.nroa
where m.especialidade = 'ortopedia';
