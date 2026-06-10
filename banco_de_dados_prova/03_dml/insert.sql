-- insert
-- quando usar: incluir linhas na tabela
-- obs prova: sem lista de colunas, os valores seguem a ordem da tabela
--            com lista de colunas, da pra omitir as opcionais
--            texto e data sempre entre aspas simples

-- exemplo simples (todos os valores na ordem)
insert into ambulatorio values (9, 1, 30);

-- exemplo intermediario (escolhendo as colunas)
insert into medico (codm, nome, idade, especialidade, cpf, cidade)
values (11, 'Carla', 28, 'ortopedia', 13000110000, 'Joinville');

-- varios de uma vez
insert into ambulatorio values
    (10, 3, 35),
    (11, 3, 28);

-- exemplo estilo prova (insert com select)
-- copia os medicos de Florianopolis para uma tabela auxiliar
create table medico_fpolis (codm int, nome varchar(40));
insert into medico_fpolis
    select codm, nome from medico where cidade = 'Florianopolis';
select * from medico_fpolis;

-- desfaz os testes
drop table medico_fpolis;
delete from medico where codm = 11;
delete from ambulatorio where nroa in (9, 10, 11);
