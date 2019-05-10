USE amvox_pre_openkuget;
select * from
    (
              SELECT UUID() as id_unique
                    , CASE
                        WHEN a.estoque_por_atributo THEN COALESCE(CONCAT(a.id, '_', c.combinacao_atributo_id), a.id)
                        ELSE a.id
                    END as canal_anuncio_id
                    , a.client_id
                    , CASE
                        WHEN a.dimensoes_por_atributo = 'S' THEN c.peso
                        ELSE a.peso
                    END AS peso
                    , CASE
                        WHEN a.dimensoes_por_atributo = 'S' THEN c.altura
                        ELSE a.altura
                    END as altura
                    , CASE
                        WHEN a.dimensoes_por_atributo = 'S' THEN c.largura
                        ELSE a.largura
                    END as
                        largura
                    , CASE
                        WHEN a.dimensoes_por_atributo = 'S' THEN c.comprimento
                        ELSE a.comprimento
                    END as comprimento
                    , a.volume AS volume
                    , a.codigo_referencia AS codigo_mercadoria
                    , a.tempo_adicional_entrega AS tempo_adicional_entrega
                    , pl.loja_id
                    , CASE
                        WHEN a.estoque_por_atributo THEN c.quantidade
                        WHEN a.estoque_logico THEN (e.quantidade_estoque_logico + e.quantidade)
                        ELSE e.quantidade
                    END AS estoque_atual
                    , CASE
                        WHEN a.preco_por_atributo  = 'S' then pa.preco_atual
                        ELSE pp.preco_atual
                    END AS preco_venda
                    , a.categoria_id

                FROM produto a
                    inner join produto_loja pl on pl.produto_id = a.id
                    left join estoqueproduto e on a.id = e.produto_id and pl.loja_id = e.loja_id
                    left join preco_produto pp on pp.produto_id = a.id and pl.loja_id = pp.loja_id
                    LEFT JOIN estoque_atributo c ON c.produto_id = pl.produto_id and pl.loja_id = c.loja_id
                    left join preco_atributo pa on pa.produto_id = pl.produto_id and pl.loja_id = pa.loja_id
                    and pa.combinacao_atributo_id = c.combinacao_atributo_id
                    and c.data_desativacao is null
                    and c.data_bloqueio is null
                    and pl.data_desativacao is null
                    and a.data_desativacao is null

) r where r.canal_anuncio_id = 57;

select estoque_logico from amvox_pre_openkuget.produto where  id = 57
select * from amvox_pre_openkuget.estoqueproduto where produto_id = 57
select * from amvox_pre_openkuget.estoque_atributo where produto_id = 57