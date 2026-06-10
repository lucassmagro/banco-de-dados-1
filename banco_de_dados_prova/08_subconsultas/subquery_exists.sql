-- subquery com exists
-- quando usar: testar se a subconsulta retorna ao menos uma linha
-- obs prova: exists e mais eficiente que in quando a subconsulta e grande
--            nao importa o que o select retorna, so importa se tem linha

-- exemplo simples
-- medicos que possuem pelo menos uma consulta
select nome
from medico m
where exists (select 1 from consulta c where c.codm = m.codm);

-- exemplo intermediario
-- ambulatorios que possuem medicos alocados
select nroa, andar
from ambulatorio a
where exists (select 1 from medico m where m.nroa = a.nroa);

-- exemplo estilo prova
-- departamentos que possuem funcionarios ganhando acima de 2000
select d.nome
from departamento d
where exists (select 1
              from funcionario f
              where f.codd = d.codd
                and f.salario > 2000);
