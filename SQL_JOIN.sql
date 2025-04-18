USE BB209

CREATE TABLE Categories (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50)
);

CREATE TABLE Products (
    Id INT PRIMARY KEY,
    Name NVARCHAR(25),
    Price DECIMAL(10,2),
    Cost DECIMAL(10,2),
    CategoryId INT,
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id)
);

CREATE TABLE Colors (
    Id INT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE ProductColors (
    ProductId INT,
    ColorId INT,
    PRIMARY KEY (ProductId, ColorId),
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (ColorId) REFERENCES Colors(Id)
);

SELECT 
    p.Name AS ProductName,
    p.Price,
    p.Cost,
    c.Name AS "Category Name",
    clr.Name AS "Color Name"
FROM Products p
JOIN Categories c ON p.CategoryId = c.Id
LEFT JOIN ProductColors pc ON p.Id = pc.ProductId
LEFT JOIN Colors clr ON pc.ColorId = clr.Id;






