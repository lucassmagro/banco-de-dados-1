-- subquery com in
-- quando usar: verificar se um valor pertence ao resultado de outra consulta
-- obs prova: in com subconsulta substitui join em muitos casos
--            cuidado: se a subconsulta retornar null, in ainda funciona

-- exemplo simples
-- nome dos medicos que tem consulta marcada
select nome
from medico
where codm in (select codm from consulta);

-- exemplo intermediario
-- pacientes atendidos por ortopedistas
select nome, doenca
from paciente
where codp in (select c.codp
               from consulta c
               join medico m on m.codm = c.codm
               where m.especialidade = 'ortopedia');

-- exemplo estilo prova
-- funcionarios cujo cpf tambem aparece na tabela paciente
select nome, cpf
from funcionario
where cpf in (select cpf from paciente);
