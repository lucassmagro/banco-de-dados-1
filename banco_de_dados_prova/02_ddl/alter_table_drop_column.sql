-- alter table drop column
-- quando usar: remover coluna de tabela existente
-- obs prova: atributos chave nao podem ser removidos sem remover a constraint
--            pode remover mais de uma coluna no mesmo comando

-- exemplo simples
alter table ambulatorio add column teste int;
alter table ambulatorio drop column teste;

-- exemplo intermediario (varias colunas de uma vez)
alter table funcionario add column cargo2 varchar(20);
alter table funcionario add column nroa2 int;
alter table funcionario
    drop column cargo2,
    drop column nroa2;

-- exemplo estilo prova
-- remover as colunas cargo e nroa da tabela funcionario
-- alter table funcionario drop column cargo, drop column nroa;

-- se houver dependencia (view, fk), usar cascade
-- alter table funcionario drop column cargo cascade;
