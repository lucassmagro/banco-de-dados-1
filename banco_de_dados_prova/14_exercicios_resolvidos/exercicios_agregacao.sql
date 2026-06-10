-- exercicios agregacao

-- 1. total de medicos
select count(*) as total_medicos from medico;

-- 2. media salarial por departamento
select d.nome, round(avg(f.salario), 2) as media
from departamento d
join funcionario f on f.codd = d.codd
group by d.codd, d.nome;

-- 3. especialidades com mais de um medico
select especialidade, count(*) as total
from medico
group by especialidade
having count(*) > 1;

-- 4. total de consultas por medico, so quem tem mais de 2
select m.nome, count(*) as total
from medico m
join consulta c on c.codm = m.codm
group by m.codm, m.nome
having count(*) > 2;

-- 5. maior e menor salario por departamento
select d.nome, max(f.salario) as maior, min(f.salario) as menor
from departamento d
join funcionario f on f.codd = d.codd
group by d.codd, d.nome;

-- 6. capacidade total e media por andar
select andar, sum(capacidade) as total, round(avg(capacidade), 1) as media
from ambulatorio
group by andar
order by andar;

-- 7. total de pacientes por cidade, so cidades com mais de 1
select cidade, count(*) as total
from paciente
group by cidade
having count(*) > 1;

-- 8. soma de salarios de funcionarios de Florianopolis
select sum(salario) as total from funcionario where cidade = 'Florianopolis';

-- 9. nome do funcionario com maior salario
select nome, salario
from funcionario
where salario = (select max(salario) from funcionario);

-- 10. medicos com consultas em mais de 2 datas diferentes
select m.nome, count(distinct c.data) as datas_diferentes
from medico m
join consulta c on c.codm = m.codm
group by m.codm, m.nome
having count(distinct c.data) > 2;
