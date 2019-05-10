use pantex_dev_openkuget;
select * from pantex_dev_openkuget.produto
select * from pedido where id = 248520;
select *  from preco_final where produto_id = 169159;
select estoque_por_atributo from produto where id = 9;


select * from redenorte_prod_openkuget.estoque_atributo where produto_id = 9;

select * from redenorte_prod_openkuget.produto where id = 91;
select combinacao_atributo_id from redenorte_prod_openkuget.preco_final where produto_id = 9;

select  * from redenorte_prod_openkuget.preco_final pf where pf.produto_id = 9;

select ca.*, p.categoria_id
from redenorte_prod_openkuget.combinacao_atributo ca
inner join produto p
where p.id = 9;

select * from redenorte_prod_openkuget.unidade_distribuicao_estoque where produto_id = 9;

#where ca.combinacao_atributo_pai = 2
;

select * from redenorte_prod_openkuget.categoria;

select * from (
                  SELECT p.codigo_compra codigo_compra,
                         p.id,
                         p.pedido_consignado_id,
                         p.datapedido,
                         l.nome nome_loja,
                         p.valor valor_itens,
                         p.custo_frete as valor_frete, (valor_desconto) valor_desconto,
                         valor_adicional_forma_pagamento,
                         p.valor + valor_frete - valor_desconto + valor_adicional_forma_pagamento valor_total_pedido,
                         sugestao_pratica_descricao,
                         f.descricao                                                              forma_pagamento,
                         s.id                                                                     statusid,
                         coalesce(sc.nomeexibicao, s.nome)                                        status,
                         e.descricao_endereco,
                         CASE WHEN u.cpf THEN u.nome ELSE u.razaosocial END                       usuario,
                         ban.descricao                                                            bandeira,
                         CASE WHEN p.eh_consignado THEN 'Sim' ELSE 'Não' END                      eh_consignado,
                         l.nome                   as                                              'nomeloja',
                         concat(cv.nome, coalesce(concat(' - ', cs.nome), ''))                    canal,
                         ci.data_confirmacao,
                         (select case when count(id) > 0 then 'Sim' else 'Não' end
                          from pedido_assinatura
                          where pedido_id = p.id) AS                                              'assinatura'
                  FROM pedido p
                           INNER JOIN usuario u ON p.usuario_id = u.id
                           INNER JOIN endereco e ON e.id = p.endereco_id
                           INNER JOIN loja l ON l.id = p.loja_id and l.client_id = p.client_id
                           INNER JOIN condicaopagamento c ON p.condicaopagamento_id = c.id
                           INNER JOIN bandeira ban ON ban.id = c.bandeira_id
                           INNER JOIN formapagamento f ON f.id = c.formapagamento_id
                           INNER JOIN pedido_status ps ON ps.id = p.pedidostatus_id
                           INNER JOIN status s ON s.id = ps.status_id
                           LEFT JOIN status_cliente sc ON sc.status_id = s.id AND sc.client_id = p.client_id
                           left join canal_venda cv on cv.id = p.canal_venda_id
                           left join canal_site cs on cs.id = p.site_id
                           LEFT JOIN openk_integracao.confirma_integracao ci ON p.id = ci.codigo_abrangencia
                      AND p.client_id = ci.client_id
                      and ci.tipo_abrangencia_id = (SELECT CASE s.id WHEN 2 THEN 17 WHEN 4 THEN 18 ELSE 0 END)
                  WHERE p.client_id = 64
              ) c where c.id = 248520;