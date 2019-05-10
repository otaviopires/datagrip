use saas_prod_openkuget;
select * from (
SELECT a.id
	, a.client_id
	, b.loja_id
	, a.descricao
	, a.tipo
	, d.url_consulta_frete as 'UrlPlataforma'
	, c.usuario as 'UsuarioPlataforma'
	, c.senha as 'SenhaPlataforma'
	, c.token as 'TokenPlataforma'
	, e.cep_expedicao as 'CepExpedicao'
	, CASE
		WHEN e.capital THEN 'C'
		ELSE 'O'
	END as OrigemCapital
	, COALESCE(a.coeficiente,1) Coeficiente
FROM forma_entrega a
	INNER JOIN loja_forma_entrega b ON b.forma_entrega_id = a.id
	INNER JOIN plataforma_frete_loja c ON c.forma_entrega_id = a.id and c.loja_id = b.loja_id
	INNER JOIN plataforma_frete d ON d.id = c.plataforma_frete_id
	INNER JOIN loja e ON e.id = b.loja_id
WHERE b.data_desativacao IS NULL
	AND a.tipo = 'I'
UNION
SELECT a.id
	, a.client_id
	, b.loja_id
	, a.descricao
	, a.tipo
	, '-' as 'UrlPlataforma'
	, '-' as 'UsuarioPlataforma'
	, '-' as 'SenhaPlataforma'
	, '-' as 'TokenPlataforma'
	, c.cep_expedicao as 'CepExpedicao'
	, CASE
		WHEN c.capital THEN 'C'
		ELSE 'O'
	END as OrigemCapital
	, COALESCE(a.coeficiente,1) Coeficiente
FROM forma_entrega a
	INNER JOIN loja_forma_entrega b ON b.forma_entrega_id  = a.id
	INNER JOIN loja c ON c.id = b.loja_id
WHERE b.data_desativacao IS NULL
	AND a.tipo != 'I'

) c where c.client_id=131
;