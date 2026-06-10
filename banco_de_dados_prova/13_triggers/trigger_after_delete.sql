-- trigger after delete
-- quando usar: executar acao depois da exclusao ja confirmada
-- obs prova: so tem acesso a old (linha removida)
--            new nao existe em after delete
--            usado para log, limpeza de dados relacionados, auditoria

-- tabela de log para os testes
create table if not exists log_exclusoes (
    id serial primary key,
    tabela varchar(50),
    detalhe text,
    data_hora timestamp default current_timestamp
);

-- exemplo simples
-- registra log apos excluir medico
create or replace function log_delete_medico()
returns trigger as $$
begin
    insert into log_exclusoes (tabela, detalhe)
    values ('medico', 'removido: ' || old.codm || ' ' || old.nome);
    return old;
end;
$$ language plpgsql;

create trigger trg_log_del_medico
after delete on medico
for each row execute function log_delete_medico();

drop trigger trg_log_del_medico on medico;

-- exemplo intermediario
-- registra exclusao de funcionario com dados completos
create or replace function log_delete_funcionario()
returns trigger as $$
begin
    insert into log_exclusoes (tabela, detalhe)
    values ('funcionario',
            'codf=' || old.codf ||
            ' nome=' || old.nome ||
            ' salario=' || coalesce(old.salario::text, 'null') ||
            ' depto=' || coalesce(old.codd::text, 'null'));
    return old;
end;
$$ language plpgsql;

create trigger trg_log_del_func
after delete on funcionario
for each row execute function log_delete_funcionario();

drop trigger trg_log_del_func on funcionario;

-- exemplo estilo prova
-- apos excluir consulta, verifica se medico ficou sem consultas e avisa
create or replace function verificar_medico_sem_consulta()
returns trigger as $$
declare
    restantes int;
begin
    select count(*) into restantes from consulta where codm = old.codm;
    if restantes = 0 then
        raise notice 'medico % ficou sem consultas marcadas', old.codm;
    end if;
    insert into log_exclusoes (tabela, detalhe)
    values ('consulta',
            'medico=' || old.codm || ' paciente=' || old.codp ||
            ' data=' || old.data || ' restantes=' || restantes);
    return old;
end;
$$ language plpgsql;

create trigger trg_verificar_consulta
after delete on consulta
for each row execute function verificar_medico_sem_consulta();

drop trigger trg_verificar_consulta on consulta;
drop table if exists log_exclusoes;
