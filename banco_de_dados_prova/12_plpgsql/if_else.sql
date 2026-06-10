-- if else em plpgsql
-- quando usar: executar logica condicional
-- obs prova: if / then / elsif / else / end if
--            pode aninhar varios niveis de if

-- exemplo simples
-- verifica se medico e jovem ou experiente
create or replace function idade_medico(cod int)
returns varchar as $$
declare
    id smallint;
begin
    select idade into id from medico where codm = cod;
    if id < 35 then
        return 'jovem';
    else
        return 'experiente';
    end if;
end;
$$ language plpgsql;

select nome, idade, idade_medico(codm) as perfil from medico;

-- exemplo intermediario
-- classifica funcionario por cargo e salario
create or replace function perfil_funcionario(cod int)
returns varchar as $$
declare
    sal numeric;
    car varchar;
begin
    select salario, cargo into sal, car from funcionario where codf = cod;
    if car = 'gerente' then
        return 'gestao';
    elsif car = 'estagiario' then
        return 'aprendiz';
    elsif sal > 1500 then
        return 'senior';
    else
        return 'junior';
    end if;
end;
$$ language plpgsql;

select nome, cargo, salario, perfil_funcionario(codf) as perfil from funcionario;

-- exemplo estilo prova
-- verifica se paciente pode fazer cirurgia (idade entre 18 e 65, sem cancer)
create or replace function apto_cirurgia(cod int)
returns varchar as $$
declare
    p_idade smallint;
    p_doenca varchar;
begin
    select idade, doenca into p_idade, p_doenca
    from paciente where codp = cod;

    if p_idade is null then
        return 'paciente nao encontrado';
    elsif p_idade < 18 then
        return 'menor de idade';
    elsif p_idade > 65 then
        return 'risco por idade';
    elsif p_doenca = 'cancer' then
        return 'encaminhar oncologia';
    else
        return 'apto';
    end if;
end;
$$ language plpgsql;

select nome, idade, doenca, apto_cirurgia(codp) as status from paciente;
