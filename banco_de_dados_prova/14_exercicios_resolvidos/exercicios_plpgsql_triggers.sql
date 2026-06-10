-- exercicios plpgsql e triggers

-- 1. funcao que retorna o salario do funcionario pelo codigo
create or replace function salario_funcionario(cod int)
returns numeric as $$
declare
    sal numeric;
begin
    select salario into sal from funcionario where codf = cod;
    return sal;
end;
$$ language plpgsql;

select salario_funcionario(1);

-- 2. funcao que classifica paciente por faixa etaria
create or replace function faixa_etaria(cod int)
returns varchar as $$
declare
    id smallint;
begin
    select idade into id from paciente where codp = cod;
    if id < 12 then return 'crianca';
    elsif id < 18 then return 'adolescente';
    elsif id < 60 then return 'adulto';
    else return 'idoso';
    end if;
end;
$$ language plpgsql;

select nome, idade, faixa_etaria(codp) as faixa from paciente;

-- 3. funcao que retorna medicos de uma especialidade
create or replace function listar_especialidade(espec char)
returns table(codigo int, nome_med varchar, cidade_med varchar) as $$
begin
    return query
        select codm, nome, cidade
        from medico
        where especialidade = espec;
end;
$$ language plpgsql;

select * from listar_especialidade('ortopedia');

-- 4. funcao com loop que calcula soma de 1 a n
create or replace function soma_ate(n int)
returns int as $$
declare
    total int := 0;
    i int;
begin
    for i in 1..n loop
        total := total + i;
    end loop;
    return total;
end;
$$ language plpgsql;

select soma_ate(10); -- 55

-- 5. funcao com excecao para buscar paciente
create or replace function buscar_paciente(cod int)
returns varchar as $$
declare
    resultado varchar;
begin
    select nome into strict resultado from paciente where codp = cod;
    return resultado;
exception
    when no_data_found then
        return 'paciente nao encontrado';
end;
$$ language plpgsql;

select buscar_paciente(1);
select buscar_paciente(999);

-- 6. trigger before que converte especialidade para minusculo
create or replace function especialidade_lower()
returns trigger as $$
begin
    new.especialidade := lower(new.especialidade);
    return new;
end;
$$ language plpgsql;

create trigger trg_espec_lower
before insert or update on medico
for each row execute function especialidade_lower();

drop trigger trg_espec_lower on medico;

-- 7. trigger after de log para insercao de paciente
create table if not exists log_pacientes (
    id serial primary key,
    operacao varchar(10),
    nome_pac varchar(40),
    data_hora timestamp default current_timestamp
);

create or replace function log_novo_paciente()
returns trigger as $$
begin
    insert into log_pacientes (operacao, nome_pac)
    values ('insert', new.nome);
    return new;
end;
$$ language plpgsql;

create trigger trg_log_pac
after insert on paciente
for each row execute function log_novo_paciente();

-- testando
insert into paciente values (11, 'Teste', 25, 'Florianopolis', 88000000001, 'gripe');
select * from log_pacientes;
delete from consulta where codp = 11;
delete from paciente where codp = 11;
drop trigger trg_log_pac on paciente;
drop table log_pacientes;

-- 8. trigger before que impede salario negativo
create or replace function validar_salario()
returns trigger as $$
begin
    if new.salario < 0 then
        raise exception 'salario nao pode ser negativo';
    end if;
    return new;
end;
$$ language plpgsql;

create trigger trg_salario_positivo
before insert or update on funcionario
for each row execute function validar_salario();

-- testando (deve dar erro)
-- update funcionario set salario = -100 where codf = 1;
drop trigger trg_salario_positivo on funcionario;
