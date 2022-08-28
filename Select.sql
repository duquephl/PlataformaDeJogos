    
SELECT UsuarioA.Nome, UsuarioB.Nome 
    FROM UsuarioUsuario 
    JOIN Usuario UsuarioA ON UsuarioUsuario.idUsuario1 = UsuarioA.idUsuario 
    JOIN Usuario UsuarioB ON UsuarioUsuario.idUsuario2 = UsuarioB.idUsuario 
    ORDER BY UsuarioA.Nome ASC;

SELECT Desenvolvedora.nome, AVG(Comunidade.avaliacao) AS MediaAvaliação FROM Jogo
    JOIN Desenvolvedora ON Jogo.idDesenvolvedora = Desenvolvedora.idDesenvolvedora
    JOIN Comunidade ON Comunidade.idJogo = Jogo.idJogo
    GROUP BY Desenvolvedora.nome ORDER BY MediaAvaliação DESC;   
    
SELECT Usuario.nome, SUM(Jogo.Preco) FROM UsuarioJogo 
    JOIN Jogo ON Jogo.idJogo = UsuarioJogo.idJogo
    JOIN Usuario ON Usuario.idUsuario = UsuarioJogo.idUsuario
    GROUP BY Usuario.nome ORDER BY SUM DESC;

SELECT Plataforma.Nome,COUNT(PlataformaJogo.IdJogo) AS QuantidadeJogoPorPlataforma 
    FROM PlataformaJogo
    JOIN Plataforma ON Plataforma.IdPlataforma = PlataformaJogo.IdPlataforma 
    GROUP BY Plataforma.Nome ORDER BY QuantidadeJogoPorPlataforma DESC;