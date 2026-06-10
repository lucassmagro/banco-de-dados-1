-- right join (juncao externa a direita)
-- quando usar: manter todas as linhas da tabela da DIREITA
-- obs prova: a right join b = b left join a (so muda o lado preservado)

-- exemplo simples
select *
from consulta c right join medico m on m.codm = c.codm;

-- exemplo intermediario
-- nome dos medicos com consulta em 13/10/2018, preservando medicos
select m.nome, c.data
from consulta c right join medico m on m.codm = c.codm
where c.data = '2018-10-13';

-- exemplo estilo prova
-- todos os ambulatorios (lado direito) com seus medicos quando existirem
select m.nome, a.nroa, a.andar
from medico m right join ambulatorio a on m.nroa = a.nroa;

-- ambulatorios sem medico via right join
select a.nroa, a.andar
from medico m right join ambulatorio a on m.nroa = a.nroa
where m.codm is null;
