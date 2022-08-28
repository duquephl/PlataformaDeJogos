CREATE TABLE Desenvolvedora(
    IdDesenvolvedora INTEGER NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Responsavel VARCHAR(50) NOT NULL,
    Sobre VARCHAR(200),
    DataCriacao DATE,
    CONSTRAINT PKDesenvolvedora PRIMARY KEY(IdDesenvolvedora),
    CONSTRAINT UNNome_Desenvolvedora UNIQUE (Nome)
    );

CREATE TABLE Regiao(
    IdRegiao INTEGER NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    CONSTRAINT PKRegiao PRIMARY KEY(IdRegiao),
    CONSTRAINT UNNome_Regiao UNIQUE (Nome)
    );

CREATE TABLE Pais(
    IdPais INTEGER NOT NULL,
    Nome VARCHAR(60) NOT NULL,
    IdRegiao INTEGER NOT NULL,
    CONSTRAINT PKPais PRIMARY KEY(IdPais),
    CONSTRAINT UNNome_Pais UNIQUE (Nome),
    CONSTRAINT FKIdRegiao FOREIGN KEY (IdRegiao) REFERENCES Regiao(IdRegiao)
);

CREATE TABLE Distribuidora(
    IdDistribuidora INTEGER NOT NULL,
    Nome VARCHAR(60) NOT NULL,
    Sobre VARCHAR(200),
    Responsavel VARCHAR(50) NOT NULL,
    DataCriacao DATE,
    IdRegiao INTEGER NOT NULL,
    CONSTRAINT PKIdDistribuidora PRIMARY KEY (IdDistribuidora),
    CONSTRAINT UNNome_Distribuidora UNIQUE (Nome),
    CONSTRAINT FKIdRegiaoDistribuidora FOREIGN KEY (IdRegiao) REFERENCES Regiao(IdRegiao)
);

CREATE TABLE Idioma(
    IdIdioma INTEGER NOT NULL,
    Nome VARCHAR(30),
    CONSTRAINT UNNome_Idioma UNIQUE (Nome),
    CONSTRAINT PKIdioma PRIMARY KEY(IdIdioma)
);

CREATE TABLE Plataforma(
    IdPlataforma INTEGER NOT NULL,
    Nome VARCHAR(30),
    CONSTRAINT UNNome_Plataforma UNIQUE (Nome),
    CONSTRAINT PKPlataforma PRIMARY KEY(IdPlataforma)
);

CREATE TABLE Jogo(
    IdJogo INTEGER NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Genero char(20),
    DataLancamento DATE, 
    Classificacao VARCHAR(3),
    RequisitosSistema VARCHAR(200),
    Preco DECIMAL(7,2) NOT NULL,
    IdDesenvolvedora INTEGER NOT NULL,
    IdDistribuidora INTEGER NOT NULL,
    CONSTRAINT PKJogo PRIMARY KEY(IdJogo),
    CONSTRAINT UNNome_Jogo UNIQUE (Nome),
    CONSTRAINT FKIdDesenvolvedoraJogo FOREIGN KEY (IdDesenvolvedora) REFERENCES Desenvolvedora(IdDesenvolvedora),
    CONSTRAINT FKIdDistribuidora FOREIGN KEY (IdDistribuidora) REFERENCES Distribuidora(IdDistribuidora),
    CONSTRAINT CH_PRECO CHECK (PRECO > 0)
);

CREATE TABLE IdiomaJogo(
    IdIdioma INTEGER NOT NULL,
    IdJogo INTEGER NOT NULL,
    CONSTRAINT FKIdIdiomaJogo FOREIGN KEY(IdIdioma) REFERENCES Idioma(IdIdioma),
    CONSTRAINT FKIdJogoIdioma FOREIGN KEY(IdJogo) REFERENCES Jogo(IdJogo)
);

CREATE TABLE Usuario(
    IdUsuario INTEGER NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Username VARCHAR(30) NOT NULL,
    Saldo DECIMAL(7,2) NOT NULL,
    Senha VARCHAR(50) NOT NULL,
    Telefone VARCHAR(20),
    Email VARCHAR(50) NOT NULL,
    IdPais INTEGER NOT NULL,
    CONSTRAINT PKUsuario PRIMARY KEY(IdUsuario),
    CONSTRAINT UNUsername_Usuario UNIQUE (Username),
    CONSTRAINT UNEmail_Usuario UNIQUE (Email),
    CONSTRAINT FKIdPaisUsuario FOREIGN KEY(IdPais) REFERENCES Pais(IdPais),
    CONSTRAINT CH_Saldo CHECK (Saldo >= 0)
);

CREATE TABLE Cartao(
    IdCartao INTEGER NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    NumeroCartao VARCHAR(16) NOT NULL,
    CPF VARCHAR(12) NOT NULL,
    CVV VARCHAR(3) NOT NULL, 
    Validade DATE NOT NULL, 
    Tipo CHAR(1) NOT NULL,
    IdUsuario INTEGER NOT NULL,
    CONSTRAINT PKIdCartao PRIMARY Key (IdCartao),
    CONSTRAINT FKIdUsuario_Cartao FOREIGN KEY (IdUsuario) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE Cupom(
    IdCupom INTEGER NOT NULL,
    Validade DATE NOT NULL,
    Valor DECIMAL (7,2),
    Porcentagem DECIMAL(2,2),
    IdJogo INTEGER,
    CONSTRAINT PKIdCupom PRIMARY Key(IdCupom),
    CONSTRAINT FKIdJogo_Cupom FOREIGN KEY (IdJogo) REFERENCES Jogo(IdJogo)
);

CREATE TABLE Transacao(
    IdTransacao INTEGER NOT NULL,
    Total DECIMAL(7,2) NOT NULL,
    Data DATE NOT NULL,
    IdCupom INTEGER,
    Boleto VARCHAR(48),
    Saldo DECIMAL(7,2),
    IdCartao INTEGER,
    CONSTRAINT PKIdTransacao PRIMARY Key(IdTransacao),
    CONSTRAINT FKIdCupom_Transacao FOREIGN Key(IdCupom) REFERENCES Cupom(IdCupom),
    CONSTRAINT FKIdCartao_Transacao FOREIGN Key (IdCartao) REFERENCES Cartao(IdCartao)
);

CREATE TABLE UsuarioJogo(
    IdUsuario INTEGER NOT NULL,
    IdJogo INTEGER NOT NULL,
    IdTransacao INTEGER NOT NULL,
    CONSTRAINT FKIdUsuario_UsuarioJogo FOREIGN KEY(IdUsuario) REFERENCES Usuario(IdUsuario),
    CONSTRAINT FKJogo_UsuarioJogo FOREIGN KEY(IdJogo) REFERENCES Jogo(IdJogo),
    CONSTRAINT FKTransacao_UsuarioJogo FOREIGN Key (IdTransacao) REFERENCES Transacao(IdTransacao)
);

CREATE TABLE UsuarioUsuario (
    IdUsuario1 INTEGER NOT NULL,
    IdUsuario2 INTEGER NOT NULL,
    CONSTRAINT FKIdUsuario1_UsuarioUsuario FOREIGN Key(IdUsuario1) REFERENCES Usuario(IdUsuario),
    CONSTRAINT FKIdUsuario2_UsuarioUsuario FOREIGN Key(IdUsuario2) REFERENCES Usuario(IdUsuario)
);

CREATE TABLE Comunidade(
    IdComunidade INTEGER NOT NULL,
    Titulo VARCHAR(50) NOT NULL,
    Mensagem VARCHAR(300),
    NomeArquivo VARCHAR(100),
    Avaliacao INTEGER,
    IdJogo INTEGER NOT NULL,
    CONSTRAINT PKIdComunidade PRIMARY Key (IdComunidade),
    CONSTRAINT FKIdJogo_Comunidade FOREIGN Key(IdJogo) REFERENCES Jogo(IdJogo)
);

CREATE TABLE PlataformaJogo(
    IdPlataforma INTEGER NOT NULL,
    IdJogo INTEGER NOT NULL,
    CONSTRAINT FKIdPlataforma_PlataformaJogo FOREIGN KEY(IdPlataforma) REFERENCES Plataforma(IdPlataforma),
    CONSTRAINT FKIdJogo_PlataformaJogo FOREIGN KEY(IdJogo) REFERENCES Jogo(IdJogo)
);
