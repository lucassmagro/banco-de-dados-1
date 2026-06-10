-- exercicios subconsultas

-- 1. medicos com idade acima da media
select nome, idade
from medico
where idade > (select avg(idade) from medico);

-- 2. nome dos pacientes que consultaram com o medico Joao
select nome
from paciente
where codp in (select codp
               from consulta
               where codm = (select codm from medico where nome = 'Joao'));

-- 3. funcionarios que ganham mais que todos os funcionarios do depto 1
select nome, salario
from funcionario
where salario > all (select salario from funcionario where codd = 1);

-- 4. medicos que tem consulta com algum paciente de Florianopolis
select nome
from medico
where codm in (select c.codm
               from consulta c
               join paciente p on p.codp = c.codp
               where p.cidade = 'Florianopolis');

-- 5. pacientes que nunca consultaram
select nome
from paciente
where not exists (select 1 from consulta c where c.codp = paciente.codp);

-- 6. medicos com mais consultas que a media
select m.nome, count(*) as total
from medico m
join consulta c on c.codm = m.codm
group by m.codm, m.nome
having count(*) > (select avg(total)
                   from (select count(*) as total
                         from consulta group by codm) as x);

-- 7. departamentos sem funcionario
select nome
from departamento
where not exists (select 1 from funcionario f where f.codd = departamento.codd);

-- 8. ambulatorios cuja capacidade e maior que a media
select nroa, capacidade
from ambulatorio
where capacidade > (select avg(capacidade) from ambulatorio);

-- 9. nome do medico com mais consultas (subconsulta no from)
select m.nome, t.total
from medico m
join (select codm, count(*) as total
      from consulta
      group by codm
      order by total desc
      limit 1) as t on t.codm = m.codm;

-- 10. medicos que consultaram TODOS os pacientes (divisao)
select m.nome
from medico m
where not exists
  (select 1 from paciente p
   where not exists
     (select 1 from consulta c
      where c.codm = m.codm and c.codp = p.codp));
