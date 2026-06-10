-- case em plpgsql
-- quando usar: selecionar entre multiplas opcoes (alternativa ao if/elsif)
-- obs prova: dois formatos: case simples (case var when) e case buscado (case when cond)
--            case no plpgsql termina com end case (diferente do case no select)

-- exemplo simples (case simples)
-- traduz especialidade para portugues
create or replace function traduzir_espec(cod int)
returns varchar as $$
declare
    espec char(20);
begin
    select especialidade into espec from medico where codm = cod;
    case trim(espec)
        when 'ortopedia' then return 'ossos e articulacoes';
        when 'pediatria' then return 'criancas';
        when 'traumatologia' then return 'traumas';
        when 'neurologia' then return 'sistema nervoso';
        when 'cardiologia' then return 'coracao';
        else return 'outra';
    end case;
end;
$$ language plpgsql;

select nome, especialidade, traduzir_espec(codm) as traducao from medico;

-- exemplo intermediario (case buscado com condicoes)
-- faixa de capacidade do ambulatorio
create or replace function faixa_capacidade(nro int)
returns varchar as $$
declare
    cap smallint;
begin
    select capacidade into cap from ambulatorio where nroa = nro;
    case
        when cap <= 25 then return 'pequeno';
        when cap <= 40 then return 'medio';
        when cap <= 55 then return 'grande';
        else return 'extra grande';
    end case;
end;
$$ language plpgsql;

select nroa, capacidade, faixa_capacidade(nroa) as faixa from ambulatorio;

-- exemplo estilo prova
-- classifica orcamento do departamento
create or replace function nivel_orcamento(cod int)
returns varchar as $$
declare
    orc numeric;
begin
    select orcamento into orc from departamento where codd = cod;
    case
        when orc is null then return 'sem orcamento';
        when orc < 35000 then return 'baixo';
        when orc < 60000 then return 'medio';
        else return 'alto';
    end case;
end;
$$ language plpgsql;

select nome, orcamento, nivel_orcamento(codd) as nivel from departamento;
