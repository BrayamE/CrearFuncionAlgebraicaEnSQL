--BRAYAM EDWIN QUISPE APAZA
CREATE DATABASE Tienda3
USE Tienda3

CREATE TABLE Personas (
    PersonaID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    ApellidoPaterno NVARCHAR(100) NOT NULL,
    ApellidoMaterno NVARCHAR(100) NOT NULL,
    FechaNacimiento DATE,
    Direccion NVARCHAR(255),
    Email NVARCHAR(255) UNIQUE,
    Telefono NVARCHAR(20)
);

INSERT INTO Personas ( Nombre, ApellidoPaterno, ApellidoMaterno,FechaNacimiento,Direccion, Email, Telefono)
VALUES
    ('Juan', 'Pérez','Vasquez','1992/12/07', 'Calle 123, Ciudad A', 'juan@email.com', '123-456-7890'),
    ('Ana', 'García','Perez','1994/10/02', 'Avenida XYZ, Ciudad B', 'ana123@email.com', '987-654-3210'),
    ('Carlos', 'López','Rolando','2003/03/15', 'Calle 456, Ciudad A', 'carlosFgaa@email.com', '955-555-5555'),
    ('Laura', 'Rodríguez','Quispe','1999/08/29', 'Avenida ABC, Ciudad C', 'laura@email.com', '911-222-3333'),
    ('Pedro', 'Sánchez','Apaza','1992/09/14', 'Calle 789, Ciudad B', 'pedro@email.com', '977-888-0999'),
	('María', 'López', 'Martínez', '1990/03/22', 'Avenida 123, Ciudad C', 'maria@email.com', '555-666-7777'),
	('Juan', 'Gómez', 'García', '1989/11/07', 'Calle 456, Ciudad D', 'juanito@email.com', '911-222-3333'),
	('Laura', 'Hernández', 'Rodríguez', '1982/06/30', 'Plaza 789, Ciudad E', 'laura123@email.com', '999-888-7777'),
	('Carlos', 'Pérez', 'Gómez', '1994/08/18', 'Ronda 012, Ciudad F', 'carlos@email.com', '944-555-2236'),
	('Sofía', 'González', 'Gutiérrez', '1993/02/14', 'Bulevar 345, Ciudad G', 'sofia@email.com', '123-222-1111'),
	('Diego', 'Rodríguez', 'Gómez', '1998/09/29', 'Avenida 678, Ciudad H', 'diego@email.com', '222-333-3244'),
	('Ana', 'Martínez', 'López', '1993/05/11', 'Callejón 901, Ciudad I', 'ana@email.com', '966-555-1544'),
	('Javier', 'Gómez', 'Hernández', '1980/12/04', 'Plaza 234, Ciudad J', 'javier@email.com', '777-666-5555'),
	('Elena', 'Gutiérrez', 'Pérez', '1994/10/26', 'Bulevar 567, Ciudad K', 'elen12a@email.com', '988-999-0110'),
	('Miguel', 'Hernández', 'González', '1998/07/19', 'Ronda 890, Ciudad L', 'miguel@email.com', '999-000-1111'),
	('Luis', 'Gómez', 'Martínez', '2000/04/02', 'Calle 123, Ciudad M', 'luisAQ@email.com', '900-411-2222'),
	('Lucía', 'Pérez', 'Gómez', '2003/01/15', 'Avenida 456, Ciudad N', 'lucia@email.com', '911-222-9933'),
	('Pablo', 'Rodríguez', 'Martínez', '2000/06/28', 'Plaza 789, Ciudad O', 'pabloITO@email.com', '922-333-4754'),
	('Laura', 'López', 'Hernández', '1976/03/10', 'Bulevar 012, Ciudad P', 'ABClaura@email.com', '933-444-5555'),
	('Santiago', 'Gómez', 'Pérez', '1982/08/23', 'Callejón 345, Ciudad Q', 'santiagoZZ@email.com', '944-555-6606');

--Funcion para hallar la edad

select * from Personas
CREATE FUNCTION dbo.HallarEdad (@PersonaID INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @Edad INT;
    DECLARE @Resultado NVARCHAR(100);
    
    SELECT @Edad = DATEDIFF(YEAR, FechaNacimiento, GETDATE())
    FROM Personas
    WHERE PersonaID = @PersonaID;
    
    SET @Resultado = CAST(@Edad AS NVARCHAR(10)) + ' AÑOS DE EDAD';
    
    RETURN @Resultado;
END;

SELECT dbo.HallarEdad(2);


--Funcion para Llamar los Nombres y Apellidos

CREATE FUNCTION dbo.NombresApellidoss (@PersonaID INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @Nombre NVARCHAR(100);
    DECLARE @ApellidoPaterno NVARCHAR(100);
    DECLARE @ApellidoMaterno NVARCHAR(100);
    DECLARE @Resultado NVARCHAR(100);
    
    SELECT @Nombre = UPPER(LEFT(Nombre, 1)) + LOWER(SUBSTRING(Nombre, 2, LEN(Nombre))),
           @ApellidoPaterno = ApellidoPaterno,
           @ApellidoMaterno = ApellidoMaterno
    FROM Personas
    WHERE PersonaID = @PersonaID;
    
    SET @Resultado = @Nombre + ' ' + @ApellidoPaterno + ' ' + @ApellidoMaterno;
    
    RETURN @Resultado;
END;
SELECT dbo.NombresApellidoss(2);


-- Crear Funciones Algebraicas
CREATE FUNCTION RealizarOperacionAlgebraicas12356
(
    @ValorA DECIMAL (18,2),
    @ValorB DECIMAL (18,2),
    @TipoOperacion int,  -- 1=Suma, 2=Resta, 3=Multiplicacion, 4=Division, 5=(Nombre-Edad)
    @PersonaID INT
)
RETURNS NVARCHAR(255)
AS
BEGIN
    DECLARE @Resultado NVARCHAR(100);
	DECLARE @NombreEdad NVARCHAR(100);

    IF @TipoOperacion = 1 -- Suma
    BEGIN
        SET @Resultado = @ValorA + @ValorB;
    END
    ELSE IF @TipoOperacion = 2 -- Resta
    BEGIN
        SET @Resultado = @ValorA - @ValorB;
    END
    ELSE IF @TipoOperacion = 3 -- Multiplicación
    BEGIN
        SET @Resultado = @ValorA * @ValorB;
    END
    ELSE IF @TipoOperacion = 4 -- División
    BEGIN
        IF @ValorB = 0
        BEGIN
 
            SET @Resultado = NULL;
        END
        ELSE
        BEGIN
            SET @Resultado = @ValorA / @ValorB;
        END
    END
    ELSE IF @TipoOperacion = 5 -- (Nombre-Edad)
    BEGIN
        SELECT @NombreEdad = dbo.NombresApellidoss(@PersonaID) + ' ' + dbo.HallarEdad(@PersonaID);
        
        IF @NombreEdad IS NOT NULL
        BEGIN
            SET @Resultado = @NombreEdad;
        END
    END
    ELSE
    BEGIN
        SET @Resultado = NULL;
    END;

    RETURN CAST(@Resultado AS NVARCHAR(255));
END;
SELECT dbo.RealizarOperacionAlgebraicas12356(20,20,5,10);

