-- subquery com all
-- quando usar: comparar um valor com todos os elementos do conjunto
-- obs prova: > all = maior que todos (maximo)
--            < all = menor que todos (minimo)
--            <> all equivale a not in

-- exemplo simples
-- medico mais velho (idade maior ou igual a todas)
select nome, idade
from medico
where idade >= all (select idade from medico);

-- exemplo intermediario
-- funcionarios que ganham mais que todos os funcionarios do departamento vendas
select nome, salario
from funcionario
where salario > all (select f2.salario
                     from funcionario f2
                     join departamento d on d.codd = f2.codd
                     where d.nome = 'vendas');

-- exemplo estilo prova
-- ambulatorios com capacidade maior que todos os ambulatorios do andar 1
select nroa, andar, capacidade
from ambulatorio
where capacidade > all (select capacidade
                        from ambulatorio
                        where andar = 1);
