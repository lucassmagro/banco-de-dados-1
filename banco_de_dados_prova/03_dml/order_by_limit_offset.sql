-- order by, limit e offset
-- quando usar: ordenar resultado e limitar quantidade de linhas
-- obs prova: asc e o padrao, desc inverte
--            pode ordenar por mais de uma coluna
--            limit n pega as n primeiras, offset pula linhas

-- exemplo simples
select * from paciente order by nome;
select * from paciente order by nome desc;

-- exemplo intermediario (duas colunas)
-- funcionarios por salario decrescente e idade crescente
select *
from funcionario
order by salario desc, idade asc;

-- exemplo estilo prova
-- os tres primeiros funcionarios nessa ordem
select *
from funcionario
order by salario desc, idade asc
limit 3;

-- pulando o primeiro
select * from paciente order by nome offset 1;

-- segunda pagina de 5 em 5
select * from paciente order by codp limit 5 offset 5;
