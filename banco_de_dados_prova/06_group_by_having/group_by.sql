-- group by
-- quando usar: agrupar linhas e aplicar agregacao por grupo
-- obs prova: toda coluna do select fora de agregacao TEM que estar no group by
--            where filtra ANTES de agrupar

-- exemplo simples
-- total de medicos por especialidade
select especialidade, count(*)
from medico
group by especialidade;

-- exemplo intermediario (where antes do group by)
-- datas e total de consultas em cada data, para horarios apos as 12 horas
select data, count(*) as total
from consulta
where hora > '12:00'
group by data;

-- agrupando por mais de uma coluna
select codm, codp, count(*) as nro_consultas
from consulta
group by codm, codp;

-- exemplo estilo prova
-- capacidade total dos ambulatorios por andar
select andar, sum(capacidade) as capacidade_total
from ambulatorio
group by andar
order by andar;
