-- distinct
-- quando usar: eliminar linhas duplicadas do resultado
-- obs prova: sql nao elimina duplicata sozinho (projecao da algebra elimina)
--            distinct vale para o conjunto de colunas do select

-- exemplo simples
-- especialidades de todos os medicos, sem repetir
select distinct especialidade from medico;

-- exemplo intermediario (par de colunas)
select distinct cidade, especialidade from medico;

-- dentro de agregacao
select count(distinct cidade) as total_cidades from medico;
select avg(distinct salario) from funcionario;

-- exemplo estilo prova
-- cidades onde ha pacientes internados, sem repeticao
select distinct cidade from paciente;
