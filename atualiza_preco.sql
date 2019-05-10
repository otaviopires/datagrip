use saas_prod_openkuget;
delete from preco_final;
insert into preco_final(produto_id, loja_id, tipo_desconto, campanha_id, landing_id, valor_tipo_desconto, preco_padrao, preco_lista, combinacao_atributo_id, preco_atual, preco_por_campanha, prioridade_preco, exibir_busca,preco_custo,estoque,canal_venda_id) select produto_id, loja_id, tipo_desconto, campanha_id, landing_id, valor_tipo_desconto, preco_padrao, preco_lista, combinacao_atributo_id, preco_atual, preco_por_campanha, prioridade_preco, exibir_busca,preco_custo,estoque,canal_venda_id from view_preco;

select * from saas_prod_openkuget.preco_final where produto_id = 175307