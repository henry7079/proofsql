SELECT * FROM Employee WHERE DAY(birthday) % 2 = 1; 

ALTER PROCEDURE sp_date
	@typeDay int
AS
BEGIN
	IF(@typeDay = 0 OR @typeDay = 1)
		BEGIN
			SELECT * FROM Employee WHERE DAY(birthday) % 2 = @typeDay AND DATEDIFF(DAY, '1997-01-01', birthday) >= 3;
		END
	ELSE
		BEGIN
			SELECT 'Error: happened an error' AS error;
		END
END

EXEC sp_date 0;