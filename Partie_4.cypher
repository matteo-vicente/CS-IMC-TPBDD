// Exercice 1
// On cree un noeud Artist avec le nom "Matteo Vicente".
// La requete RETURN permet de verifier que le noeud a bien ete cree.
CREATE (p:Artist {primaryName: 'Matteo Vicente'})
RETURN p;

// Exercice 2
// On cree un noeud Film avec un titre precise.
// RETURN affiche le film cree pour confirmer.
CREATE (f:Film {primaryTitle: "L'histoire de mon 20 au cours Infrastructure de donnees"})
RETURN f;

// Exercice 3
// On retrouve l'artiste Matteo Vicente et le film cree (OPTIONAL MATCH evite une erreur si le film n'existe pas).
// Puis on cree une relation acted_in entre l'artiste et le film, et on affiche les deux.
MATCH (p:Artist {primaryName: 'Matteo Vicente'})
OPTIONAL MATCH (f:Film {primaryTitle: "L'histoire de mon 20 au cours Infrastructure de donnees"})
CREATE (p)-[:acted_in]->(f)
RETURN p, f;

// Exercice 4
// On cree deux artistes (les profs), puis on recupere le film.
// Ensuite on cree deux relations directed vers le meme film, et on affiche tout.
CREATE (prof1:Artist {primaryName: 'Luc Vo Van'})
CREATE (prof2:Artist {primaryName: 'Thierry Rapatout'})
WITH prof1, prof2
MATCH (f:Film {primaryTitle: "L'histoire de mon 20 au cours Infrastructure de donnees"})
CREATE (prof1)-[:directed]->(f)
CREATE (prof2)-[:directed]->(f)
RETURN prof1, prof2, f;

// Exercice 5
// On cherche l'artiste qui s'appelle "Nicole Kidman".
// Puis on retourne uniquement son annee de naissance (birthYear).
MATCH (a:Artist {primaryName: 'Nicole Kidman'})
RETURN a.birthYear;

// Exercice 6
// On selectionne tous les noeuds Film de la base.
// RETURN f affiche la liste de tous les films.
MATCH (f:Film)
RETURN f;

// Exercice 7
// On cherche tous les artistes nes en 1963.
// RETURN renvoie leurs noms (primaryName).
MATCH (a:Artist {birthYear: 1963})
RETURN a.primaryName;

// Exercice 8
// On relie chaque artiste aux films dans lesquels il a joue, puis on compte ses films.
// On garde seulement ceux qui ont joue dans plus d'un film et on affiche le nom + le total.
MATCH (a:Artist)-[:acted_in]->(f:Film)
WITH a, COUNT(f) AS nbFilms
WHERE nbFilms > 1
RETURN DISTINCT a.primaryName, nbFilms;

// Exercice 9
// On prend toutes les relations entre un artiste et un film, puis on collecte les types de relations (roles).
// Si un artiste a plus d'un role different, on affiche son nom et la liste de ses roles.
MATCH (a:Artist)-[r]->(f:Film)
WITH a, COLLECT(DISTINCT type(r)) AS roles
WHERE SIZE(roles) > 1
RETURN a.primaryName, roles;

// Exercice 10
// Pareil que l'exercice 9, mais on le fait film par film.
// On affiche donc l'artiste, le titre du film, et les roles qu'il a sur ce film.
MATCH (a:Artist)-[r]->(f:Film)
WITH a, f, COLLECT(DISTINCT type(r)) AS roles
WHERE SIZE(roles) > 1
RETURN a.primaryName, f.primaryTitle, roles;

// Exercice 11
// D'abord, on calcule le nombre d'acteurs par film, on trie, et on garde le maximum (maxActors).
// Ensuite, on refait le comptage et on retourne tous les films qui ont exactement ce maximum (cas d'egalite).
MATCH (a:Artist)-[:acted_in]->(f:Film)
WITH f, COUNT(a) AS nbActors
ORDER BY nbActors DESC
LIMIT 1
WITH nbActors AS maxActors

MATCH (a:Artist)-[:acted_in]->(f:Film)
WITH f, COUNT(a) AS nbActors, maxActors
WHERE nbActors = maxActors
RETURN f.primaryTitle, nbActors;
