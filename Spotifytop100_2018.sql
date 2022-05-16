--Table Check
SELECT *
FROM top2018_csv tc
ORDER BY tempo;

SELECT name, artists, danceability, energy, tempo
FROM top2018_csv tc
ORDER BY tempo;

SELECT name, artists, danceability, energy, tempo
FROM top2018_csv tc
ORDER BY energy;

--Count how many artists in top 100 in 2018
SELECT COUNT (DISTINCT artists) AS total_artists
FROM top2018_csv tc;

--GROUP BY artists to count total songs in 2018 per artist
SELECT name, artists, COUNT(artists) as total_songs_per_artist
FROM top2018_csv tc 
GROUP BY artists
ORDER BY 3 DESC;

--XXXTENTACION, Post Malone, Drake have most songs in top 100 in 2018

--total artists with "Lil" in name
SELECT name, artists, COUNT(*) as total_songs
FROM top2018_csv tc 
WHERE artists LIKE 'Lil%'
GROUP BY artists 
ORDER BY 3 DESC

--Total Artists with "DJ" in name
SELECT name, artists, COUNT(artists) as total_songs
FROM top2018_csv tc 
WHERE artists LIKE 'DJ%'
GROUP BY artists 
ORDER BY 3 DESC

-- According to results in prior 2 queries, more artists have "Lil" than "DJ" in top 100


-- Query a table to gather every average, Order by total_songs in descending order to discover pattern with artists with most songs in Spotify top 100
SELECT artists,
AVG(danceability) as avg_danceability, 
AVG(energy) as avg_energy,
AVG(loudness) as avg_loudness,
AVG(liveness) as avg_liveness,
AVG(valence) as avg_valence, 
COUNT(artists) as total_songs
FROM top2018_csv tc
GROUP BY artists
ORDER BY 7 DESC;

SELECT artists,
AVG(danceability) as avg_danceability, 
AVG(energy) as avg_energy,
AVG(loudness) as avg_loudness,
AVG(liveness) as avg_liveness,
AVG(valence) as avg_valence, 
COUNT(artists) as total_songs
FROM top2018_csv tc
GROUP BY artists
ORDER BY 7 DESC
LIMIT 25;

-- discover relationship between top danceability with energy and valence
SELECT name, artists, 
MAX(danceability) as top_danceability,
energy,
valence 
FROM top2018_csv tc 
GROUP BY name
ORDER BY 3 DESC
LIMIT 10;




