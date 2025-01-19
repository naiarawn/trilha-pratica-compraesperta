CREATE TABLE tbl_produto (
    cd_ean_prod VARCHAR(13),
    ce_rfid INTEGER,
    nm_prod VARCHAR(255),
    cp_id_prod SERIAL PRIMARY KEY,
    ce_categoria_principal INTEGER,
    ce_categoria_secundaria INTEGER,
    fk_tbl_validade_cp_id_validade INTEGER
);

CREATE TABLE tbl_fornecedor (
    localizacao_forn VARCHAR(255),
    endereco_forn VARCHAR(255),
    cp_cod_forn SERIAL PRIMARY KEY,
    cnpj_forn CHAR(14),
    cidade_forn VARCHAR(255),
    UF_forn CHAR(2)
);

CREATE TABLE tbl_categoria (
    cp_cod_categoria SERIAL PRIMARY KEY,
    nm_categoria VARCHAR(255),
    fk_tbl_produto_cp_id_prod INTEGER
);

CREATE TABLE tbl_rfid (
    cp_id_dispositivo SERIAL PRIMARY KEY,
    ind_venda_dispositivo BOOLEAN
);

CREATE TABLE tbl_estabelecimento (
    cp_cod_estab SERIAL PRIMARY KEY,
    nm_estab VARCHAR(255),
    cnpj_estab CHAR(14),
    localizacao_estab VARCHAR(255),
    endereco_estab VARCHAR(255),
    UF_estab CHAR(2),
    cidade_estab VARCHAR(255)
);

CREATE TABLE tbl_funcionario (
    cp_cod_func SERIAL PRIMARY KEY,
    nm_func VARCHAR(255),
    cpf_func CHAR(11),
    funcao_func VARCHAR(255)
);

CREATE TABLE tbl_compras (
    ce_id_cliente INTEGER,
    cp_id_compra SERIAL PRIMARY KEY,
    ce_id_estabelecimento INTEGER,
    dt_compra DATE,
    vlr_compra DECIMAL
);

CREATE TABLE tb_cliente (
    nm_cliente VARCHAR(255),
    cpf_cliente CHAR(11),
    dt_nascimento DATE,
    cp_id_cliente SERIAL PRIMARY KEY,
    dt_cadastro DATE,
    telefone_cliente VARCHAR(20),
    email_cliente VARCHAR(255)
);

CREATE TABLE tbl_validade (
    cp_id_validade SERIAL PRIMARY KEY,
    ce_cod_forn INTEGER,
    ce_id_prod INTEGER,
    dt_fabricacao DATE,
    dt_validade DATE,
    qtde_lote INTEGER
);

CREATE TABLE produto_fornecedor (
    ce_cod_forn INTEGER,
    preco_venda DECIMAL,
    dt_venda DATE,
    preco_compra DECIMAL,
    ce_id_prod INTEGER,
    dt_compra DATE,
    PRIMARY KEY (ce_cod_forn, ce_id_prod)
);

CREATE TABLE produto_estabelecimento (
    fk_tbl_produto_cp_id_prod INTEGER,
    fk_tbl_estabelecimento_cp_cod_estab INTEGER,
    PRIMARY KEY (fk_tbl_produto_cp_id_prod, fk_tbl_estabelecimento_cp_cod_estab)
);

CREATE TABLE produto_funcionario (
    fk_tbl_produto_cp_id_prod INTEGER,
    fk_tbl_funcionario_cp_cod_func INTEGER
);

CREATE TABLE produto_compra (
    qtde_comprada DECIMAL,
    ce_id_compra INTEGER,
    ce_id_prod INTEGER,
    vlr_unitario DECIMAL,
    PRIMARY KEY (ce_id_compra, ce_id_prod)
);

CREATE TABLE fornecedor_validade (
    fk_tbl_fornecedor_cp_cod_forn INTEGER,
    fk_tbl_validade_cp_id_validade INTEGER,
    PRIMARY KEY (fk_tbl_fornecedor_cp_cod_forn, fk_tbl_validade_cp_id_validade)
);

-- Constraints for Foreign Keys
ALTER TABLE tbl_produto ADD CONSTRAINT fk_tbl_produto_validade
    FOREIGN KEY (fk_tbl_validade_cp_id_validade)
    REFERENCES tbl_validade (cp_id_validade)
    ON DELETE RESTRICT;

ALTER TABLE tbl_produto ADD CONSTRAINT fk_tbl_produto_rfid
    FOREIGN KEY (ce_rfid)
    REFERENCES tbl_rfid (cp_id_dispositivo);

ALTER TABLE tbl_categoria ADD CONSTRAINT fk_tbl_categoria_produto
    FOREIGN KEY (fk_tbl_produto_cp_id_prod)
    REFERENCES tbl_produto (cp_id_prod)
    ON DELETE SET NULL;

ALTER TABLE tbl_compras ADD CONSTRAINT fk_tbl_compras_cliente
    FOREIGN KEY (ce_id_cliente)
    REFERENCES tb_cliente (cp_id_cliente)
    ON DELETE RESTRICT;

ALTER TABLE tbl_validade ADD CONSTRAINT fk_tbl_validade_produto
    FOREIGN KEY (ce_id_prod)
    REFERENCES tbl_produto (cp_id_prod);

ALTER TABLE produto_fornecedor ADD CONSTRAINT fk_produto_fornecedor_produto
    FOREIGN KEY (ce_id_prod)
    REFERENCES tbl_produto (cp_id_prod);

ALTER TABLE produto_fornecedor ADD CONSTRAINT fk_produto_fornecedor_fornecedor
    FOREIGN KEY (ce_cod_forn)
    REFERENCES tbl_fornecedor (cp_cod_forn);

ALTER TABLE produto_estabelecimento ADD CONSTRAINT fk_produto_estabelecimento_produto
    FOREIGN KEY (fk_tbl_produto_cp_id_prod)
    REFERENCES tbl_produto (cp_id_prod)
    ON DELETE SET NULL;

ALTER TABLE produto_estabelecimento ADD CONSTRAINT fk_produto_estabelecimento_estabelecimento
    FOREIGN KEY (fk_tbl_estabelecimento_cp_cod_estab)
    REFERENCES tbl_estabelecimento (cp_cod_estab)
    ON DELETE SET NULL;

ALTER TABLE produto_funcionario ADD CONSTRAINT fk_produto_funcionario_produto
    FOREIGN KEY (fk_tbl_produto_cp_id_prod)
    REFERENCES tbl_produto (cp_id_prod)
    ON DELETE RESTRICT;

ALTER TABLE produto_funcionario ADD CONSTRAINT fk_produto_funcionario_funcionario
    FOREIGN KEY (fk_tbl_funcionario_cp_cod_func)
    REFERENCES tbl_funcionario (cp_cod_func)
    ON DELETE SET NULL;

ALTER TABLE produto_compra ADD CONSTRAINT fk_produto_compra_compra
    FOREIGN KEY (ce_id_compra)
    REFERENCES tbl_compras (cp_id_compra)
    ON DELETE RESTRICT;

ALTER TABLE produto_compra ADD CONSTRAINT fk_produto_compra_produto
    FOREIGN KEY (ce_id_prod)
    REFERENCES tbl_produto (cp_id_prod)
    ON DELETE SET NULL;

ALTER TABLE fornecedor_validade ADD CONSTRAINT fk_fornecedor_validade_fornecedor
    FOREIGN KEY (fk_tbl_fornecedor_cp_cod_forn)
    REFERENCES tbl_fornecedor (cp_cod_forn)
    ON DELETE RESTRICT;

ALTER TABLE fornecedor_validade ADD CONSTRAINT fk_fornecedor_validade_validade
    FOREIGN KEY (fk_tbl_validade_cp_id_validade)
    REFERENCES tbl_validade (cp_id_validade)
    ON DELETE RESTRICT;
