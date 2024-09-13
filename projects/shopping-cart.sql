CREATE TABLE ProductsMenu (
    Id INT PRIMARY KEY,         
    Name VARCHAR(100),          
    Price DECIMAL(10, 2)        
);

CREATE TABLE Cart (
    ProductId INT,             
    Qty INT,                   
    FOREIGN KEY (ProductId) REFERENCES ProductsMenu(Id), 
    PRIMARY KEY (ProductId)    
);

CREATE TABLE Users (
    User_ID INT PRIMARY KEY,    
    Username VARCHAR(100)       
);

CREATE TABLE OrderHeader (
    OrderID SERIAL PRIMARY KEY,   
    UserID INT,
    OrderDate TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(User_ID)
);

CREATE TABLE OrderDetails (
    OrderHeader INT,           
    ProdID INT,                 
    Qty INT,                    
    FOREIGN KEY (OrderHeader) REFERENCES OrderHeader(OrderID), 
    FOREIGN KEY (ProdID) REFERENCES ProductsMenu(Id),          
    PRIMARY KEY (OrderHeader, ProdID)  
);

INSERT INTO ProductsMenu (Id, Name, Price) VALUES
(1, 'Coke', 10.00),
(2, 'Chips', 5.00),
(3, 'Bread', 15.00),
(4, 'Milk', 12.50);

INSERT INTO Users (User_ID, Username) VALUES
(1, 'Dan'),
(2, 'David'),
(3, 'Michael');

SELECT * FROM ProductsMenu;

SELECT Qty,Name FROM Cart
INNER JOIN ProductsMenu ON Cart.ProductId = ProductsMenu.Id;

-- places items into cart
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 1) THEN
        UPDATE Cart
        SET Qty = Qty + 1
        WHERE ProductId = 1;
    ELSE
        INSERT INTO Cart (ProductId, Qty)
        VALUES (1, 1);
    END IF;
END $$;

-- deletes items from cart
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM Cart WHERE ProductId = 2 AND Qty > 1) THEN
        UPDATE Cart
        SET Qty = Qty - 1
        WHERE ProductId = 2;
    ELSE
        DELETE FROM Cart
        WHERE ProductId = 2;
    END IF;
END $$;

-- adds items to checkout then clears cart
DO $$
DECLARE
    newOrderID INT;
BEGIN
    INSERT INTO OrderHeader (UserID, OrderDate)
    VALUES (1, NOW())  
    RETURNING OrderID INTO newOrderID;

    INSERT INTO OrderDetails (OrderHeader, ProdID, Qty)
    SELECT newOrderID, ProductId, Qty FROM Cart;

    DELETE FROM Cart;
END $$;

-- shows active orders
SELECT oh.OrderID, oh.OrderDate, u.Username, p.Name, od.Qty
FROM OrderHeader oh
INNER JOIN Users u ON oh.UserID = u.User_ID
INNER JOIN OrderDetails od ON oh.OrderID = od.OrderHeader
INNER JOIN ProductsMenu p ON od.ProdID = p.Id;