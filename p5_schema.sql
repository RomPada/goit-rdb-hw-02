-- goit-rdb-hw-02 / p5_schema.sql
-- MySQL 8.0+ | Schema of 3NF tables from "p. 2 - 4.xlsx".
-- Structural DDL only: no INSERT statements or sample rows.

CREATE SCHEMA IF NOT EXISTS `goit_rdb_hw_02`
  DEFAULT CHARACTER SET utf8;
USE `goit_rdb_hw_02`;

-- 3NF table "Продукт" (Product_ID, Product_Name)
CREATE TABLE IF NOT EXISTS `products` (
    `id_product` INT NOT NULL AUTO_INCREMENT,
    `product_name` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id_product`)
) ENGINE = InnoDB;

-- 3NF table "Клієнт" (Client_ID, Client_Last_Name, Client_Address)
CREATE TABLE IF NOT EXISTS `clients` (
    `id_client` INT NOT NULL AUTO_INCREMENT,
    `client_name` VARCHAR(45) NOT NULL,
    `client_address` VARCHAR(225) NOT NULL,
    PRIMARY KEY (`id_client`)
) ENGINE = InnoDB;

-- 3NF table "Замовлення данні" (Order_ID, Client_ID, Order_Date)
CREATE TABLE IF NOT EXISTS `orders` (
    `id_order` INT NOT NULL AUTO_INCREMENT,
    `id_client` INT NOT NULL,
    `order_date` DATE NOT NULL,
    PRIMARY KEY (`id_order`),
    INDEX `client-order_idx` (`id_client` ASC),
    CONSTRAINT `client-order`
        FOREIGN KEY (`id_client`)
        REFERENCES `clients` (`id_client`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- 3NF table "Замовлений товар" (Order_ID, Product_ID, Quantity)
-- The compound PK prevents duplicate product rows within one order.
CREATE TABLE IF NOT EXISTS `ordered_products` (
    `id_order` INT NOT NULL,
    `id_product` INT NOT NULL,
    `product_quantity` INT NOT NULL,
    PRIMARY KEY (`id_order`, `id_product`),
    INDEX `product-ordered_products_idx` (`id_product` ASC),
    CONSTRAINT `order-ordered_products`
        FOREIGN KEY (`id_order`)
        REFERENCES `orders` (`id_order`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `product-ordered_products`
        FOREIGN KEY (`id_product`)
        REFERENCES `products` (`id_product`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;
