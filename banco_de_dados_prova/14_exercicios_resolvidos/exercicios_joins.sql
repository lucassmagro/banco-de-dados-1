-- exercicios joins

-- 1. nome do medico e do paciente em cada consulta
select m.nome as medico, p.nome as paciente, c.data
from consulta c
join medico m on m.codm = c.codm
join paciente p on p.codp = c.codp;

-- 2. todos os medicos e suas consultas (incluindo sem consulta)
select m.nome, c.data, c.hora
from medico m
left join consulta c on c.codm = m.codm;

-- 3. medicos sem nenhuma consulta
select m.nome
from medico m
left join consulta c on c.codm = m.codm
where c.codm is null;

-- 4. pacientes sem consulta
select p.nome
from paciente p
left join consulta c on c.codp = p.codp
where c.codp is null;

-- 5. ambulatorios sem medico
select a.nroa, a.andar
from ambulatorio a
left join medico m on m.nroa = a.nroa
where m.codm is null;

-- 6. nome do funcionario e nome do departamento
select f.nome, d.nome as departamento
from funcionario f
left join departamento d on d.codd = f.codd;

-- 7. medicos e pacientes da mesma cidade
select distinct m.nome as medico, p.nome as paciente, m.cidade
from medico m
join paciente p on m.cidade = p.cidade;

-- 8. consultas com nome do medico, paciente, e andar do ambulatorio
select m.nome as medico, p.nome as paciente, c.data, a.andar
from consulta c
join medico m on m.codm = c.codm
join paciente p on p.codp = c.codp
left join ambulatorio a on a.nroa = m.nroa;

-- 9. pares de funcionarios do mesmo departamento
select f1.nome as func1, f2.nome as func2, f1.codd
from funcionario f1
join funcionario f2 on f1.codd = f2.codd and f1.codf < f2.codf;

-- 10. full join entre medicos e consultas (ver quem nao tem par)
select m.nome, c.codp, c.data
from medico m
full join consulta c on c.codm = m.codm
where m.codm is null or c.codm is null;
