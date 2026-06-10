-- trigger after
-- quando usar: executar DEPOIS da operacao (ja confirmada)
-- obs prova: after nao pode alterar new (a operacao ja aconteceu)
--            usado para auditoria, log, notificacoes

-- exemplo simples
-- log apos inserir consulta
create table if not exists log_alteracoes (
    id serial primary key,
    tabela varchar(50),
    operacao varchar(10),
    usuario varchar(50),
    data_hora timestamp default current_timestamp,
    detalhe text
);

create or replace function log_insert_consulta()
returns trigger as $$
begin
    insert into log_alteracoes (tabela, operacao, usuario, detalhe)
    values ('consulta', 'insert', current_user,
            'consulta medico=' || new.codm || ' paciente=' || new.codp);
    return new;
end;
$$ language plpgsql;

create trigger trg_log_consulta
after insert on consulta
for each row execute function log_insert_consulta();

-- testando
insert into consulta values (1, 2, '2018-11-01', '08:00');
select * from log_alteracoes;
delete from consulta where data = '2018-11-01';
drop trigger trg_log_consulta on consulta;

-- exemplo intermediario
-- atualiza orcamento do departamento quando funcionario muda de depto
create or replace function atualizar_orcamento()
returns trigger as $$
begin
    if old.codd is not null then
        update departamento
        set orcamento = orcamento + old.salario
        where codd = old.codd;
    end if;
    if new.codd is not null then
        update departamento
        set orcamento = orcamento - new.salario
        where codd = new.codd;
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_orcamento_depto
after update of codd on funcionario
for each row execute function atualizar_orcamento();

drop trigger trg_orcamento_depto on funcionario;

-- exemplo estilo prova
-- trigger que grava log para insert, update e delete na mesma tabela
create or replace function log_completo_funcionario()
returns trigger as $$
begin
    if tg_op = 'INSERT' then
        insert into log_alteracoes (tabela, operacao, usuario, detalhe)
        values ('funcionario', 'insert', current_user, 'inserido: ' || new.nome);
    elsif tg_op = 'UPDATE' then
        insert into log_alteracoes (tabela, operacao, usuario, detalhe)
        values ('funcionario', 'update', current_user,
                'alterado: ' || old.nome || ' -> ' || new.nome);
    elsif tg_op = 'DELETE' then
        insert into log_alteracoes (tabela, operacao, usuario, detalhe)
        values ('funcionario', 'delete', current_user, 'removido: ' || old.nome);
    end if;
    return coalesce(new, old);
end;
$$ language plpgsql;

create trigger trg_log_func
after insert or update or delete on funcionario
for each row execute function log_completo_funcionario();

drop trigger trg_log_func on funcionario;
drop table if exists log_alteracoes;
