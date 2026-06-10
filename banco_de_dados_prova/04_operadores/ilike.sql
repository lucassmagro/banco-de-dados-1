-- ilike
-- quando usar: busca por padrao ignorando maiusculas/minusculas
-- obs prova: ilike e do postgres (nao e sql padrao)
--            like 'm%' nao acha 'Maria', ilike 'm%' acha

-- exemplo simples
select nome from medico where nome ilike 'm%';

-- exemplo intermediario (comparando os dois)
select nome from medico where nome like 'JOAO';  -- nao encontra
select nome from medico where nome ilike 'JOAO'; -- encontra Joao

-- exemplo estilo prova
-- pacientes cuja doenca contem 'GRIPE' em qualquer caixa
select nome, doenca
from paciente
where doenca ilike '%gripe%';
