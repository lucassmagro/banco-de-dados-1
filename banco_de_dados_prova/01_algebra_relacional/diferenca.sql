-- diferenca (-)
-- quando usar: tuplas presentes em r1 e ausentes em r2
-- obs prova: em sql usa except (r1 except r2)
--            a ordem importa: r1 - r2 <> r2 - r1
--            tambem resolve com not in ou not exists

-- exemplo simples
-- cpfs de funcionarios que nao sao pacientes
select cpf from funcionario
except
select cpf from paciente;

-- exemplo intermediario
-- mesma coisa com not in
select cpf
from funcionario
where cpf not in (select cpf from paciente);

-- exemplo estilo prova
-- numero dos ambulatorios onde nenhum medico da atendimento
select nroa from ambulatorio
except
select nroa from medico where nroa is not null;
