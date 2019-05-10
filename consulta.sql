#QCOMPRA
select * from amvox_prod_openksam.url;
select * from amvox_prod_openkuget.url_loja;

select * from amvox_prod_openkuget.configuracao_foto;
select * from amvox_prod_openkuget.foto_produto_configuracao;
select * from amvox_prod_openkuget.configuracao_site;

select * from saas_prod_openksam.url where client_id = 119;

#ACHEI UTIL
select * from acheiutil_prod_openksam.url where address like "%ach%";
select * from acheiutil_prod_openkuget.url_loja where url_navegacao like "%ach%";
select * from acheiutil_prod_openkuget.produto;


#MONTA TUDO
select * from saas_prod_openksam.url where address like "%mont%";
select * from saas_prod_openkuget.url_loja where url_navegacao like "%mont%";

#AHORTA
select * from saas_prod_openksam.url where address like "%ahor%";
select * from saas_prod_openkuget.url_loja where url_navegacao like "%ahor%";
select * from saas_prod_openkuget.configuracao_site where url_site like "%ahor%";


#JOLAS MAROS
select * from lojasramos_dev_openkuget.url_loja;
select * from lojasramos_dev_openksam.url;
select * from lojasramos_dev_openkuget.configuracao_site; 


#SIR TECNOLOGIA
select * from saas_prod_openksam.url where client_id = 64 #where address LIKE "%sir%";
select * from saas_prod_openkuget.url_loja where loja_id = 11 #where url_navegacao like "%sir%";

#PANTEX
SELECT * FROM pantex_prod_openksam.url;
SELECT * FROM pantex_dev_openkuget.url_loja;

select quantidade_maxima_estoque_logico from saas_prod_openkuget.produto where produto.id = 174925


#REDE NORTE
SELECT * FROM redenorte_pre_openksam.url;
SELECT * FROM redenorte_pre_openkuget.url_loja;

SELECT * FROM redenorte_prod_openksam.url;
SELECT * FROM redenorte_prod_openkuget.url_loja;


#EKASA
select * from saas_prod_openksam.url where address LIKE "%eka%";
select * from saas_prod_openkuget.url_loja where url_navegacao like "%eka%";

select * from saas_prod_openkuget.bandeira where client_id=120;
select * from openk_gw.relacaobandeiracliente

select * from saas_prod_openkuget.bandeira b
inner join openk_gw.relacaobandeiracliente r on r.token = b.token
where b.client_id = 120;

select * from openk_gw.carteiracliente where idclientes = 35
select * from openk_prod_gw.carteiracliente where idclientes = 35

select * from openk_gw.relacaobandeiracliente where idclientes=35;
select * from openk_gw.relacaobandeiracliente where idbandeira=2 and token='ee7dbd653aed0cbde0e2ea951f4f357e';


#SELF CAR
select * from saas_prod_openksam.url where address LIKE "%self%";
select * from saas_prod_openkuget.url_loja where url_navegacao like "%self%";
select * from saas_prod_openkuget.configuracao_site where client_id = 119;


#LOJASIM
select * from saas_prod_openksam.url where address LIKE "%sim%";
select * from saas_prod_openkuget.url_loja where url_navegacao like "%sim%";
SELECT * FROM saas_prod_openkuget.configuracao_site WHERE client_id = 131;
SELECT * FROM saas_prod_openkuget.loja l WHERE l.client_id = 131;

#EFACIL
SELECT * FROM efacil_prod_openkuget.url_loja;
select * from efacil_dev_openksam.url;


#NAVECELL
select * from saas_prod_openksam.urederl where address LIKE "%nav%";
select * from saas_prod_openkuget.url_loja where url_navegacao like "%nav%";
select * from saas_prod_openksam.member where client_id = 103;
SELECT * FROM saas_prod_openkuget.configuracao_site WHERE client_id = 103;
SELECT * FROM saas_prod_openkuget.loja WHERE client_id = 103;

SELECT * FROM saas_prod_openkuget.configuracao_site WHERE client_id = 103;


SELECT * FROM saas_prod_openkuget.produto WHERE client_id = 64 AND id = 171941;

select url_site from saas_prod_openkuget.configuracao_site where client_id = 64;
update saas_prod_openkuget.configuracao_site set url_site = "http://www.sirtecnologia.openk.local" where client_id = 64;

insert into  openk_uaddress.faixa_cep_cidade (cidade_id, cep_inicial, cep_final) values (12740, 78245000, 78249999)

delete from openk_uaddress.faixa_cep_cidade where cidade_id = 2107 and cep_inicial = 75690000
