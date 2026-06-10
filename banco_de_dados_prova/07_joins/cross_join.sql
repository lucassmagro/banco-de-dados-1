-- cross join (produto cartesiano)
-- quando usar: todas as combinacoes entre duas tabelas
-- obs prova: cross join = from t1, t2 sem where
--            resultado tem card(t1) * card(t2) linhas

-- exemplo simples
select *
from medico cross join ambulatorio;

-- equivalente com virgula
select *
from medico, ambulatorio;

-- exemplo intermediario (contando o tamanho do resultado)
select count(*)
from medico cross join ambulatorio; -- 10 medicos x 8 ambulatorios = 80

-- exemplo estilo prova
-- toda combinacao medico x paciente da mesma cidade (vira juncao com where)
select m.nome as medico, p.nome as paciente
from medico m cross join paciente p
where m.cidade = p.cidade;
