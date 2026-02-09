CREATE TABLE [dbo].[T112_Product] (
    [ProductID]       INT          NOT NULL,
    [ProductName]     VARCHAR (50) NOT NULL,
    [SupplierID]      INT          NOT NULL,
    [CategoryID]      INT          NOT NULL,
    [QuantityPerUnit] INT          CONSTRAINT [DEFAULT_T112_Product_QuantityPerUnit] DEFAULT ((0)) NOT NULL,
    [UnitPrice]       INT          NOT NULL,
    [UnitsInStock]    INT          CONSTRAINT [DEFAULT_T112_Product_UnitsInStock] DEFAULT ((0)) NOT NULL,
    [UnitsOnOrder]    INT          NOT NULL,
    [ReorderLevel]    INT          NOT NULL,
    [Discontinued]    INT          NOT NULL,
    CONSTRAINT [PK_T112_Product] PRIMARY KEY CLUSTERED ([ProductID] ASC)
);


INSERT INTO dbo.T112_Product 
VALUES (4,'mouse',5,2,25,10,65,10,11,0) , 
(5,'bottle',3,7,22,5.45,10,20,55,1) ,
(6,'headphone',2,3,5,11.33,140,88,42,0);


-- Assignment 1 
1. 
SELECT ProductID,ProductName,UnitPrice from dbo.T112_Product where UnitPrice / QuantityPerUnit < 20;