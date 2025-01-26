CREATE PROCEDURE GetBookInventoryReport
AS
BEGIN
    SELECT 
        UPPER(a.lastName) + ', ' + a.firstName AS author, 
        b.title, 
        b.ISBN,
        b.genre,
        b.publishedYear,
        (SELECT COUNT(*) FROM bookCopy bc WHERE bc.book_id = b.id) AS total,
        (SELECT COUNT(*) FROM bookCopy bc WHERE bc.book_id = b.id AND bc.availability = 1) AS totalAvailable,
        (SELECT COUNT(*) FROM bookCopy bc WHERE bc.book_id = b.id AND bc.availability = 2) AS totalBorrowed,
        (SELECT COUNT(*) FROM bookCopy bc WHERE bc.book_id = b.id AND bc.availability = 3) AS totalSold
    FROM [book] b 
    JOIN [bookAuthor] ba 
        ON ba.book_id = b.id 
    JOIN [author] a 
        ON ba.author_id = a.id
    ORDER BY totalAvailable DESC;
END;
GO