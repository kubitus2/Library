CREATE PROCEDURE GetGenreSalesSummary
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    BEGIN TRY
        SELECT 
            b.genre,
            COUNT(bc.id) AS soldCopies,
            SUM(b.price) AS totalRevenue
        FROM bookCopy bc
        JOIN orderDetails od 
            ON bc.id = od.bookCopyId
        JOIN book b 
            ON b.id = bc.book_id
        JOIN [order] o
            ON od.orderId = o.id
        WHERE o.orderDate BETWEEN @StartDate AND @EndDate
        GROUP BY b.genre
        ORDER BY totalRevenue DESC;
    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT;
        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        -- Raise the error to the caller
        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
