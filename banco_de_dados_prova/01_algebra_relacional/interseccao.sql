-- interseccao
-- quando usar: tuplas que aparecem nas duas relacoes
-- obs prova: relacoes compativeis; em sql usa intersect
--            tambem da pra resolver com in ou exists

-- exemplo simples
-- cpfs que sao de medico e de paciente ao mesmo tempo
select cpf from medico
intersect
select cpf from paciente;

-- exemplo intermediario
-- mesma coisa com in
select cpf
from medico
where cpf in (select cpf from paciente);

-- exemplo estilo prova
-- nome e cpf dos funcionarios de Florianopolis que estao internados como pacientes
select nome, cpf from funcionario where cidade = 'Florianopolis'
intersect
select nome, cpf from paciente;
