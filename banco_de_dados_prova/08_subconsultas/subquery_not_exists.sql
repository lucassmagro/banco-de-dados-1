-- subquery com not exists
-- quando usar: verificar ausencia de correspondencia (anti join logico)
-- obs prova: not exists implementa a diferenca da algebra relacional
--            dupla negacao com not exists resolve a divisao

-- exemplo simples
-- medicos que nao possuem nenhuma consulta
select nome
from medico m
where not exists (select 1 from consulta c where c.codm = m.codm);

-- exemplo intermediario
-- ambulatorios onde nenhum medico atende
select nroa, andar, capacidade
from ambulatorio a
where not exists (select 1 from medico m where m.nroa = a.nroa);

-- exemplo estilo prova
-- pacientes que nunca consultaram com pediatras
select p.nome
from paciente p
where not exists (select 1
                  from consulta c
                  join medico m on m.codm = c.codm
                  where c.codp = p.codp
                    and m.especialidade = 'pediatria');
