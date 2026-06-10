-- juncoes na algebra relacional
-- quando usar: combinar tuplas de duas relacoes que satisfazem um predicado
-- obs prova: juncao = produto cartesiano + selecao
--            juncao natural: igualdade automatica nos atributos de mesmo nome,
--            que aparecem so uma vez no resultado

-- juncao (theta join): r1 |x| r2 com predicado
select *
from paciente join consulta
  on paciente.codp = consulta.codp;

-- equivalencia com produto cartesiano
select *
from paciente, consulta
where paciente.codp = consulta.codp;

-- juncao natural: junta pelo atributo de mesmo nome (codp)
select *
from paciente natural join consulta;

-- juncao externa a esquerda: preserva tuplas da esquerda sem par
select *
from paciente left join consulta
  on paciente.codp = consulta.codp;

-- juncao externa a direita: preserva tuplas da direita sem par
select *
from consulta right join medico
  on consulta.codm = medico.codm;

-- juncao externa completa: preserva os dois lados
select *
from medico full join consulta
  on medico.codm = consulta.codm;

-- exemplo estilo prova
-- nome do medico e data das consultas do dia 13/10/2018
select m.nome, c.data
from medico m join consulta c on m.codm = c.codm
where c.data = '2018-10-13';
