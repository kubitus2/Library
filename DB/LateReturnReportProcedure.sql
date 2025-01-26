CREATE PROCEDURE GetOverdueBookInfo
AS
BEGIN
    SELECT 	
        c.id, 
        b.title,
		bc.id AS bookCopyID,
        c.borrowDate,
        UPPER(u.lastName) + ', ' + u.firstName AS userName,
        u.email,
        u.phone,
		c.borrowDate,
        DATEDIFF(DAY, c.borrowDate, GETDATE()) AS daysSinceBorrowed,
		DATEDIFF(DAY, DATEADD(MONTH, 1, c.borrowDate), GETDATE()) AS daysLate,
        DATEDIFF(DAY, DATEADD(MONTH, 1, c.borrowDate), GETDATE()) * 1.5 AS overdueFee
    FROM checkout c
    JOIN bookCopy bc 
        ON bc.id = c.bookCopyId
    JOIN book b 
        ON bc.book_id = b.id
    JOIN [user] u 
        ON u.id = c.userId
    WHERE c.returnedDate IS NULL
    AND DATEDIFF(DAY, c.borrowDate, GETDATE()) > 30
    ORDER BY daysSinceBorrowed DESC;
END;
