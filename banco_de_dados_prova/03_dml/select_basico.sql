-- select basico
-- quando usar: consultar dados
-- obs prova: select atributos from tabelas [where condicao]
--            equivale a pi[atributos](sigma[condicao](tabela))
--            * retorna todas as colunas

-- exemplo simples
select * from medico;

-- so algumas colunas
select nome, idade from paciente;

-- exemplo intermediario (filtro)
select * from ambulatorio where capacidade > 30;

-- valores calculados com alias (as)
-- salario com aumento de 10%
select cpf, (salario * 1.1) as valornovo
from funcionario;

-- salario liquido: salario menos 20%
select codf, nome, (salario - salario * 0.2) as salario_liquido
from funcionario;

-- idade em meses
select nome, idade * 12 as idade_meses
from paciente;

-- exemplo estilo prova
-- medicos com menos de 40 anos ou com especialidade traumatologia
select *
from medico
where idade < 40 or especialidade = 'traumatologia';
