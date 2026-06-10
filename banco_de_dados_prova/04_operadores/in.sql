-- in
-- quando usar: testar se o valor pertence a um conjunto
-- obs prova: o conjunto pode ser uma lista fixa ou uma subconsulta
--            in = '= any'

-- exemplo simples
-- medicos traumatologistas e cardiologistas
select *
from medico
where especialidade in ('cardiologia', 'traumatologia');

-- exemplo intermediario (lista de numeros)
select * from ambulatorio where nroa in (1, 3, 5);

-- exemplo estilo prova (in com subconsulta)
-- nome dos medicos com consulta no dia 13/10/2018
select nome
from medico
where codm in (select codm
               from consulta
               where data = '2018-10-13');
