-- not exists
-- quando usar: verificar se a subconsulta NAO retorna nenhuma linha
-- obs prova: not exists implementa diferenca e divisao da algebra
--            equivale a anti join (left join + is null)

-- exemplo simples
-- medicos sem consulta
select m.nome
from medico m
where not exists (select 1 from consulta c where c.codm = m.codm);

-- exemplo intermediario
-- pacientes que nunca consultaram com traumatologistas
select p.nome
from paciente p
where not exists (select 1
                  from consulta c
                  join medico m on m.codm = c.codm
                  where c.codp = p.codp
                    and m.especialidade = 'traumatologia');

-- exemplo estilo prova
-- medicos que consultaram com TODOS os pacientes (divisao via dupla negacao)
-- "nao existe paciente que nao foi consultado por esse medico"
select m.nome
from medico m
where not exists
  (select 1 from paciente p
   where not exists
     (select 1 from consulta c
      where c.codm = m.codm
        and c.codp = p.codp));
