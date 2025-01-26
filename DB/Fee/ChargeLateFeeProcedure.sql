CREATE PROCEDURE ChargeLateFee
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
		DECLARE @checkoutId INT, @userId INT, @borrowDate DATE, @currentDate DATE, @lateDays INT, @lateFee DECIMAL
		SET @currentDate = GETDATE();

		DECLARE checkout_cursor CURSOR FOR
		SELECT id, userId, borrowDate
		FROM checkout
		WHERE returnedDate IS NULL AND DATEDIFF(DAY, borrowDate, @currentDate) > 30;

		OPEN checkout_cursor;
		FETCH NEXT FROM checkout_cursor INTO @checkoutId, @userId, @borrowDate;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @lateDays = DATEDIFF(DAY, DATEADD(MONTH, 1, @borrowDate), @currentDate);
			SET @lateFee = 1.5 * @lateDays;

			IF NOT EXISTS (SELECT 1 FROM fee WHERE checkoutId = @checkoutId AND feeType = 2)
			BEGIN
				INSERT INTO fee (amount, checkoutId, feeType, userId, paid)
				SELECT @lateFee, @checkoutId, 2, @userId, 0;
			END
			ELSE
			BEGIN
				UPDATE fee
				SET amount = @lateFee
				WHERE checkoutId = @checkoutId;
			END

			UPDATE [user]
			SET isBlocked = 1
			WHERE id = @userId;


			FETCH NEXT FROM checkout_cursor INTO @checkoutId, @userId, @borrowDate;
		END

		CLOSE checkout_cursor;
		DEALLOCATE checkout_cursor;
		COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		THROW;
	END CATCH
END;
GO