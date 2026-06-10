-- is not null
-- quando usar: testar valor preenchido
-- obs prova: complemento do is null

-- exemplo simples
-- medicos que atendem em algum ambulatorio
select nome, nroa from medico where nroa is not null;

-- exemplo intermediario
select * from funcionario where codd is not null;

-- exemplo estilo prova
-- subconsulta segura para not in (filtra os nulls)
select nroa
from ambulatorio
where nroa not in (select nroa from medico where nroa is not null);
