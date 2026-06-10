-- projecao (pi)
-- quando usar: escolher colunas (atributos) de interesse
-- obs prova: projecao elimina duplicatas na algebra, em sql precisa do distinct
-- notacao: pi[atributos](relacao)

-- exemplo simples
-- algebra: pi[nome, idade](paciente)
select distinct nome, idade
from paciente;

-- exemplo intermediario
-- projecao + selecao: pi[cpf, nome](sigma[idade > 18](paciente))
select distinct cpf, nome
from paciente
where idade > 18;

-- renomeacao (rho): em sql usa alias com as
-- algebra: rho[(codigo, paciente)](pi[codp, nome](paciente))
select codp as codigo, nome as paciente
from paciente;

-- exemplo estilo prova
-- nome e especialidade dos medicos de Florianopolis
select distinct nome, especialidade
from medico
where cidade = 'Florianopolis';
