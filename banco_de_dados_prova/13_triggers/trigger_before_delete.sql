-- trigger before delete
-- quando usar: validar ou impedir exclusao antes que ela aconteca
-- obs prova: so tem acesso a old (a linha que sera removida)
--            new nao existe em delete
--            retornar null cancela o delete
--            retornar old confirma o delete

-- exemplo simples
-- impede deletar medico com codigo menor que 5
create or replace function proteger_medicos_antigos()
returns trigger as $$
begin
    if old.codm < 5 then
        raise exception 'medico % e protegido, nao pode ser removido', old.nome;
    end if;
    return old;
end;
$$ language plpgsql;

create trigger trg_proteger_medico
before delete on medico
for each row execute function proteger_medicos_antigos();

-- testando (deve dar erro para codm < 5)
-- delete from medico where codm = 1;
drop trigger trg_proteger_medico on medico;

-- exemplo intermediario
-- impede deletar departamento que tem funcionarios
create or replace function impedir_delete_depto()
returns trigger as $$
declare
    qtd int;
begin
    select count(*) into qtd from funcionario where codd = old.codd;
    if qtd > 0 then
        raise exception 'departamento % tem % funcionarios', old.nome, qtd;
    end if;
    return old;
end;
$$ language plpgsql;

create trigger trg_impedir_del_depto
before delete on departamento
for each row execute function impedir_delete_depto();

drop trigger trg_impedir_del_depto on departamento;

-- exemplo estilo prova
-- antes de deletar paciente, remove automaticamente suas consultas
create or replace function cascade_delete_paciente()
returns trigger as $$
begin
    delete from consulta where codp = old.codp;
    raise notice 'consultas do paciente % removidas', old.nome;
    return old;
end;
$$ language plpgsql;

create trigger trg_cascade_pac
before delete on paciente
for each row execute function cascade_delete_paciente();

-- testando
-- delete from paciente where codp = 1;
drop trigger trg_cascade_pac on paciente;

-- recarregue a base depois de testar
