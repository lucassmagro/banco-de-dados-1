-- count
-- quando usar: contar linhas ou valores
-- obs prova: count(*) conta todas as linhas
--            count(coluna) ignora null
--            count(distinct coluna) conta valores diferentes

-- exemplo simples
-- quantos medicos sao ortopedistas
select count(*) from medico where especialidade = 'ortopedia';

-- exemplo intermediario (diferenca entre count(*) e count(coluna))
select count(*) from medico;     -- todos
select count(nroa) from medico;  -- ignora medico sem ambulatorio

-- distinct
select count(distinct nroa) as total_ambulatorios_atendidos from medico;

-- exemplo estilo prova
-- total de consultas por data, so horarios apos as 12h
select data, count(*) as total
from consulta
where hora > '12:00'
group by data;
