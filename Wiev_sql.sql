CREATE DATABASE ENDSQL

USE ENDSQL

CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50),
    Surname NVARCHAR(50),
    Username NVARCHAR(50) UNIQUE,
    Password NVARCHAR(50),
    Gender NVARCHAR(10)
);

CREATE TABLE Artists (
    ArtistId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50),
    Surname NVARCHAR(50),
    Birthday DATE,
    Gender NVARCHAR(10)
);

CREATE TABLE Categories (
    CategoryId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50)
);

CREATE TABLE Musics (
    MusicId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100),
    Duration INT,
    CategoryId INT,
    ArtistId INT,
    FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId),
    FOREIGN KEY (ArtistId) REFERENCES Artists(ArtistId)
);

CREATE VIEW vw_MusicDetails
AS
SELECT 
    M.MusicId,
    M.Name AS MusicName,
    M.Duration,
    C.Name AS Category,
    A.Name + ' ' + A.Surname AS Artist
FROM Musics M
JOIN Categories C ON M.CategoryId = C.CategoryId
JOIN Artists A ON M.ArtistId = A.ArtistId;

CREATE PROCEDURE usp_CreateMusic
    @Name NVARCHAR(100),
    @Duration INT,
    @CategoryId INT,
    @ArtistId INT
AS
BEGIN
    INSERT INTO Musics (Name, Duration, CategoryId, ArtistId)
    VALUES (@Name, @Duration, @CategoryId, @ArtistId);
END

EXEC usp_CreateMusic 
    @Name = 'Ürəyim', 
    @Duration = 220, 
    @CategoryId = 1, 
    @ArtistId = 2;

	CREATE PROCEDURE usp_CreateUser
    @Name NVARCHAR(50),
    @Surname NVARCHAR(50),
    @Username NVARCHAR(50),
    @Password NVARCHAR(50),
    @Gender NVARCHAR(10)
AS
BEGIN
    INSERT INTO Users (Name, Surname, Username, Password, Gender)
    VALUES (@Name, @Surname, @Username, @Password, @Gender);
END

EXEC usp_CreateUser 
    @Name = 'Elvin', 
    @Surname = 'Quliyev', 
    @Username = 'elvin123', 
    @Password = 'sifre123', 
    @Gender = 'Kisi';

CREATE PROCEDURE usp_CreateCategory
    @Name NVARCHAR(50)
AS
BEGIN
    INSERT INTO Categories (Name)
    VALUES (@Name);
END


EXEC usp_CreateCategory 
    @Name = 'Elektron';

CREATE FUNCTION fn_GetUserArtistCount (@UserId INT)
RETURNS INT
AS
BEGIN
    DECLARE @Count INT;
    SELECT @Count = COUNT(DISTINCT M.ArtistId)
    FROM Playlist P
    JOIN Musics M ON P.MusicId = M.MusicId
    WHERE P.UserId = @UserId;

    RETURN @Count;
END

CREATE PROCEDURE usp_GetUserPlaylist
    @UserId INT
AS
BEGIN
    SELECT M.MusicId, M.Name, M.Duration
    FROM Playlist P
    JOIN Musics M ON P.MusicId = M.MusicId
    WHERE P.UserId = @UserId;
END

SELECT * FROM Musics
ORDER BY Duration ASC;


SELECT * FROM Musics
ORDER BY Duration DESC;

SELECT A.ArtistId, A.Name + ' ' + A.Surname AS ArtistName, COUNT(M.MusicId) AS MusicCount
FROM Artists A
JOIN Musics M ON A.ArtistId = M.ArtistId
GROUP BY A.ArtistId, A.Name, A.Surname
HAVING COUNT(M.MusicId) = (
    SELECT MAX(MusicCount)
    FROM (
        SELECT COUNT(MusicId) AS MusicCount
        FROM Musics
        GROUP BY ArtistId
    ) AS ArtistCounts
);



SELECT * FROM Users 
SELECT * FROM Artists 
SELECT * FROM Categories
SELECT * FROM Musics
SELECT * FROM vw_MusicDetails



