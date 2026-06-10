-- max
-- quando usar: maior valor da coluna
-- obs prova: funciona com numero, texto e data
--            para trazer a linha inteira do maior, usar subconsulta

-- exemplo simples
select max(salario) from funcionario;

-- exemplo intermediario (max e min juntos)
-- menor e maior salario dos funcionarios de Florianopolis
select max(salario), min(salario)
from funcionario
where cidade = 'Florianopolis';

-- exemplo estilo prova
-- nome e idade do medico mais velho (linha inteira via subconsulta)
select nome, idade
from medico
where idade = (select max(idade) from medico);
