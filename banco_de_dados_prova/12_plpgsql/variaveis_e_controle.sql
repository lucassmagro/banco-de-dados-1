-- variaveis e controle de fluxo
-- quando usar: logica condicional dentro de funcoes
-- obs prova: if / elsif / else / end if
--            case when / then / else / end case
--            variaveis declaradas no bloco declare

-- exemplo simples
-- classifica medico por idade
create or replace function classificar_medico(cod int)
returns varchar as $$
declare
    idade_med smallint;
begin
    select idade into idade_med from medico where codm = cod;
    if idade_med < 30 then
        return 'jovem';
    elsif idade_med < 50 then
        return 'experiente';
    else
        return 'senior';
    end if;
end;
$$ language plpgsql;

select nome, idade, classificar_medico(codm) as classificacao from medico;

-- exemplo intermediario
-- funcao que retorna a faixa salarial do funcionario
create or replace function faixa_salarial(cod int)
returns varchar as $$
declare
    sal numeric;
begin
    select salario into sal from funcionario where codf = cod;
    case
        when sal < 1000 then return 'baixo';
        when sal < 2000 then return 'medio';
        when sal < 3000 then return 'alto';
        else return 'muito alto';
    end case;
end;
$$ language plpgsql;

select nome, salario, faixa_salarial(codf) as faixa from funcionario;

-- exemplo estilo prova
-- funcao que verifica se paciente pode ser atendido (idade >= 18 e sem cancer)
create or replace function pode_atender(cod int)
returns varchar as $$
declare
    p_idade smallint;
    p_doenca varchar;
begin
    select idade, doenca into p_idade, p_doenca
    from paciente where codp = cod;

    if p_idade is null then
        return 'paciente nao encontrado';
    end if;

    if p_idade < 18 then
        return 'menor de idade';
    elsif p_doenca = 'cancer' then
        return 'encaminhar especialista';
    else
        return 'pode atender';
    end if;
end;
$$ language plpgsql;

select nome, idade, doenca, pode_atender(codp) as status from paciente;
