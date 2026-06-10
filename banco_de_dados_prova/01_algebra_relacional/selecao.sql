-- selecao (sigma)
-- quando usar: filtrar tuplas (linhas) por um predicado
-- obs prova: selecao = WHERE, retorna subconjunto horizontal
-- notacao: sigma[predicado](relacao)
-- operadores logicos: ^ (and), v (or), ¬ (not)

-- exemplo simples
-- algebra: sigma[idade > 18](paciente)
select *
from paciente
where idade > 18;

-- exemplo intermediario
-- algebra: sigma[cidade = 'Florianopolis' ^ idade > 30](medico)
select *
from medico
where cidade = 'Florianopolis'
  and idade > 30;

-- exemplo estilo prova
-- pacientes com gripe ou sarampo, menores de 25 anos
select *
from paciente
where (doenca = 'gripe' or doenca = 'sarampo')
  and idade < 25;
