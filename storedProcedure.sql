SELECT LOWER(LEFT(name, 1)) + UPPER(SUBSTRING(name, 2, LEN(name))) FROM Employee WHERE id = @destinationEmployee;
SELECT DATEDIFF(YEAR, '1997-01-18', CURRENT_TIMESTAMP) FROM Sale_order;


ALTER PROCEDURE spChangeEmployee
	@employeeId int
AS
BEGIN
	DECLARE @destinationEmployee int;
	
	IF(SELECT COUNT(*) FROM Employee WHERE id = @employeeId) = 0
		BEGIN
			SELECT 'Error: employee does not exist' AS Error;
		END
	ELSE
		BEGIN
			SET @destinationEmployee = (SELECT TOP(1) id FROM Employee WHERE id <> @employeeId ORDER BY name DESC);

			UPDATE Customer SET employeeId = @destinationEmployee WHERE employeeId = @employeeId;
			DELETE Employee WHERE id = @employeeId;

			SELECT * FROM Customer;
		END

END
GO

EXEC spChangeEmployee 1;

CREATE TABLE Employee(
	id int PRIMARY KEY IDENTITY,
	name VARCHAR(50) NOT NULL
);

INSERT INTO Employee(name) VALUES('Juan');
INSERT INTO Employee(name) VALUES('Mauricio');
INSERT INTO Employee(name) VALUES('Jorge');
INSERT INTO Employee(name) VALUES('Jenifer');
INSERT INTO Employee(name) VALUES('Vanessa');
SELECT * FROM Employee;

CREATE TABLE Customer(
	id INT PRIMARY KEY IDENTITY,
	name VARCHAR(50) NOT NULL,
	lastName VARCHAR(50) NOT NULL,
	employeeId INT,
	
	FOREIGN KEY (employeeId) REFERENCES Employee(id)
);

INSERT INTO Customer(name, lastName, employeeId) VALUES('henry', 'zamora', 1);
INSERT INTO Customer(name, lastName, employeeId) VALUES('roxana', 'hernandez', 1);
INSERT INTO Customer(name, lastName, employeeId) VALUES('Manuel', 'Lopez', 1);

UPDATE Customer SET employeeId = (SELECT TOP(1) id FROM Employee ORDER BY name DESC) WHERE id = 2;
SELECT * FROM Customer;
SELECT CONCAT(name, ' ', lastName) AS fullName FROM Customer;

ALTER TABLE Employee ADD birthday DATE; 

SELECT DATEDIFF(DAY, birthday, GETDATE()) FROM Employee;

SELECT GETDATE();




ALTER PROCEDURE spAddBirthday
AS
BEGIN
	DECLARE @day int = (SELECT TOP(1) id FROM Employee);
	DECLARE @countEmployee int = (SELECT COUNT(*) FROM Employee);
	
	WHILE @day <= @countEmployee
		BEGIN
			UPDATE Employee SET birthday = CONCAT('1997-01-0', @day) WHERE id = @day;
			SET @day = @day + 1;
		END

	SELECT * FROM Employee;
END
GO

EXEC spAddBirthday