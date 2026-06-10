-- having
-- quando usar: filtrar GRUPOS depois da agregacao
-- obs prova: having so existe com group by
--            where filtra linha, having filtra grupo
--            having usa funcoes de agregacao, where nao pode

-- exemplo simples
-- especialidades com mais de um medico
select especialidade, count(*)
from medico
group by especialidade
having count(*) > 1;

-- exemplo intermediario
-- andares cuja media de capacidade seja >= 40
select andar, avg(capacidade) as media
from ambulatorio
group by andar
having avg(capacidade) >= 40;

-- exemplo estilo prova
-- nome dos medicos que possuem mais de uma consulta marcada
select m.nome, count(*) as total
from medico m join consulta c on m.codm = c.codm
group by m.codm, m.nome
having count(*) > 1;
