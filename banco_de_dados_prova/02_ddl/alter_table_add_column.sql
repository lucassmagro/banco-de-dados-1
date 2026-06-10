-- alter table add column
-- quando usar: incluir coluna em tabela existente
-- obs prova: coluna not null nao pode ser adicionada sem default em tabela com dados

-- exemplo simples
alter table ambulatorio add column nome varchar(30);

-- exemplo intermediario (com default)
alter table funcionario add column ativo boolean default true;

-- exemplo estilo prova
-- crie a coluna nroa (int) na tabela funcionario
alter table funcionario add column nroa int;

-- adicionando fk junto
alter table funcionario add foreign key (nroa) references ambulatorio;

-- desfaz os testes
alter table ambulatorio drop column nome;
alter table funcionario drop column ativo;
alter table funcionario drop column nroa;
