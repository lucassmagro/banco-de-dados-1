-- exercicios select

-- 1. nome e idade dos pacientes maiores de idade
select nome, idade
from paciente
where idade >= 18;

-- 2. medicos de Florianopolis ou Blumenau
select nome, cidade
from medico
where cidade in ('Florianopolis', 'Blumenau');

-- 3. funcionarios com salario entre 1000 e 2000
select nome, salario
from funcionario
where salario between 1000 and 2000;

-- 4. pacientes cujo nome comeca com 'C' ou termina com 'a'
select nome
from paciente
where nome like 'C%' or nome like '%a';

-- 5. especialidades distintas dos medicos
select distinct especialidade from medico;

-- 6. medicos ordenados por idade decrescente, os 3 mais velhos
select nome, idade
from medico
order by idade desc
limit 3;

-- 7. funcionarios de Florianopolis com salario acima da media geral
select nome, salario
from funcionario
where cidade = 'Florianopolis'
  and salario > (select avg(salario) from funcionario);

-- 8. ambulatorios do andar 2 com capacidade acima de 30
select nroa, andar, capacidade
from ambulatorio
where andar = 2 and capacidade > 30;

-- 9. consultas marcadas entre 10h e 14h
select *
from consulta
where hora between '10:00' and '14:00';

-- 10. medicos que nao sao ortopedistas nem pediatras
select nome, especialidade
from medico
where especialidade not in ('ortopedia', 'pediatria');
