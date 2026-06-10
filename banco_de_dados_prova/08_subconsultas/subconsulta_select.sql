-- subconsulta no select (subconsulta escalar)
-- quando usar: retornar um valor calculado como coluna extra
-- obs prova: a subconsulta no select DEVE retornar exatamente 1 valor (1 linha, 1 coluna)

-- exemplo simples
-- nome do medico e total de consultas dele
select m.nome,
       (select count(*) from consulta c where c.codm = m.codm) as total
from medico m;

-- exemplo intermediario
-- nome do departamento e quantidade de funcionarios
select d.nome,
       (select count(*) from funcionario f where f.codd = d.codd) as qtd_func
from departamento d;

-- exemplo estilo prova
-- nome do medico, total de consultas e diferenca para a media geral
select m.nome,
       (select count(*) from consulta c where c.codm = m.codm) as total,
       (select count(*) from consulta c where c.codm = m.codm)
         - (select avg(total) from (select count(*) as total from consulta group by codm) as x)
         as diferenca_media
from medico m;
