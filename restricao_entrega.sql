use amvox_prod_openkuget;
select * from tipo_grupo_area
select * from produto_restricao_transportadora where client_id = 135
select * from forma_entrega
select * from tipo_abrangencia

select  * from (
SELECT
	UUID() as id,
	b.canal_venda_id,
	d.forma_entrega_id,
	( SELECT cepinicial1 FROM openk_uaddress.estado aa WHERE aa.sigla = a.uf_destino ) AS cep_inicial,
	( SELECT cepfinal1 FROM openk_uaddress.estado aa WHERE aa.sigla = a.uf_destino ) AS cep_final,
	a.tipo_abrangencia_id,
	COALESCE (
		( SELECT GROUP_CONCAT( codigo_abrangencia ) FROM abrangencia_variacao_restricao_entrega zz WHERE zz.variacao_restricao_entrega_id = a.id AND zz.data_desativacao IS NULL ),
		e.id
	) AS abrangencias_codigo
FROM
	variacao_restricao_entrega a
	INNER JOIN canal_venda_variacao_restricao_entrega b ON b.variacao_restricao_entrega_id = a.id
	INNER JOIN restricao_entrega c ON c.id = a.restricao_entrega_id
	INNER JOIN restricao_entrega_forma_entrega d ON d.restricao_entrega_id = c.id
	INNER JOIN loja e ON e.client_id = c.client_id
WHERE
	a.tipo_grupo_area_id = 1
	AND NOW( ) BETWEEN a.data_hora_inicial
	AND a.data_hora_final
UNION
SELECT
	UUID() as id,
	b.canal_venda_id,
	d.forma_entrega_id,
	a.cep_inicial AS cep_inicial,
	a.cep_final AS cep_final,
	a.tipo_abrangencia_id,
	COALESCE (
		( SELECT GROUP_CONCAT( codigo_abrangencia ) FROM abrangencia_variacao_restricao_entrega zz WHERE zz.variacao_restricao_entrega_id = a.id AND zz.data_desativacao IS NULL ),
		e.id
	) AS abrangencias_codigo
FROM
	variacao_restricao_entrega a
	INNER JOIN canal_venda_variacao_restricao_entrega b ON b.variacao_restricao_entrega_id = a.id
	INNER JOIN restricao_entrega c ON c.id = a.restricao_entrega_id
	INNER JOIN restricao_entrega_forma_entrega d ON d.restricao_entrega_id = c.id
	INNER JOIN loja e ON e.client_id = c.client_id
WHERE
	a.tipo_grupo_area_id = 2
	AND NOW( ) BETWEEN a.data_hora_inicial
	AND a.data_hora_final

UNION
SELECT
	UUID() as id,
	b.canal_venda_id,
	d.forma_entrega_id,
	( SELECT aa.cep_inicial FROM openk_uaddress.faixa_cep_cidade aa WHERE aa.cidade_id = a.cidade_destino_id ) AS cep_inicial,
	( SELECT aa.cep_final FROM openk_uaddress.faixa_cep_cidade aa WHERE aa.cidade_id = a.cidade_destino_id ) AS cep_final,
	a.tipo_abrangencia_id,
	COALESCE (
		( SELECT GROUP_CONCAT( codigo_abrangencia ) FROM abrangencia_variacao_restricao_entrega zz WHERE zz.variacao_restricao_entrega_id = a.id AND zz.data_desativacao IS NULL ),
		e.id
	) AS abrangencias_codigo
FROM
	variacao_restricao_entrega a
	INNER JOIN canal_venda_variacao_restricao_entrega b ON b.variacao_restricao_entrega_id = a.id
	INNER JOIN restricao_entrega c ON c.id = a.restricao_entrega_id
	INNER JOIN restricao_entrega_forma_entrega d ON d.restricao_entrega_id = c.id
	INNER JOIN loja e ON e.client_id = c.client_id
WHERE
	a.tipo_grupo_area_id = 3
	AND NOW( ) BETWEEN a.data_hora_inicial
	AND a.data_hora_final

UNION
SELECT
	UUID() as id,
	b.canal_venda_id,
	d.forma_entrega_id,
	(select min(cepinicial1) from openk_uaddress.estado where regiao = a.sigla_regiao) as cep_inicial,
	(select min(cepfinal1) from openk_uaddress.estado where regiao = a.sigla_regiao) as cep_final,
	a.tipo_abrangencia_id,
	COALESCE (
		( SELECT GROUP_CONCAT( codigo_abrangencia ) FROM abrangencia_variacao_restricao_entrega zz WHERE zz.variacao_restricao_entrega_id = a.id AND zz.data_desativacao IS NULL ),
		e.id
	) AS abrangencias_codigo
FROM
	variacao_restricao_entrega a
	INNER JOIN canal_venda_variacao_restricao_entrega b ON b.variacao_restricao_entrega_id = a.id
	INNER JOIN restricao_entrega c ON c.id = a.restricao_entrega_id
	INNER JOIN restricao_entrega_forma_entrega d ON d.restricao_entrega_id = c.id
	INNER JOIN loja e ON e.client_id = c.client_id
WHERE
	a.tipo_grupo_area_id = 4
	AND NOW( ) BETWEEN a.data_hora_inicial
	AND a.data_hora_final

UNION
SELECT
	UUID() as id,
	b.canal_venda_id,
	d.forma_entrega_id,
	00000000 as cep_inicial,
	99999999 as cep_final,
	a.tipo_abrangencia_id,
	COALESCE (
		( SELECT GROUP_CONCAT( codigo_abrangencia ) FROM abrangencia_variacao_restricao_entrega zz WHERE zz.variacao_restricao_entrega_id = a.id AND zz.data_desativacao IS NULL ),
		e.id
	) AS abrangencias_codigo
FROM
	variacao_restricao_entrega a
	INNER JOIN canal_venda_variacao_restricao_entrega b ON b.variacao_restricao_entrega_id = a.id
	INNER JOIN restricao_entrega c ON c.id = a.restricao_entrega_id
	INNER JOIN restricao_entrega_forma_entrega d ON d.restricao_entrega_id = c.id
	INNER JOIN loja e ON e.client_id = c.client_id
WHERE
	a.tipo_grupo_area_id = 5
	AND NOW( ) BETWEEN a.data_hora_inicial
	AND a.data_hora_final

UNION
SELECT
	UUID() as id
	, 5 AS canal_venda_id
	, a.forma_entrega_id
	, 00000000 as cep_inicial
	, 99999999 as cep_final
	, 1 AS tipo_abrangencia_id
    , CASE
        WHEN p.estoque_por_atributo THEN COALESCE(CONCAT(a.produto_id , '_', ea.combinacao_atributo_id), a.produto_id)
        ELSE a.produto_id
      END as abrangencias_codigo
FROM
	produto_restricao_transportadora a
    inner join produto p on a.produto_id = p.id
    left join estoque_atributo ea on ea.produto_id = a.produto_id and ea.produto_id = p.id

    ) c where canal_venda_id = 2 and forma_entrega_id = 6



use amvox_prod_openkuget
select * from forma_entrega
select * from tipo_abrangencia
select * from tipo_grupo_area
select * from canal_venda
select * from variacao_restricao_entrega;
select * from abrangencia_variacao_restricao_entrega
select * from abrangencia_variacao_restricao_entrega a
inner join canal_venda_variacao_restricao_entrega b on b.variacao_restricao_entrega_id = a.variacao_restricao_entrega_id
where canal_venda_id = 2
select * from canal_venda_variacao_restricao_entrega where variacao_restricao_entrega_id in (16)


select * from produto where id = 48