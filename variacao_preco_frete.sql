use amvox_prod_openkuget;
select * from regra_preco_frete;
select * from abrangecia_variacao_preco_frete
select * from variacao_preco_frete
select * from regra_preco_variacao_forma_entrega
select * from amvox_prod_openkuget.tipo_grupo_area
select * from amvox_prod_openkuget.tipo_abrangencia

SELECT UUID() as id
	, a.descricao
	, a.client_id
	, a.prioridade
	, c.canal_venda_id
	, 00000000 as cep_inicial
	, 99999999 as cep_final
	, b.tipo_abrangencia_id
	, COALESCE((SELECT GROUP_CONCAT(COALESCE(CONCAT(codigo_abrangencia, '_', ff.combinacao_atributo_id), codigo_abrangencia)) FROM abrangecia_variacao_preco_frete zz LEFT JOIN estoque_atributo ff ON ff.produto_id = zz.codigo_abrangencia WHERE zz.variacao_preco_frete_id = b.id AND zz.data_desativacao IS NULL), '') AS abrangencias_codigo
	, CASE
		WHEN b.tipo_operacao = 'D' THEN b.vlr_aplicar * -1
		ELSE b.vlr_aplicar
	END valor
	, b.tipo_aplicacao
	, CASE
	WHEN b.destino_capital THEN 'C'
		ELSE 'O'
	END destino_capital
	, d.forma_entrega_id
FROM regra_preco_frete a
INNER JOIN variacao_preco_frete b ON b.regra_preco_frete_id = a.id
INNER JOIN canal_venda_variacao_preco_frete c ON c.variacao_preco_frete_id = b.id
INNER JOIN regra_preco_variacao_forma_entrega d ON d.regra_preco_frete_id = a.id
WHERE a.data_desativacao IS NULL
	AND b.tipo_grupo_area_id = 5
	AND NOW() BETWEEN b.data_hora_inicial AND b.data_hora_final
UNION
SELECT UUID() as id
	, a.descricao
	, a.client_id
	, a.prioridade
	, c.canal_venda_id
	, b.cep_inicial as cep_inicial
	, b.cep_final as cep_final
	, b.tipo_abrangencia_id
	, COALESCE((SELECT GROUP_CONCAT(COALESCE(CONCAT(codigo_abrangencia, '_', ff.combinacao_atributo_id), codigo_abrangencia)) FROM abrangecia_variacao_preco_frete zz LEFT JOIN estoque_atributo ff ON ff.produto_id = zz.codigo_abrangencia WHERE zz.variacao_preco_frete_id = b.id AND zz.data_desativacao IS NULL), '') AS abrangencias_codigo
	, CASE
		WHEN b.tipo_operacao = 'D' THEN b.vlr_aplicar * -1
		ELSE b.vlr_aplicar
	END valor
	, b.tipo_aplicacao
	, CASE
	WHEN b.destino_capital THEN 'C'
		ELSE 'O'
	END destino_capital
	, d.forma_entrega_id
FROM regra_preco_frete a
INNER JOIN variacao_preco_frete b ON b.regra_preco_frete_id = a.id
INNER JOIN canal_venda_variacao_preco_frete c ON c.variacao_preco_frete_id = b.id
INNER JOIN regra_preco_variacao_forma_entrega d ON d.regra_preco_frete_id = a.id
WHERE a.data_desativacao IS NULL
	AND b.tipo_grupo_area_id = 2
	AND NOW() BETWEEN b.data_hora_inicial AND b.data_hora_final
UNION
SELECT UUID() as id
	, a.descricao
	, a.client_id
	, a.prioridade
	, c.canal_venda_id
	, (SELECT cepinicial1 FROM openk_uaddress.estado aa WHERE aa.sigla = b.uf_destino) as cep_inicial
	, (SELECT cepfinal1 FROM openk_uaddress.estado aa WHERE aa.sigla = b.uf_destino) as cep_final
	, b.tipo_abrangencia_id
	, COALESCE((SELECT GROUP_CONCAT(COALESCE(CONCAT(codigo_abrangencia, '_', ff.combinacao_atributo_id), codigo_abrangencia)) FROM abrangecia_variacao_preco_frete zz LEFT JOIN estoque_atributo ff ON ff.produto_id = zz.codigo_abrangencia WHERE zz.variacao_preco_frete_id = b.id AND zz.data_desativacao IS NULL), '') AS abrangencias_codigo
	, CASE
		WHEN b.tipo_operacao = 'D' THEN b.vlr_aplicar * -1
		ELSE b.vlr_aplicar
	END valor
	, b.tipo_aplicacao
	, CASE
	WHEN b.destino_capital THEN 'C'
		ELSE 'O'
	END destino_capital
	, d.forma_entrega_id
FROM regra_preco_frete a
INNER JOIN variacao_preco_frete b ON b.regra_preco_frete_id = a.id
INNER JOIN canal_venda_variacao_preco_frete c ON c.variacao_preco_frete_id = b.id
INNER JOIN regra_preco_variacao_forma_entrega d ON d.regra_preco_frete_id = a.id
WHERE a.data_desativacao IS NULL
	AND b.tipo_grupo_area_id = 1
	AND NOW() BETWEEN b.data_hora_inicial AND b.data_hora_final
UNION
SELECT UUID() as id
	, a.descricao
	, a.client_id
	, a.prioridade
	, c.canal_venda_id
	, (SELECT aa.cep_inicial FROM openk_uaddress.faixa_cep_cidade aa WHERE aa.cidade_id = b.cidade_destino_id) as cep_inicial
	, (SELECT aa.cep_final FROM openk_uaddress.faixa_cep_cidade aa WHERE aa.cidade_id = b.cidade_destino_id) as cep_final
	, b.tipo_abrangencia_id
	, COALESCE((SELECT GROUP_CONCAT(COALESCE(CONCAT(codigo_abrangencia, '_', ff.combinacao_atributo_id), codigo_abrangencia)) FROM abrangecia_variacao_preco_frete zz LEFT JOIN estoque_atributo ff ON ff.produto_id = zz.codigo_abrangencia WHERE zz.variacao_preco_frete_id = b.id AND zz.data_desativacao IS NULL), '') AS abrangencias_codigo
	, CASE
		WHEN b.tipo_operacao = 'D' THEN b.vlr_aplicar * -1
		ELSE b.vlr_aplicar
	END valor
	, b.tipo_aplicacao
	, CASE
	WHEN b.destino_capital THEN 'C'
		ELSE 'O'
	END destino_capital
	, d.forma_entrega_id
FROM regra_preco_frete a
INNER JOIN variacao_preco_frete b ON b.regra_preco_frete_id = a.id
INNER JOIN canal_venda_variacao_preco_frete c ON c.variacao_preco_frete_id = b.id
INNER JOIN regra_preco_variacao_forma_entrega d ON d.regra_preco_frete_id = a.id
WHERE a.data_desativacao IS NULL
	AND b.tipo_grupo_area_id = 3
	AND NOW() BETWEEN b.data_hora_inicial AND b.data_hora_final

;