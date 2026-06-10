-- like
-- quando usar: busca por padrao em texto
-- obs prova: % casa qualquer cadeia (inclusive vazia)
--            _ casa exatamente um caractere
--            like diferencia maiusculas de minusculas (ilike nao)

-- exemplo simples
-- nomes que comecam com M
select cpf, nome from medico where nome like 'M%';

-- exemplo intermediario
-- termina com 'a'
select nome from paciente where nome like '%a';

-- contem 'ar' em qualquer lugar
select nome from funcionario where nome like '%ar%';

-- not like
select nome from medico where nome not like 'M%';

-- exemplo estilo prova
-- segunda letra 'o' e ultima letra 'o'
select nome, especialidade
from medico
where nome like '_o%o';

-- nome com exatamente 4 letras
select nome from paciente where nome like '____';
