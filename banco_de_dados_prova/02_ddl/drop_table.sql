-- drop table
-- quando usar: apagar a tabela inteira (estrutura + dados)
-- obs prova: drop apaga a tabela, delete apaga so as linhas
--            cascade derruba dependencias (views, fks)
--            restrict (padrao) bloqueia se houver dependencia

-- exemplo simples
create table temp_teste (id int);
drop table temp_teste;

-- exemplo intermediario (so se existir, evita erro)
drop table if exists temp_teste;

-- exemplo estilo prova
-- tabela referenciada por fk so cai com cascade
create table dept_teste (id int primary key);
create table func_teste (id int primary key, dept int references dept_teste);
drop table dept_teste cascade;
drop table func_teste;
