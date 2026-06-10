-- produto cartesiano (x)
-- quando usar: combinar todas as tuplas de duas relacoes
-- obs prova: cardinalidade do resultado = card(r1) * card(r2)
--            grau do resultado = grau(r1) + grau(r2)
-- em sql: listar as tabelas no from separadas por virgula

-- exemplo simples
-- algebra: paciente x consulta
select *
from paciente, consulta;

-- exemplo intermediario
-- produto cartesiano vira juncao quando filtra pela chave no where
-- pi[cpf, nome, data](sigma[hora > 12:00 ^ paciente.codp = consulta.codp](paciente x consulta))
select p.cpf, p.nome, c.data
from paciente p, consulta c
where c.hora > '12:00'
  and p.codp = c.codp;

-- atribuicao (variavel <- expressao): em sql usa with (cte)
-- r1 <- pi[codm, data](consulta)  /  r2 <- pi[codm, nome](medico)
with r1 as (select codm, data from consulta),
     r2 as (select codm, nome from medico)
select r2.nome, r1.data
from r1, r2
where r1.codm = r2.codm;

-- exemplo estilo prova
-- pares de medicos diferentes com consultas nas mesmas datas (self join via produto)
-- precisa da renomeacao (alias) para usar a mesma tabela duas vezes
select distinct c1.codm, c2.codm, c1.data
from consulta c1, consulta c2
where c1.data = c2.data
  and c1.codm <> c2.codm;
