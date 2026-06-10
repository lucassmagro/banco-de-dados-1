-- avg
-- quando usar: media de valores
-- obs prova: ignora null
--            avg(distinct x) tira a media dos valores diferentes

-- exemplo simples
-- media salarial dos funcionarios com mais de 50 anos
select avg(salario) from funcionario where idade > 50;

-- exemplo intermediario (distinct)
-- media das faixas salariais (sem repetir valor)
select avg(distinct salario) from funcionario where idade > 50;

-- outro exemplo pedido
select avg(distinct idade) from medico;

-- arredondando
select round(avg(idade), 2) as media_idade from medico;

-- exemplo estilo prova
-- media de idade dos medicos e total de ambulatorios atendidos por eles
select avg(idade) as media_idade,
       count(distinct nroa) as total_ambulatorios
from medico;

-- media de idade dos medicos por especialidade
select especialidade, avg(idade) as media
from medico
group by especialidade;
