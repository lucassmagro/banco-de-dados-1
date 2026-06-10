-- min
-- quando usar: menor valor da coluna
-- obs prova: mesma logica do max

-- exemplo simples
select min(salario) from funcionario;

-- exemplo intermediario
select min(data) as primeira_consulta from consulta;

-- exemplo estilo prova
-- nome e idade do medico mais jovem sem usar min (estilo prova com all)
select nome, idade
from medico
where idade <= all (select idade from medico);

-- mesma coisa com min
select nome, idade
from medico
where idade = (select min(idade) from medico);
