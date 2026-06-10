-- trigger instead of
-- quando usar: interceptar operacoes em VIEWS (nao em tabelas)
-- obs prova: views nao sao atualizaveis por padrao
--            instead of permite inserir/atualizar/deletar "pela view"
--            so funciona em views, nao em tabelas

-- view simples para teste
create or replace view medicos_resumo as
select codm, nome, especialidade, cidade
from medico;

-- exemplo simples
-- permite insert na view
create or replace function inserir_via_view_medico()
returns trigger as $$
begin
    insert into medico (codm, nome, idade, especialidade, cidade)
    values (new.codm, new.nome, 30, new.especialidade, new.cidade);
    return new;
end;
$$ language plpgsql;

create trigger trg_insert_medico_view
instead of insert on medicos_resumo
for each row execute function inserir_via_view_medico();

-- testando
insert into medicos_resumo (codm, nome, especialidade, cidade)
values (11, 'Teste', 'pediatria', 'Florianopolis');
select * from medico where codm = 11;
delete from medico where codm = 11;
drop trigger trg_insert_medico_view on medicos_resumo;

-- exemplo intermediario
-- permite delete na view
create or replace function deletar_via_view_medico()
returns trigger as $$
begin
    delete from consulta where codm = old.codm;
    delete from medico where codm = old.codm;
    return old;
end;
$$ language plpgsql;

create trigger trg_delete_medico_view
instead of delete on medicos_resumo
for each row execute function deletar_via_view_medico();

drop trigger trg_delete_medico_view on medicos_resumo;

-- exemplo estilo prova
-- view de funcionarios com departamento e trigger de update
create or replace view func_depto_view as
select f.codf, f.nome, f.salario, d.nome as departamento
from funcionario f
left join departamento d on d.codd = f.codd;

create or replace function atualizar_func_via_view()
returns trigger as $$
begin
    update funcionario
    set nome = new.nome,
        salario = new.salario
    where codf = old.codf;
    return new;
end;
$$ language plpgsql;

create trigger trg_update_func_view
instead of update on func_depto_view
for each row execute function atualizar_func_via_view();

-- testando
update func_depto_view set salario = 1500 where codf = 1;
select * from funcionario where codf = 1;
drop trigger trg_update_func_view on func_depto_view;

-- limpeza
drop view if exists func_depto_view;
drop view if exists medicos_resumo;

-- recarregue a base depois de testar
