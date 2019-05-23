select count(*) from Artist;
select count(*) from Track;

/*
Select every track name and the track's associated media type
*/
SELECT Track.Name, MediaType.Name FROM Track 
INNER JOIN MediaType on Track.MediaTypeId = MediaType.MediaTypeId;

/*
Select every track name and the track's associated genre, where the
name of the genre is "Jazz"
*/
SELECT Track.Name, Genre.Name FROM Track
INNER JOIN Genre on Track.GenreId = Genre.GenreId
WHERE Genre.Name = 'Jazz';

/*
Select every track name and the track's associated media type
and genre, where the name of the mdeia type is 
"Protected AAC audio file" and the genre is "Soundtrack"
*/
SELECT Track.Name, MediaType.Name, Genre.Name FROM Track
INNER JOIN MediaType on Track.MediaTypeId = MediaType.MediaTypeId
INNER JOIN Genre on Track.GenreId = Genre.GenreId
WHERE MediaType.Name = 'Protected AAC audio file' AND Genre.Name = 'Soundtrack';

/* 
Filter to only show results for the 'grunge' playlist
*/
SELECT Playlist.Name AS Playlist, Track.Name AS Track, Album.Title AS Album, Artist.Name AS Artist FROM Playlist
INNER JOIN PlaylistTrack ON Playlist.PlaylistId = PlaylistTrack.PlaylistId
JOIN Track ON PlaylistTrack.TrackId = Track.TrackId
JOIN Album ON Track.AlbumId = Album.AlbumId
JOIN Artist on Album.ArtistId = Artist.ArtistId
WHERE Playlist.Name = 'Grunge';

/*
Find a playlist that contains only 1 track.
*/
SELECT Playlist.Name as Playlist, COUNT(*) FROM Playlist 
INNER JOIN PlaylistTrack on Playlist.PlaylistId = PlaylistTrack.PlaylistId
GROUP BY Playlist HAVING COUNT(*) =1;

/*
Select the InvoiceDate, BillingAddress, and Total from the Invoices table, 
Ordered by InvoiceDate Descending
*/
SELECT InvoiceDate as Date, BillingAddress as Address, Total as Total
FROM Invoice ORDER BY InvoiceDate desc;

/*
Select the EmployeeId, LastName, FirstName and HireDate of the 3 Employees 
with the most recent HireDate
*/
SELECT EmployeeId, LastName, FirstName, HireDate FROM Employee
ORDER BY HireDate DESC LIMIT 3;

/*
Disaster, we've heard from Steve Johnson's lawyers.
He claims that Michael Mitchell was hired on the same day as him, but was hired later in the day. Mitchell should have been let go, not him.
Confirm this by extending the number of results and make sure nobody else was hired on that day.
Then modify the query to return the correct 3 people.
Continue to use HireDate as the primary sort column, but use EmployeeId as the tie breaker.
Assume that a higher EmployeeId means they were hired later.
*/
SELECT EmployeeId, FirstName, LastName, HireDate FROM Employee 
ORDER BY HireDate desc, EmployeeId desc LIMIT 3;

/*
Create a query that shows our 10 biggest invoices by Total value, in descending order.
If two invoices have the same Total, the more recent should appear first.
The query should also show the Name of the Customer
*/
SELECT 
    concat(Customer.FirstName, " ", Customer.LastName) as Name,
    Invoice.InvoiceDate as Date,
    Invoice.Total
FROM Invoice
INNER JOIN Customer ON Invoice.CustomerId = Customer.CustomerId
ORDER BY Total DESC, InvoiceDate DESC
LIMIT 10;

/*
How Many Customers is Employee 4 the Sales Support Agent For?
*/
SELECT COUNT(FirstName) FROM Customer WHERE SupportRepId = 4;

/*
How many customers had Jane Peacock as their Sales Support Rep?
*/
SELECT Employee.FirstName AS Employee, COUNT(Customer.FirstName) AS Customer FROM Employee
JOIN Customer ON Customer.SupportRepId = Employee.EmployeeId
WHERE Employee.FirstName = 'Jane';

/*
Which Media Type is most popular? How could you answer this with a single query?
*/
SELECT MediaType.Name as MediaType, COUNT(Track.MediaTypeId) as Amount FROM Track
JOIN MediaType ON MediaType.MediaTypeId = Track.MediaTypeid
WHERE MediaType.Name = "MPEG audio file";

/*
What is the date of birth of our oldest employee?
*/
SELECT MIN(BirthDate) FROM Employee;

/*
On what date was our most recent employee hired?
*/
SELECT MAX(HireDate) FROM Employee;

/*
How many customers do we have in the City of Berlin Expected : 2
*/
SELECT COUNT(City) FROM Customer WHERE City = "Berlin";

/*
How much has been made in sales for the track "The Woman King". 
*/
SELECT SUM(InvoiceLine.UnitPrice * InvoiceLine.Quantity), Track.Name AS Track FROM InvoiceLine
JOIN Track ON InvoiceLine.TrackId = Track.TrackId
WHERE Track.Name = "The Woman King";

/*
Create a list of the top 5 acts by number of tracks. The table should include the 
name of the artist and the number of tracks they have.
*/
SELECT Artist.Name AS Artist, COUNT(Track.TrackId) AS Track FROM Artist
JOIN Album ON Artist.ArtistId = Album.ArtistId
JOIN Track ON Album.AlbumId = Track.AlbumId
GROUP BY Artist.Name
ORDER BY COUNT(Artist.Name)
DESC LIMIT 5;

/*
Insert the remaining Tracks for the Album Boy (except for the last 2-3, insert those as part of Challenge Three)
*/
INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES ("I Will Follow", 348, 2, 1, "U2", 220000, 1234, 0.99);
INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES ("Twillight", 348, 2, 1, "U2", 260000, 1235, 0.99);
INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES ("An Cath Dubh", 348, 2, 1, "U2", 268000, 1244, 0.99);
INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES ("Into The Heart", 348, 2, 1, "U2", 217000, 1134, 0.99);
INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES ("Out of Control", 348, 2, 1, "U2", 230000, 1238, 0.99);
INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES ("Stories for Boys", 348, 2, 1, "U2", 233000, 1334, 0.99);
INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES ("The Ocean", 348, 2, 1, "U2", 200000, 1132, 0.99);

/*
Use one insert statement to insert multiple tracks at the same time
*/
INSERT INTO Track (Name, AlbumId, MediaTypeId, GenreId, Composer, Milliseconds, Bytes, UnitPrice)
VALUES
    ("Another Time, Another Place", 348, 2, 1, "U2", 210000, 1234, 0.99),
    ("The Electric Co.", 348, 2, 1, "U2", 200000, 1234, 0.99),
    ("Shadows and Tall Trees", 348, 2, 1, "U2", 150000, 1234, 0.99);