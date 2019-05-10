USE redenorte_prod_openkuget;
SELECT UUID()                    as id_unique,
       a.id                      as canal_anuncio_id,
       a.client_id,
       a.peso                    as peso,
       a.altura                  as altura,
       a.largura                 as largura,
       a.comprimento             as comprimento,
       a.volume                  AS volume,
       a.codigo_referencia       AS codigo_mercadoria,
       a.tempo_adicional_entrega AS tempo_adicional_entrega,
       b.loja_id,
       d.quantidade              AS estoque_atual,
       b.preco_atual             as preco_venda
FROM produto a
         INNER JOIN preco_final b ON b.produto_id = a.id
         INNER JOIN estoqueproduto d ON d.produto_id = a.id AND d.loja_id = b.loja_id
WHERE a.data_desativacao IS NULL
  AND a.estoque_por_atributo IS FALSE
UNION
SELECT UUID()                                      as id_unique,
       CONCAT(a.id, '_', b.combinacao_atributo_id) as canal_anuncio_id,
       a.client_id,
       a.peso                                      as peso,
       a.altura                                    as altura,
       a.largura                                   as largura,
       a.comprimento                               as comprimento,
       a.volume                                    AS volume,
       a.codigo_referencia                         AS codigo_mercadoria,
       a.tempo_adicional_entrega                   AS tempo_adicional_entrega,
       b.loja_id,
       d.quantidade                                AS estoque_atual,
       c.preco_atual                               as preco_venda
FROM produto a
         INNER JOIN estoque_atributo b ON b.produto_id = a.id
         INNER JOIN preco_final c ON c.produto_id = a.id AND c.combinacao_atributo_id = b.combinacao_atributo_id AND
                                     c.loja_id = b.loja_id
         INNER JOIN estoqueproduto d ON d.produto_id = a.id AND d.loja_id = b.loja_id
WHERE a.data_desativacao IS NULL;