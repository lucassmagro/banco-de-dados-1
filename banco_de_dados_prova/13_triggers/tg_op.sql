-- tg_op (variavel de trigger)
-- quando usar: identificar qual operacao disparou o trigger
-- obs prova: tg_op retorna 'INSERT', 'UPDATE' ou 'DELETE' (em maiusculo)
--            tg_table_name retorna o nome da tabela
--            tg_when retorna 'BEFORE' ou 'AFTER'
--            tg_level retorna 'ROW' ou 'STATEMENT'

-- exemplo simples
-- mostra qual operacao disparou o trigger
create or replace function mostrar_tg_op()
returns trigger as $$
begin
    raise notice 'operacao: % na tabela %', tg_op, tg_table_name;
    if tg_op = 'DELETE' then
        return old;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_tg_op_amb
before insert or update or delete on ambulatorio
for each row execute function mostrar_tg_op();

drop trigger trg_tg_op_amb on ambulatorio;

-- exemplo intermediario
-- funcao unica de log para qualquer operacao usando tg_op
create table if not exists log_operacoes (
    id serial primary key,
    tabela varchar(50),
    operacao varchar(10),
    momento varchar(10),
    data_hora timestamp default current_timestamp
);

create or replace function log_com_tg_op()
returns trigger as $$
begin
    insert into log_operacoes (tabela, operacao, momento)
    values (tg_table_name, tg_op, tg_when);
    if tg_op = 'DELETE' then
        return old;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_log_medico_ops
before insert or update or delete on medico
for each row execute function log_com_tg_op();

drop trigger trg_log_medico_ops on medico;

-- exemplo estilo prova
-- trigger que trata insert, update e delete com logica diferente para cada
create or replace function controle_total()
returns trigger as $$
begin
    if tg_op = 'INSERT' then
        raise notice '[%][%] inserindo: %', tg_table_name, tg_op, new.nome;
        return new;
    elsif tg_op = 'UPDATE' then
        raise notice '[%][%] alterando % -> %', tg_table_name, tg_op, old.nome, new.nome;
        return new;
    elsif tg_op = 'DELETE' then
        raise notice '[%][%] removendo: %', tg_table_name, tg_op, old.nome;
        return old;
    end if;
end;
$$ language plpgsql;

create trigger trg_controle_func
before insert or update or delete on funcionario
for each row execute function controle_total();

drop trigger trg_controle_func on funcionario;
drop table if exists log_operacoes;
