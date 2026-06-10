-- trigger after insert
-- quando usar: executar acao depois da insercao ja confirmada
-- obs prova: nao pode alterar new (a linha ja foi inserida)
--            usado para log, auditoria, notificacao

-- tabela de log para os testes
create table if not exists log_insercoes (
    id serial primary key,
    tabela varchar(50),
    detalhe text,
    data_hora timestamp default current_timestamp
);

-- exemplo simples
-- registra log apos inserir medico
create or replace function log_insert_medico()
returns trigger as $$
begin
    insert into log_insercoes (tabela, detalhe)
    values ('medico', 'inserido: ' || new.codm || ' ' || new.nome);
    return new;
end;
$$ language plpgsql;

create trigger trg_log_ins_medico
after insert on medico
for each row execute function log_insert_medico();

-- testando
insert into medico values (11, 'Teste', 30, 'pediatria', 99000000011, 'Florianopolis', 1);
select * from log_insercoes;
delete from medico where codm = 11;
drop trigger trg_log_ins_medico on medico;

-- exemplo intermediario
-- atualiza contador de pacientes por cidade (simulacao com raise notice)
create or replace function aviso_novo_paciente()
returns trigger as $$
begin
    raise notice 'novo paciente: % de %', new.nome, new.cidade;
    return new;
end;
$$ language plpgsql;

create trigger trg_aviso_pac
after insert on paciente
for each row execute function aviso_novo_paciente();

drop trigger trg_aviso_pac on paciente;

-- exemplo estilo prova
-- log completo com dados do registro inserido
create or replace function log_insert_funcionario()
returns trigger as $$
begin
    insert into log_insercoes (tabela, detalhe)
    values ('funcionario',
            'nome=' || new.nome ||
            ' cargo=' || coalesce(new.cargo, 'null') ||
            ' salario=' || coalesce(new.salario::text, 'null') ||
            ' depto=' || coalesce(new.codd::text, 'null'));
    return new;
end;
$$ language plpgsql;

create trigger trg_log_ins_func
after insert on funcionario
for each row execute function log_insert_funcionario();

drop trigger trg_log_ins_func on funcionario;
drop table if exists log_insercoes;
