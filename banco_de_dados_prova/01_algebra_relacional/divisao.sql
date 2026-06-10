-- divisao (÷)
-- quando usar: "valores associados a TODOS os valores de outra relacao"
-- obs prova: sql nao tem operador de divisao
--            resolve com dupla negacao: not exists ( ... not exists ... )
--            ou com group by + having count = count total

-- exemplo simples (dupla negacao)
-- pacientes que tem consulta com TODOS os medicos
-- "nao existe medico que nao consultou o paciente"
select p.codp, p.nome
from paciente p
where not exists
  (select *
   from medico m
   where not exists
     (select *
      from consulta c
      where c.codm = m.codm
        and c.codp = p.codp));

-- exemplo intermediario (com count)
-- mesma pergunta: total de medicos distintos do paciente = total de medicos
select p.codp, p.nome
from paciente p join consulta c on p.codp = c.codp
group by p.codp, p.nome
having count(distinct c.codm) = (select count(*) from medico);

-- exemplo estilo prova
-- nome e cpf dos medicos que tem consultas marcadas com todos os pacientes
select m.nome, m.cpf
from medico m
where not exists
  (select *
   from paciente p
   where not exists
     (select *
      from consulta c
      where c.codp = p.codp
        and c.codm = m.codm));
