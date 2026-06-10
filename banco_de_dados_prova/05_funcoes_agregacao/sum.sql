-- sum
-- quando usar: somar valores de uma coluna
-- obs prova: ignora null, so funciona com numero

-- exemplo simples
-- total pago em salarios
select sum(salario) as total from funcionario;

-- exemplo intermediario (com filtro)
select sum(salario) as total_fpolis
from funcionario
where cidade = 'Florianopolis';

-- exemplo estilo prova
-- capacidade total por andar
select andar, sum(capacidade) as capacidade_total
from ambulatorio
group by andar;
