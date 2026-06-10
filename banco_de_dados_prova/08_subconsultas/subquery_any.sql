-- subquery com any
-- quando usar: comparar um valor com qualquer elemento do conjunto
-- obs prova: = any equivale a in
--            > any = maior que pelo menos um valor do conjunto
--            < any = menor que pelo menos um valor do conjunto

-- exemplo simples
-- medicos mais velhos que pelo menos um funcionario
select nome, idade
from medico
where idade > any (select idade from funcionario);

-- exemplo intermediario
-- funcionarios que ganham mais que pelo menos um funcionario de Florianopolis
select nome, salario
from funcionario
where salario > any (select salario
                     from funcionario
                     where cidade = 'Florianopolis')
  and cidade <> 'Florianopolis';

-- exemplo estilo prova
-- pacientes cuja idade e igual a de algum medico
select p.nome, p.idade
from paciente p
where p.idade = any (select m.idade from medico m);
