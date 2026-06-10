-- unique
-- quando usar: garantir que nenhum valor se repita na coluna
-- obs prova: unique permite null (diferente da pk)
--            uma tabela pode ter varias colunas unique

-- exemplo simples (unique na coluna)
create table teste_uniq1 (
    id int primary key,
    cpf numeric(11) unique
);

-- exemplo intermediario (unique composto)
create table teste_uniq2 (
    id int primary key,
    nome varchar(40),
    email varchar(60),
    unique (nome, email)
);

-- exemplo estilo prova
-- adicionar unique depois da criacao
create table teste_uniq3 (
    id int primary key,
    rg varchar(20)
);
alter table teste_uniq3 add constraint uq_rg unique (rg);

-- remover a constraint
alter table teste_uniq3 drop constraint uq_rg;

-- limpeza
drop table teste_uniq3;
drop table teste_uniq2;
drop table teste_uniq1;
