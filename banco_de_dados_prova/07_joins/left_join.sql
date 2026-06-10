-- left join (juncao externa a esquerda)
-- quando usar: manter TODAS as linhas da tabela da esquerda,
--              mesmo sem correspondencia na direita (vira null)
-- obs prova: classico de prova: "todos os X e, se houver, os Y"

-- exemplo simples
select *
from paciente p left join consulta c on p.codp = c.codp;

-- exemplo intermediario
-- todos os ambulatorios e, onde houver, codigo e nome dos medicos
select a.*, m.codm, m.nome
from ambulatorio a left join medico m on m.nroa = a.nroa;

-- exemplo estilo prova
-- cpf e nome de todos os medicos e, para os que tem consulta,
-- cpf e nome dos pacientes e data
select m.cpf, m.nome, p.cpf as cpf_pac, p.nome as paciente, c.data
from medico m
left join consulta c on c.codm = m.codm
left join paciente p on p.codp = c.codp;

-- anti join: medicos SEM consulta (lado direito fica null)
select m.codm, m.nome
from medico m left join consulta c on c.codm = m.codm
where c.codm is null;
