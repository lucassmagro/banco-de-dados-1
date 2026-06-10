-- trigger para evento truncate
-- quando usar: quando precisamos auditar ou impedir a exclusao em massa de uma tabela
-- obs prova: truncate e um evento que limpa a tabela muito mais rapido que delete
--            for each row nao faz sentido com truncate. sempre e for each statement
--            variaveis new e old nao existem em truncate

-- exemplo simples
-- funcao de log para truncate
create table if not exists log_truncate (id serial, tabela varchar(50), data timestamp default now());

create or replace function registrar_truncate()
returns trigger as $$
begin
    insert into log_truncate (tabela) values (tg_table_name);
    raise notice 'tabela % foi truncada', tg_table_name;
    return null;
end;
$$ language plpgsql;

-- criando o trigger no evento truncate
create trigger trg_audit_truncate
after truncate on consulta
for each statement execute function registrar_truncate();

-- exemplo intermediario
-- bloqueando truncate em uma tabela critica
create or replace function impedir_truncate()
returns trigger as $$
begin
    raise exception 'truncate nao e permitido na tabela %!', tg_table_name;
end;
$$ language plpgsql;

create trigger trg_block_truncate
before truncate on ambulatorio
for each statement execute function impedir_truncate();

-- exemplo estilo prova
-- testando a execucao
-- tenta dar truncate no ambulatorio (vai dar erro pelo trigger bloqueador)
-- truncate table ambulatorio;

-- limpeza
drop trigger if exists trg_audit_truncate on consulta;
drop trigger if exists trg_block_truncate on ambulatorio;
drop table if exists log_truncate;
