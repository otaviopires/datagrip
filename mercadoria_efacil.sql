use efacil_prod_openkuget;
select * from (
SELECT
    a.id,
    a.client_id,
    a.loja_id,
    a.canal_anuncio_id,
    estoque_atual,
    altura altura,
    largura largura,
    comprimento comprimento,
    peso,
    (altura * largura * comprimento) volume,
    (altura * largura * comprimento) * 167 volume_correios,
    (altura * largura * comprimento) * 200 volume_transportadoras,
    data_fim_anuncio,
    b.armazena_log_frete,
    codigo_mercado,
    tempo_adicional_entrega,
    valor_atual AS preco_venda,
    c.codigo_externo codigo_mercadoria,
        '' token_canal,
    b.canal_id canal_venda_id
FROM
    anuncio_canal a
        INNER JOIN
    canal_cliente b ON a.canal_cliente_id = b.canal_id
        AND a.client_id = b.client_id
        INNER JOIN
    produto c ON c.id = a.produto_id
WHERE
    canal_cliente_id = 3
union
SELECT
    concat(a.id,'-',act.combinacao_atributo_id) id,
    a.client_id,
    a.loja_id,
    ea.codigo_externo canal_anuncio_id,
    act.estoque_atual,
    (if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.altura,c.altura)) altura,
    (if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.largura,c.largura)) largura,
    (if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.comprimento,c.comprimento)) comprimento,
    if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.peso,c.peso) peso,
    ((if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.altura,c.altura)) * (if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.largura,c.largura)) * (if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.comprimento,c.comprimento))) volume,
    ((if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.altura,c.altura)) * (if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.largura,c.largura)) * (if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.comprimento,c.comprimento))) * 167 volume_correios,
    ((if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.altura,c.altura)) * (if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.largura,c.largura)) * (if(coalesce(c.dimensoes_por_atributo,'N') = 'S',ea.comprimento,c.comprimento))) * 200 volume_transportadoras,
    a.data_fim_anuncio,
    b.armazena_log_frete,
    codigo_mercado,
    tempo_adicional_entrega,
    act.valor_atual AS preco_venda,
    ea.codigo_externo codigo_mercadoria,
        '' token_canal,
    b.canal_id canal_venda_id
FROM
    anuncio_canal a
        INNER JOIN
    canal_cliente b ON a.canal_cliente_id = b.canal_id
        AND a.client_id = b.client_id
        INNER JOIN
    produto c ON c.id = a.produto_id
    inner join anuncio_canal_atributo act on act.canal_anuncio_id = a.id
    inner join estoque_atributo ea on ea.combinacao_atributo_id = act.combinacao_atributo_id and a.produto_id = ea.produto_id and ea.loja_id = a.loja_id
WHERE
    canal_cliente_id = 3
UNION SELECT
    a.id,
    a.client_id,
    a.loja_id,
    a.canal_anuncio_id,
    estoque_atual,
    altura altura,
    largura largura,
    comprimento comprimento,
    peso,
    (altura * largura * comprimento) volume,
    (altura * largura * comprimento) * 167 volume_correios,
    (altura * largura * comprimento) * 200 volume_transportadoras,
    data_fim_anuncio,
    b.armazena_log_frete,
    b.canal_id AS 'codigo_mercado',
    tempo_adicional_entrega,
    valor_atual AS preco_venda,
    c.codigo_externo codigo_mercadoria,
        '' token_canal,
    b.canal_id canal_venda_id
FROM
    anuncio_canal a
        INNER JOIN
    canal_cliente b ON a.canal_cliente_id = b.canal_id
        AND a.client_id = b.client_id
        INNER JOIN
    produto c ON c.id = a.produto_id
        AND NOT EXISTS( SELECT
            1
        FROM
            anuncio_canal_atributo x
        WHERE
            x.canal_anuncio_id = a.id)
WHERE
    canal_cliente_id in (7,9, 12,16)
UNION
SELECT
    a.id,
    a.client_id,
    a.loja_id,
    CONCAT(a.produto_id,
            '-',
            x.combinacao_atributo_id) AS canal_anuncio_id,
    x.estoque_atual,
    altura altura,
    largura largura,
    comprimento comprimento,
    peso,
    (altura * largura * comprimento) volume,
    (altura * largura * comprimento) * 167 volume_correios,
    (altura * largura * comprimento) * 200 volume_transportadoras,
    x.data_fim_anuncio,
    b.armazena_log_frete,
    b.canal_id as 'codigo_mercado',
    tempo_adicional_entrega,
    x.valor_atual AS preco_venda,
    c.codigo_externo codigo_mercadoria,
        '' token_canal,
    b.canal_id canal_venda_id
FROM
    anuncio_canal a
        INNER JOIN
    canal_cliente b ON a.canal_cliente_id = b.canal_id
        AND a.client_id = b.client_id
        INNER JOIN
    produto c ON c.id = a.produto_id
        INNER JOIN
    anuncio_canal_atributo x ON x.canal_anuncio_id = a.id
WHERE
    canal_cliente_id in (7,9, 12,16)
UNION SELECT
    a.id,
    a.client_id,
    a.loja_id,
    a.canal_anuncio_id,
    estoque_atual,
    altura altura,
    largura largura,
    comprimento comprimento,
    peso,
    (altura * largura * comprimento) volume,
    (altura * largura * comprimento) * 167 volume_correios,
    (altura * largura * comprimento) * 200 volume_transportadoras,
    data_fim_anuncio,
    b.armazena_log_frete,
    codigo_mercado,
    tempo_adicional_entrega,
    valor_atual AS preco_venda,
    c.codigo_externo codigo_mercadoria,
        b.token_canal,
    b.canal_id canal_venda_id
FROM
    anuncio_canal a
        INNER JOIN
    canal_cliente b ON a.canal_cliente_id = b.canal_id
        AND a.client_id = b.client_id
        INNER JOIN
    produto c ON c.id = a.produto_id
WHERE
    canal_cliente_id = 2
UNION SELECT
    a.id,
    a.client_id,
    a.loja_id,
    a.canal_anuncio_id,
    estoque_atual,
    altura altura,
    largura largura,
    comprimento comprimento,
    peso,
    (altura * largura * comprimento) volume,
    (altura * largura * comprimento) * 167 volume_correios,
    (altura * largura * comprimento) * 200 volume_transportadoras,
    data_fim_anuncio,
    b.armazena_log_frete,
    codigo_mercado,
    tempo_adicional_entrega,
    valor_atual AS preco_venda,
    c.codigo_externo codigo_mercadoria,
        '' token_canal,
    b.canal_id canal_venda_id
FROM
    anuncio_canal a
        INNER JOIN
    canal_cliente b ON a.canal_cliente_id = b.canal_id
        AND a.client_id = b.client_id
        INNER JOIN
    produto c ON c.id = a.produto_id
        AND NOT EXISTS( SELECT
            1
        FROM
            anuncio_canal_atributo x
        WHERE
            x.canal_anuncio_id = a.id)
WHERE
    canal_cliente_id in (1)
UNION
SELECT
    a.id,
    a.client_id,
    a.loja_id,
    CONCAT(a.produto_id,
            '-',
            x.combinacao_atributo_id) AS canal_anuncio_id,
    x.estoque_atual,
    altura altura,
    largura largura,
    comprimento comprimento,
    peso,
    (altura * largura * comprimento) volume,
    (altura * largura * comprimento) * 167 volume_correios,
    (altura * largura * comprimento) * 200 volume_transportadoras,
    x.data_fim_anuncio,
    b.armazena_log_frete,
    codigo_mercado,
    tempo_adicional_entrega,
    x.valor_atual AS preco_venda,
    c.codigo_externo codigo_mercadoria,
        '' token_canal,
    b.canal_id canal_venda_id
FROM
    anuncio_canal a
        INNER JOIN
    canal_cliente b ON a.canal_cliente_id = b.canal_id
        AND a.client_id = b.client_id
        INNER JOIN
    produto c ON c.id = a.produto_id
        INNER JOIN
    anuncio_canal_atributo x ON x.canal_anuncio_id = a.id
WHERE
    canal_cliente_id in (1)

) r where canal_anuncio_id = 2214356 order by canal_anuncio_id

;