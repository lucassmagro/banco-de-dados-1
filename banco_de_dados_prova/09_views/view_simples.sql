-- view simples
-- quando usar: criar uma consulta reutilizavel como tabela virtual
-- obs prova: view nao armazena dados, executa a consulta a cada acesso
--            facilita consultas repetitivas e controle de acesso

-- exemplo simples
-- view com medicos de Florianopolis
create or replace view medicos_floripa as
select codm, nome, especialidade
from medico
where cidade = 'Florianopolis';

select * from medicos_floripa;

-- exemplo intermediario
-- view com funcionarios e salario acima de 1500
create or replace view funcionarios_senior as
select codf, nome, salario, cargo
from funcionario
where salario > 1500;

select * from funcionarios_senior;

-- exemplo estilo prova
-- view que mostra pacientes maiores de idade com suas doencas
create or replace view pacientes_adultos as
select codp, nome, idade, cidade, doenca
from paciente
where idade >= 18;

select * from pacientes_adultos;

-- consultar a view como se fosse tabela
select nome, doenca from pacientes_adultos where cidade = 'Florianopolis';

-- limpeza
drop view if exists medicos_floripa;
drop view if exists funcionarios_senior;
drop view if exists pacientes_adultos;
