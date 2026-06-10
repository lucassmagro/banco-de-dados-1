-- between
-- quando usar: intervalo de valores (limites inclusos)
-- obs prova: x between a and b = x >= a and x <= b
--            funciona com numero, data e hora

-- exemplo simples
select * from paciente where idade between 20 and 30;

-- exemplo intermediario (hora)
-- consultas marcadas para o periodo da tarde
select * from consulta where hora between '14:00' and '18:00';

-- not between
select * from paciente where idade not between 20 and 30;

-- exemplo estilo prova
-- consultas da manha (7h as 12h) com nome do medico e paciente
select m.nome as medico, p.nome as paciente, c.data
from consulta c
join medico m on m.codm = c.codm
join paciente p on p.codp = c.codp
where c.hora between '07:00' and '12:00';

-- intervalo de datas
select * from consulta where data between '2018-10-13' and '2018-10-19';
