-- is null
-- quando usar: testar valor nulo (ausente)
-- obs prova: nunca usar = null (sempre da falso), o certo e is null
--            null nao entra em comparacoes nem agregacoes (count(col) ignora null)

-- exemplo simples
-- medicos que nao atendem em ambulatorio
select cpf, nome from medico where nroa is null;

-- exemplo intermediario
select * from funcionario where codd is null;

-- exemplo estilo prova (null em left join)
-- ambulatorios sem nenhum medico
select a.*
from ambulatorio a
left join medico m on m.nroa = a.nroa
where m.codm is null;
