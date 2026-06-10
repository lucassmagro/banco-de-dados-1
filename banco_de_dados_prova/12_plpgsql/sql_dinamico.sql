-- sql dinamico (execute)
-- quando usar: montar e executar comandos sql em tempo de execucao
-- obs prova: execute roda uma string como sql
--            format('%I', nome) protege identificadores (nomes de tabela/coluna)
--            format('%L', valor) protege literais (valores)
--            usar para tabelas/colunas variaves, impossivel com sql estatico

-- exemplo simples
-- funcao que conta linhas de qualquer tabela
create or replace function contar_linhas(nome_tabela text)
returns bigint as $$
declare
    total bigint;
begin
    execute format('select count(*) from %I', nome_tabela) into total;
    return total;
end;
$$ language plpgsql;

select contar_linhas('medico');
select contar_linhas('paciente');
select contar_linhas('consulta');

-- exemplo intermediario
-- busca dinamica em qualquer tabela por coluna e valor
create or replace function buscar_por_nome(nome_tabela text, valor text)
returns setof record as $$
begin
    return query execute format('select * from %I where nome = %L', nome_tabela, valor);
end;
$$ language plpgsql;

-- uso (precisa especificar as colunas no chamador)
select * from buscar_por_nome('medico', 'Joao')
    as t(codm int, nome varchar, idade smallint, especialidade char(20),
         cpf numeric, cidade varchar, nroa int);

-- exemplo estilo prova
-- funcao que cria tabela de backup dinamicamente
create or replace function backup_tabela(tabela_origem text)
returns text as $$
declare
    tabela_destino text;
begin
    tabela_destino := tabela_origem || '_backup';
    execute format('drop table if exists %I', tabela_destino);
    execute format('create table %I as select * from %I', tabela_destino, tabela_origem);
    return 'backup criado: ' || tabela_destino;
end;
$$ language plpgsql;

select backup_tabela('medico');
select * from medico_backup;
drop table medico_backup;
