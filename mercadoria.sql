use efacil_prod_openkuget;
select * from (
SELECT UUID() id_randon
    , a.id
    , a.client_id
    , a.loja_id
    , a.canal_anuncio_id
    , b.token_canal
    , CASE
        WHEN c.estoque_por_atributo THEN COALESCE(d.estoque_atual, a.estoque_atual)
        ELSE a.estoque_atual
    END estoque_atual
    , CASE
        WHEN c.dimensoes_por_atributo    = 'S' THEN COALESCE(e.altura,c.altura)
        ELSE c.altura
    END altura
    , CASE
        WHEN c.dimensoes_por_atributo = 'S' THEN COALESCE(e.largura,c.largura)
        ELSE c.largura
    END largura
    , CASE
        WHEN c.dimensoes_por_atributo = 'S' THEN COALESCE(e.comprimento,c.comprimento)
        ELSE c.comprimento
    END comprimento
    , CASE
        WHEN c.dimensoes_por_atributo = 'S' THEN COALESCE(e.peso,c.peso)
        ELSE c.peso
    END peso
    , c.volume
    , CASE
        WHEN c.estoque_por_atributo THEN COALESCE(d.data_fim_anuncio, a.data_fim_anuncio)
        ELSE a.data_fim_anuncio
    END 'data_fim_anuncio'
    , b.armazena_log_frete
    , b.canal_id 'codigo_mercado'
    , c.tempo_adicional_entrega
    , CASE
        WHEN c.estoque_por_atributo THEN COALESCE(d.valor_atual, a.valor_atual)
        ELSE a.valor_atual
    END 'preco_venda'
    , c.codigo_externo 'codigo_mercadoria'
    , coalesce(CONCAT(a.produto_id, '-', d.combinacao_atributo_id), a.produto_id) 'codigo_ref_mercadoria'
    , c.id 'produto_id'
FROM anuncio_canal a
INNER JOIN canal_cliente b ON b.canal_id = a.canal_cliente_id and b.client_id = a.client_id AND b.loja_id = a.loja_id  AND b.data_desativacao is null
INNER JOIN produto c ON c.id = a.produto_id and c.data_desativacao is null
INNER JOIN loja l ON l.id = a.loja_id and l.data_desativacao is null
LEFT JOIN anuncio_canal_atributo d ON d.canal_anuncio_id = a.id and d.data_fim_anuncio is null
LEFT JOIN estoque_atributo e ON e.produto_id = c.id AND e.loja_id = a.loja_id AND e.combinacao_atributo_id = d.combinacao_atributo_id and e.data_desativacao is null
WHERE a.data_fim_anuncio is null

) r where canal_anuncio_id = 2214356
;