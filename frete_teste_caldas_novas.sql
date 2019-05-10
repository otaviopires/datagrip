
use saas_prod_openkuget;
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


) r where client_id = 99 and loja_id = 31 and escala = 0 and peso_inicial <= 0.85 and peso_final >= 0.85 and uf_destino = 'GO' order by cep_inicial