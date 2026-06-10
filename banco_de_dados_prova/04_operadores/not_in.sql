-- not in
-- quando usar: valor fora de um conjunto
-- obs prova: implementa a diferenca da algebra
--            cuidado com null na subconsulta: not in com null nao retorna nada

-- exemplo simples
select * from medico where cidade not in ('Florianopolis', 'Blumenau');

-- exemplo intermediario (com subconsulta)
-- cpf dos funcionarios que nao estao internados como pacientes
select cpf
from funcionario
where cpf not in (select cpf from paciente);

-- exemplo estilo prova
-- numero e andar dos ambulatorios onde nenhum medico da atendimento
-- precisa filtrar null da subconsulta!
select nroa, andar
from ambulatorio
where nroa not in (select nroa from medico where nroa is not null);
