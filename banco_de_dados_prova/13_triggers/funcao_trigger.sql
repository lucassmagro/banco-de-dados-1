-- funcao trigger
-- quando usar: criar a funcao que sera chamada pelo trigger
-- obs prova: funcao trigger retorna trigger (nao um tipo normal)
--            tem acesso a new (linha nova) e old (linha antiga)
--            before: pode alterar new antes de gravar
--            after: new e old sao somente leitura

-- exemplo simples
-- funcao que imprime o que aconteceu
create or replace function log_operacao()
returns trigger as $$
begin
    raise notice 'operacao: % na tabela %', tg_op, tg_table_name;
    return new;
end;
$$ language plpgsql;

-- exemplo intermediario
-- funcao que valida idade minima antes de inserir medico
create or replace function validar_idade_medico()
returns trigger as $$
begin
    if new.idade < 18 then
        raise exception 'medico deve ter pelo menos 18 anos';
    end if;
    return new;
end;
$$ language plpgsql;

-- exemplo estilo prova
-- funcao que registra alteracoes numa tabela de log
create table if not exists log_alteracoes (
    id serial primary key,
    tabela varchar(50),
    operacao varchar(10),
    usuario varchar(50),
    data_hora timestamp default current_timestamp,
    detalhe text
);

create or replace function registrar_log()
returns trigger as $$
begin
    if tg_op = 'INSERT' then
        insert into log_alteracoes (tabela, operacao, usuario, detalhe)
        values (tg_table_name, 'insert', current_user,
                'novo registro inserido');
    elsif tg_op = 'UPDATE' then
        insert into log_alteracoes (tabela, operacao, usuario, detalhe)
        values (tg_table_name, 'update', current_user,
                'registro alterado');
    elsif tg_op = 'DELETE' then
        insert into log_alteracoes (tabela, operacao, usuario, detalhe)
        values (tg_table_name, 'delete', current_user,
                'registro removido');
        return old;
    end if;
    return new;
end;
$$ language plpgsql;
