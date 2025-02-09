-- CreateTable
CREATE TABLE `customers` (
    `customer_id` INTEGER NOT NULL AUTO_INCREMENT,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) NULL,
    `address` VARCHAR(255) NULL,
    `phone_number` VARCHAR(20) NULL,

    UNIQUE INDEX `customers_email_key`(`email`),
    PRIMARY KEY (`customer_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orderdetail` (
    `order_id` INTEGER NOT NULL,
    `product_id` INTEGER NOT NULL,
    `quantity` INTEGER NOT NULL,
    `unit_price` DECIMAL(10, 2) NOT NULL,

    INDEX `product_id`(`product_id`),
    PRIMARY KEY (`order_id`, `product_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `orders` (
    `order_id` INTEGER NOT NULL,
    `customer_id` INTEGER NOT NULL,
    `order_date` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `order_status` ENUM('processing', 'completed', 'cancelled') NULL,
    `total_amount` DECIMAL(10, 2) NOT NULL,

    INDEX `customer_id`(`customer_id`),
    PRIMARY KEY (`order_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payments` (
    `payment_id` INTEGER NOT NULL AUTO_INCREMENT,
    `order_id` INTEGER NOT NULL,
    `payment_method` VARCHAR(50) NULL,
    `payment_date` DATETIME(0) NULL,
    `amount` DECIMAL(10, 2) NOT NULL,
    `remark` VARCHAR(255) NULL,
    `payment_status` ENUM('pending', 'completed', 'failed') NULL,

    INDEX `order_id`(`order_id`),
    PRIMARY KEY (`payment_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `products` (
    `product_id` INTEGER NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT NULL,
    `price` DECIMAL(10, 2) NOT NULL,
    `category` VARCHAR(50) NULL,
    `image_url` VARCHAR(255) NULL,

    PRIMARY KEY (`product_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `UserName` VARCHAR(100) NOT NULL,
    `UserID` INTEGER NOT NULL AUTO_INCREMENT,
    `Password` VARCHAR(100) NOT NULL,
    `Status` VARCHAR(100) NULL,
    `Role` VARCHAR(100) NULL,

    UNIQUE INDEX `Users_UNIQUE`(`UserName`),
    PRIMARY KEY (`UserID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
