-- any e all
-- quando usar: comparar valor com conjunto retornado por subconsulta
-- obs prova: = any equivale a in
--            > all = maior que todos
--            > any = maior que pelo menos um

-- exemplo simples
-- medicos mais velhos que pelo menos um funcionario
select nome, idade
from medico
where idade > any (select idade from funcionario);

-- exemplo intermediario
-- funcionarios que ganham mais que TODOS os funcionarios do departamento 1
select nome, salario
from funcionario
where salario > all (select salario
                     from funcionario
                     where codd = 1);

-- exemplo estilo prova
-- medico mais jovem sem usar min (idade menor ou igual a todas)
select nome, idade
from medico
where idade <= all (select idade from medico);

-- ambulatorios com capacidade maior que qualquer ambulatorio do andar 1
select nroa, andar, capacidade
from ambulatorio
where capacidade > any (select capacidade
                        from ambulatorio
                        where andar = 1);
