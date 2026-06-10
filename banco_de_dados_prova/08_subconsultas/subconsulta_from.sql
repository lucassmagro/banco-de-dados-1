-- subconsulta no from (tabela derivada)
-- quando usar: tratar o resultado de uma consulta como se fosse uma tabela
-- obs prova: a subconsulta no from PRECISA de alias obrigatoriamente

-- exemplo simples
-- media de consultas por medico
select avg(total) as media_consultas
from (select codm, count(*) as total
      from consulta
      group by codm) as consultas_medico;

-- exemplo intermediario
-- nome dos medicos com mais consultas que a media
select m.nome, cm.total
from medico m
join (select codm, count(*) as total
      from consulta
      group by codm) as cm on cm.codm = m.codm
where cm.total > (select avg(total)
                  from (select count(*) as total
                        from consulta
                        group by codm) as x);

-- exemplo estilo prova
-- departamentos com folha salarial acima da media entre departamentos
select d.nome, folha.total
from departamento d
join (select codd, sum(salario) as total
      from funcionario
      where codd is not null
      group by codd) as folha on folha.codd = d.codd
where folha.total > (select avg(total)
                     from (select sum(salario) as total
                           from funcionario
                           where codd is not null
                           group by codd) as y);
