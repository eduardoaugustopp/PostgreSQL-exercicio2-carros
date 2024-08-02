CREATE DATABASE veiculo;

CREATE TABLE carro (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    data_cadastro DATE NOT NULL
);

CREATE TABLE cor (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL
);

CREATE TABLE estacionamento (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cor_id INTEGER NOT NULL REFERENCES cor(id)
);

CREATE TABLE carro_estacionamento (
    carro_id INTEGER NOT NULL REFERENCES carro(id),
    estacionamento_id INTEGER NOT NULL REFERENCES estacionamento(id),
    PRIMARY KEY (carro_id, estacionamento_id)
);

INSERT INTO carro (titulo, autor, data_cadastro) VALUES
    ('Fiat Mobi: O carro acessível para todos', 'Fiat', '2024-07-10'),
    ('Audi e-tron GT: Desempenho ecológico com estilo', 'Audi', '2024-07-11'),
    ('Jeep Renegade: Aventura e conforto na cidade e na estrada', 'Jeep', '2024-07-12'),
    ('Porsche 911: Performance e Elegância', 'Porsche', '2024-07-13');

INSERT INTO cor (nome) VALUES
    ('preto'),
    ('vermelho'),
    ('branco'),
    ('prata');

INSERT INTO estacionamento (nome, cor_id) VALUES
    ('Pista Central', 1),
    ('Garage Norte', 1),
    ('Pit Stop Sul', 1),
    ('Box Leste', 2),
    ('Circuito Oeste', 2),
    ('Grid Aeroporto', 2),
    ('Pit Lane', 3),
    ('MotoPark', 3),
    ('Pit Stop', 3),
    ('Track', 3),
    ('Speedway', 3),
    ('Garage', 4),
    ('Parking Vertical', 4),
    ('AutoPark', 4);

INSERT INTO carro_estacionamento VALUES
    (1, 4),
    (1, 11),
    (2, 1),
    (2, 2),
    (3, 4),
    (3, 3),
    (4, 4),
    (4, 6),
    (4, 5);

SELECT carro.titulo,
       carro.autor,
       COUNT(carro_estacionamento.estacionamento_id) AS numero_estacionamentos
FROM carro
JOIN carro_estacionamento ON carro_estacionamento.carro_id = carro.id
GROUP BY carro.titulo, carro.autor
ORDER BY numero_estacionamentos DESC
LIMIT 1;

SELECT estacionamento.nome,
       COUNT(carro_estacionamento.carro_id) AS numero_carros
FROM estacionamento
JOIN carro_estacionamento ON carro_estacionamento.estacionamento_id = estacionamento.id
GROUP BY estacionamento.nome
ORDER BY numero_carros DESC
LIMIT 1;

SELECT * FROM estacionamento WHERE cor_id = 1 OR cor_id = 2;

SELECT * FROM estacionamento WHERE cor_id IN (1, 2);

SELECT * FROM estacionamento WHERE cor_id IN (
    SELECT id FROM cor WHERE nome NOT LIKE 'p%'
);

SELECT cor,
       numero_estacionamentos
FROM (
    SELECT cor.nome AS cor,
           COUNT(estacionamento.id) AS numero_estacionamentos
    FROM cor
    JOIN estacionamento ON estacionamento.cor_id = cor.id
    GROUP BY cor.nome
) AS cor_estacionamentos
WHERE numero_estacionamentos > 3;

SELECT (titulo || ' ' || autor) AS item FROM carro;

SELECT UPPER(CONCAT('Fiat Mobi:', NULL, 'O carro acessível para todos') || ' ');

SELECT TRIM(UPPER(CONCAT('Fiat Mobi:', NULL, 'O carro acessível para todos') || ' '));

SELECT (titulo || autor) AS item, data_cadastro FROM carro;

SELECT (titulo || autor) AS item, NOW()::DATE, data_cadastro FROM carro;

SELECT (titulo || autor) AS item,
       AGE(data_cadastro) AS tempo_cadastrado
FROM carro;

SELECT (titulo || autor) AS item,
       EXTRACT(YEAR FROM AGE(data_cadastro)) AS tempo_cadastrado
FROM carro;

SELECT pi();

SELECT @ -17581452174;

SELECT TO_CHAR(NOW(), 'DD, MONTH, YYYY');

SELECT TO_CHAR(128.3::REAL, '9999099');

SELECT cor
FROM vw_estacionamentos_por_cor
WHERE numero_estacionamentos > 3;

CREATE VIEW vw_estacionamentos_por_cor AS
SELECT cor.nome AS cor,
       COUNT(estacionamento.id) AS numero_estacionamentos
FROM cor
JOIN estacionamento ON estacionamento.cor_id = cor.id
GROUP BY cor.nome;

CREATE VIEW vw_estacionamentos_preto AS
SELECT nome FROM estacionamento WHERE cor_id = 1;
