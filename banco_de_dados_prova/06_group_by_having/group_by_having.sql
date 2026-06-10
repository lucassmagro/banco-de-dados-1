-- group by + having + where juntos
-- quando usar: agregacao com filtro de linha E de grupo
-- obs prova: ordem dos blocos no select:
--            select -> from -> where -> group by -> having -> order by -> limit

-- exemplo simples
-- cidades com mais de um funcionario
select cidade, count(*)
from funcionario
group by cidade
having count(*) > 1;

-- exemplo intermediario (where + having)
-- cidades com mais de um funcionario ganhando acima de 1000
select cidade, count(*) as total, avg(salario) as media
from funcionario
where salario > 1000
group by cidade
having count(*) > 1
order by media desc;

-- exemplo estilo prova
-- medicos com 2 ou mais consultas apos as 9h, ordenado pelo total
select m.nome, count(*) as total_consultas
from medico m
join consulta c on c.codm = m.codm
where c.hora >= '09:00'
group by m.codm, m.nome
having count(*) >= 2
order by total_consultas desc;

-- divisao com group by/having (todos os pacientes)
select c.codm, count(distinct c.codp) as pacientes
from consulta c
group by c.codm
having count(distinct c.codp) = (select count(*) from paciente);
