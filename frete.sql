use saas_prod_openkuget;

select b.cidade_id, min(c.cep), max(c.cep), a.cidade, b.descricao
from openk_uaddress.cidade a
         inner join openk_uaddress.bairro b on a.id = b.cidade_id
         inner join openk_uaddress.endereco c on c.bairro_id = b.id
where a.id in (9143,7101,7005,7004,2568,998,750)
group by b.cidade_id

select * from saas_prod_openkuget.log_controle_planilha order by data_hora desc


insert into  openk_uaddress.faixa_cep_cidade (cidade_id, cep_inicial, cep_final)
    select b.cidade_id , min(c.cep) as cep_inicial, max(c.cep) as cep_final
    from openk_uaddress.cidade a
             inner join openk_uaddress.bairro b on a.id = b.cidade_id
             inner join openk_uaddress.endereco c on c.bairro_id = b.id
    where a.id in (9143,7101,7005,7004,2568,998,750)
    group by b.cidade_id

select count(id) from saas_openkuget.area_entrega_personalizada where client_id =  131;
delete from saas_openkuget.area_entrega_personalizada where client_id = 131;


#select * from openk_uaddress.endereco
select * from openk_uaddress.bairro #where id = 6
select distinct count(id) from openk_uaddress.cidade
select * from openk_uaddress.cidade where id not in (select cidade_id from openk_uaddress.faixa_cep_cidade)
#select * from openk_uaddress.cidade where cidade like '%caldas nova%'

#select * from openk_uaddress.faixa_cep_cidade where cep_inicial <= 75694420 and cep_final >= 75694420
select * from openk_uaddress.faixa_cep_cidade
select distinct count(id) from openk_uaddress.cidade
select count(cidade_id) from openk_uaddress.faixa_cep_cidade


select * from openk_uaddress.faixa_cep_cidade where cidade_id not in (select distinct cidade_id from openk_uaddress.faixa_cep_cidade)

select * from (
select UUID() as id
            , (select cepinicial1 from openk_uaddress.estado aa where aa.sigla = a.uf_destino ) as cep_inicial
            , (select cepfinal1 from openk_uaddress.estado aa where aa.sigla = a.uf_destino ) as cep_final
            , a.peso_inicial
            , a.peso_final
            , a.preco as valor_frete
            , b.id as transportadora
            , a.prazo as prazo_entrega
            , COALESCE(a.valor_adicional,0) as valor_adicional_quilo
            , c.client_id
            , c.uf as uf_origem
            , a.uf_destino as uf_destino
            , c.id as loja_id
            , b.descricao as transportadora_descricao
            , a.escala
            , b.coeficiente
            , 0 percentual_nota_fiscal
            , a.tipo_area
        from area_atendimento_correios a
        inner join forma_entrega b on a.servico = b.servico
        inner join loja c on b.client_id = c.client_id and c.nro_contrato_correios = a.contrato
        inner join loja_forma_entrega d on d.loja_id = c.id and d.forma_entrega_id = b.id
        where a.uf_origem = c.uf and a.tipo_area != 'L'
        union
        select UUID() as id
                , (select cepinicial2 from openk_uaddress.estado aa where aa.sigla = a.uf_destino ) as cep_inicial
                , (select cepfinal2 from openk_uaddress.estado aa where aa.sigla = a.uf_destino ) as cep_final
                , a.peso_inicial
                , a.peso_final
                , a.preco as valor_frete
                , b.id as transportadora
                , a.prazo as prazo_entrega
                , COALESCE(a.valor_adicional,0) as valor_adicional_quilo
                , c.client_id
                , c.uf as uf_origem
                , a.uf_destino as uf_destino
                , c.id as loja_id
                , b.descricao as transportadora_descricao
                , a.escala
                , b.coeficiente
                , 0 percentual_nota_fiscal
                , a.tipo_area
            from area_atendimento_correios a
            inner join forma_entrega b on a.servico = b.servico
            inner join loja c on b.client_id = c.client_id and c.nro_contrato_correios = a.contrato
            inner join loja_forma_entrega d on d.loja_id = c.id and d.forma_entrega_id = b.id
            where a.uf_origem = c.uf and a.tipo_area != 'L'
        union
        select UUID() as id
            , (select aa.cep_inicial from openk_uaddress.faixa_cep_cidade aa inner join openk_uaddress.cidade bb on aa.cidade_id = bb.id where bb.cidade = c.cidade ) as cep_inicial
            , (select aa.cep_final from openk_uaddress.faixa_cep_cidade aa inner join openk_uaddress.cidade bb on aa.cidade_id = bb.id where bb.cidade = c.cidade )   as cep_final
            , a.peso_inicial
            , a.peso_final
            , a.preco as valor_frete
            , b.id as transportadora
            , a.prazo as prazo_entrega
            , COALESCE(a.valor_adicional,0) as valor_adicional_quilo
            , c.client_id
            , c.uf as uf_origem
            , a.uf_destino as uf_destino
            , c.id as loja_id
            , b.descricao as transportadora_descricao
            , a.escala
            , b.coeficiente
            , 0 percentual_nota_fiscal
            , a.tipo_area
        from area_atendimento_correios a
        inner join forma_entrega b on a.servico = b.servico
        inner join loja c on b.client_id = c.client_id and c.nro_contrato_correios = a.contrato
        inner join loja_forma_entrega d on d.loja_id = c.id and d.forma_entrega_id = b.id
        where a.uf_origem = c.uf and a.tipo_area = 'L'
        union
        select UUID() as id
            , CASE
							WHEN a.tipo_grupo_area_id = 1 THEN (select min(cepinicial1) from openk_uaddress.estado aa where aa.sigla = a.uf_destino )
							WHEN a.tipo_grupo_area_id = 2 THEN a.cep_inicial
							WHEN a.tipo_grupo_area_id = 3 THEN (SELECT min(cep_inicial) FROM openk_uaddress.faixa_cep_cidade aa where aa.cidade_id = a.cidade_destino_id)
							WHEN a.tipo_grupo_area_id = 4 THEN (select min(cepinicial1) from openk_uaddress.estado where regiao = a.area_geografica)
							WHEN a.tipo_grupo_area_id = 5 THEN 00000000
							END AS 'cep_inicial'

            , CASE
							WHEN a.tipo_grupo_area_id = 1 THEN (select MAX(cepfinal1) from openk_uaddress.estado aa where aa.sigla = a.uf_destino )
							WHEN a.tipo_grupo_area_id = 2 THEN a.cep_final
							WHEN a.tipo_grupo_area_id = 3 THEN (SELECT max(cep_final) FROM openk_uaddress.faixa_cep_cidade aa where aa.cidade_id = a.cidade_destino_id)
							WHEN a.tipo_grupo_area_id = 4 THEN (select max(cepfinal1) from openk_uaddress.estado where regiao = a.area_geografica)
							WHEN a.tipo_grupo_area_id = 5 THEN 99999999
							END AS 'cep_final'
            , a.peso_inicial
            , a.peso_final
            , a.preco as valor_frete
            , b.id as transportadora
            , a.prazo as prazo_entrega
            , COALESCE(a.valor_adicional,0) as valor_adicional_quilo
            , b.client_id
            , c.uf as uf_origem
            , (select uf from openk_uaddress.cidade where id = (select cidade_id from openk_uaddress.faixa_cep_cidade f where a.cep_final BETWEEN f.cep_inicial and f.cep_final limit 1)) as uf_destino
            , c.id as loja_id
            , b.descricao as transportadora_descricao
            , a.escala
            , b.coeficiente
            , a.percentual_nota_fiscal percentual_nota_fiscal
            , 'P' as tipo_area
        from area_entrega_personalizada a
        inner join forma_entrega b on b.id = a.forma_entrega_id
        inner join loja c on b.client_id = c.client_id
        inner join loja_forma_entrega d on d.loja_id = c.id and d.forma_entrega_id = b.id



              ) r where client_id = 99 and loja_id = 31 and escala = 0 and peso_inicial <= 0.85 and peso_final >= 0.85 AND cep_inicial <= 75694420 and cep_final >= 75694420 #and  cep_inicial <= 75000000 and r.cep_final >= 75000000
        ;
