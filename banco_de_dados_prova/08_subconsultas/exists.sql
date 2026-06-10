-- exists
-- quando usar: verificar se a subconsulta retorna pelo menos uma linha
-- obs prova: exists retorna true/false, nao importa o que o select retorna
--            geralmente usa select * ou select 1

-- exemplo simples
-- medicos que tem pelo menos uma consulta
select m.nome
from medico m
where exists (select 1 from consulta c where c.codm = m.codm);

-- exemplo intermediario
-- pacientes que consultaram com algum ortopedista
select p.nome
from paciente p
where exists (select 1
              from consulta c
              join medico m on m.codm = c.codm
              where c.codp = p.codp
                and m.especialidade = 'ortopedia');

-- exemplo estilo prova
-- departamentos que possuem pelo menos um funcionario ganhando acima de 2000
select d.nome
from departamento d
where exists (select 1
              from funcionario f
              where f.codd = d.codd
                and f.salario > 2000);
