-- subconsulta correlacionada
-- quando usar: a subconsulta depende de valores da consulta externa
-- obs prova: roda uma vez para cada linha da consulta externa
--            mais lenta que subconsulta simples, mas as vezes e a unica opcao

-- exemplo simples
-- medicos com idade acima da media da sua propria cidade
select m.nome, m.idade, m.cidade
from medico m
where m.idade > (select avg(m2.idade)
                 from medico m2
                 where m2.cidade = m.cidade);

-- exemplo intermediario
-- funcionarios que ganham o maior salario do seu departamento
select f.nome, f.salario
from funcionario f
where f.salario = (select max(f2.salario)
                   from funcionario f2
                   where f2.codd = f.codd);

-- exemplo estilo prova
-- para cada medico, mostrar o nome e a data da sua ultima consulta
select m.nome,
       (select max(c.data)
        from consulta c
        where c.codm = m.codm) as ultima_consulta
from medico m
where exists (select 1 from consulta c where c.codm = m.codm);
