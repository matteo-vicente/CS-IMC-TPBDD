-- Partie 1

-- Exercice 0
	
-- SELECT* FROM dbo.tArtist;
-- SELECT* FROM dbo.tFilm;
-- SELECT* FROM dbo.tFilmGenre;
-- SELECT* FROM dbo.tGenre;
-- SELECT* FROM dbo.tJob;

-- On a 5 tables dans cette base de données.
-- dbo.tArtist : id de l'artiste, son nom, son année de naissance
-- dbo.tFilm : id du film, son titre, son année de sortie, sa durée
-- dbo.tFilmGenre : id du film, id du genre
-- dbo.tGenre : id du genre, nom du genre (la table est vide)
-- dbo.tJob : id de l'artiste, métier, id du film

-- Exercice 1

-- SELECT birthYear FROM dbo.tArtist WHERE primaryName = 'Brad Pitt';

-- On ne trouve rien,Brad Pitt n'apparaît pas.

-- Exercice 2

-- SELECT COUNT(*) FROM dbo.tArtist;

-- On a 82 046 artistes dans la DB.

-- Exerice 3

-- SELECT primaryName FROM dbo.tArtist WHERE birthYear = 1960;
-- SELECT COUNT(*) FROM dbo.tArtist WHERE birthYear = 1960;

-- On a 203 artistes nés en 1960.

-- Exercice 4

-- SELECT TOP 1 birthYear, COUNT(*) AS NombreArtistes FROM dbo.tArtist WHERE birthYear <> 0 GROUP BY birthYear ORDER BY NombreArtistes DESC;

-- Ici on va compter le nombre d'artistes par année de naissance et trier par ordre décroissant et ne garder que la première ligne.
-- L'année avec le plus d'artistes est 1980 avec 477 artistes.

-- Exercice 5

-- SELECT primaryName FROM
-- (SELECT dbo.tJob.idArtist, COUNT(*) AS NombreDeFilms FROM dbo.tArtist JOIN dbo.tJob ON dbo.tArtist.idArtist = dbo.tJob.idArtist GROUP BY dbo.tJob.idArtist) AS temp
-- JOIN dbo.tArtist ON dbo.tArtist.idArtist = temp.idArtist WHERE NombreDeFilms > 1;

-- D'abord sur tJob on affiche le nombre de films pour chaque acteur, avant de faire une jointure avec tArtist.

-- Exercice 6

-- SELECT primaryName FROM
-- (SELECT dbo.tJob.idArtist, COUNT(DISTINCT category) AS NombreDeMetiers FROM dbo.tArtist JOIN dbo.tJob ON dbo.tArtist.idArtist = dbo.tJob.idArtist GROUP BY dbo.tJob.idArtist
-- ) AS temp
-- JOIN dbo.tArtist ON dbo.tArtist.idArtist = temp.idArtist WHERE NombreDeMetiers > 1;

-- On fait une requête similaire à celle d'avant, en comptant à présent les métiers (sans compter les doublons).

-- Exercice 7

-- SELECT TOP 1 WITH TIES primaryTitle FROM dbo.tFilm JOIN
-- (SELECT idFilm, COUNT(idArtist) AS NbActeurs FROM dbo.tJob WHERE category = 'acted in' GROUP BY idFilm) AS temp
-- ON dbo.tFilm.idFilm=temp.idFilm ORDER BY NbActeurs DESC

-- D'abord dans tJob on récupère le nombre d'acteur pour chaque film, et ensuite on joint avec tFilm pour avoir les noms on trie sur NbActeurs par ordre DESC et on prend TOP 1 WITH TIES pour avoir les 1ers ex-aequo.