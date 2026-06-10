-- trigger after update
-- quando usar: executar acao depois da atualizacao ja confirmada
-- obs prova: old e new sao somente leitura (nao da pra mudar)
--            usado para log de alteracoes, sincronizacao, auditoria

-- tabela de log para os testes
create table if not exists log_atualizacoes (
    id serial primary key,
    tabela varchar(50),
    campo varchar(50),
    valor_antigo text,
    valor_novo text,
    data_hora timestamp default current_timestamp
);

-- exemplo simples
-- registra quando o salario do funcionario muda
create or replace function log_salario()
returns trigger as $$
begin
    if old.salario <> new.salario then
        insert into log_atualizacoes (tabela, campo, valor_antigo, valor_novo)
        values ('funcionario', 'salario',
                old.salario::text, new.salario::text);
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_log_salario
after update on funcionario
for each row execute function log_salario();

-- testando
update funcionario set salario = salario + 100 where codf = 1;
select * from log_atualizacoes;
drop trigger trg_log_salario on funcionario;

-- exemplo intermediario
-- registra mudanca de cidade do medico
create or replace function log_mudanca_cidade_medico()
returns trigger as $$
begin
    if old.cidade <> new.cidade then
        insert into log_atualizacoes (tabela, campo, valor_antigo, valor_novo)
        values ('medico', 'cidade', old.cidade, new.cidade);
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_log_cidade_medico
after update on medico
for each row execute function log_mudanca_cidade_medico();

drop trigger trg_log_cidade_medico on medico;

-- exemplo estilo prova
-- log completo: registra qualquer campo alterado no funcionario
create or replace function log_update_completo_func()
returns trigger as $$
begin
    if old.nome <> new.nome then
        insert into log_atualizacoes (tabela, campo, valor_antigo, valor_novo)
        values ('funcionario', 'nome', old.nome, new.nome);
    end if;
    if old.cargo is distinct from new.cargo then
        insert into log_atualizacoes (tabela, campo, valor_antigo, valor_novo)
        values ('funcionario', 'cargo',
                coalesce(old.cargo, 'null'), coalesce(new.cargo, 'null'));
    end if;
    if old.codd is distinct from new.codd then
        insert into log_atualizacoes (tabela, campo, valor_antigo, valor_novo)
        values ('funcionario', 'codd',
                coalesce(old.codd::text, 'null'), coalesce(new.codd::text, 'null'));
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_log_completo_func
after update on funcionario
for each row execute function log_update_completo_func();

drop trigger trg_log_completo_func on funcionario;
drop table if exists log_atualizacoes;

-- recarregue a base depois de testar
