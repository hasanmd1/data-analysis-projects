

CREATE TABLE `olist_customers_dataset` (
    `customer_id` varchar(50)  NOT NULL ,
    `customer_unique_id` varchar(50)  NOT NULL ,
    `customer_zip_code_prefix` int  NULL ,
    `customer_city` varchar(50) NULL ,
    `customer_state` varchar(5) NULL ,
    PRIMARY KEY (
        `customer_id`
    )
);

CREATE TABLE `olist_geolocation_dataset` (
    `geolocation_id` int AUTO_INCREMENT PRIMARY KEY,
    `geolocation_zip_code_prefix` int NOT NULL,
    `geolocation_lat` DECIMAL(10,2) NULL,
    `geolocation_lng` DECIMAL(10,2) NULL,
    `geolocation_city` varchar(50) NULL,
    `geolocation_state` varchar(5) NULL,
    INDEX `idx_geolocation_zip_code_prefix` (`geolocation_zip_code_prefix`)
);


CREATE TABLE `olist_order_items_dataset` (
	`order_items_unique_id` int auto_increment NOT NULL PRIMARY KEY ,
    `order_id` varchar(50)  NOT NULL ,
    `order_item_id` int  NOT NULL ,
    `product_id` varchar(50)  NOT NULL ,
    `seller_id` varchar(50)  NOT NULL ,
    `shipping_limit_date` DATETIME  NULL ,
    `price` double  NOT NULL ,
    `freight_value` double  NOT NULL 
);

CREATE TABLE `olist_order_payments_dataset` (
    `order_id` varchar(50)  NOT NULL ,
    `payment_sequential` int  NOT NULL ,
    `payment_type` varchar(30)  NOT NULL ,
    `payment_installments` int  NOT NULL ,
    `payment_value` double  NOT NULL 
);

CREATE TABLE `olist_order_reviews_dataset` (
	`order_review_id` int auto_increment primary key,
    `review_id` varchar(50)  NOT NULL ,
    `order_id` varchar(50)  NOT NULL ,
    `review_score` int NULL ,
    `review_comment_title` varchar(250)  NULL ,
    `review_comment_message` varchar(1000)  NULL ,
    `review_creation_date` DATETIME  NULL ,
    `review_answer_timestamp` DATETIME  NULL 
);

CREATE TABLE `olist_orders_dataset` (
    `order_id` varchar(50)  NOT NULL ,
    `customer_id` varchar(50)  NOT NULL ,
    `order_status` varchar(40) NULL ,
    `order_purchase_timestamp` varchar(50) NULL DEFAULT NULL ,
    `order_approved_at` varchar(50) NULL DEFAULT NULL ,
    `order_delivered_carrier_date` varchar(50) NULL DEFAULT NULL ,
    `order_delivered_customer_date` varchar(50) NULL DEFAULT NULL ,
    `order_estimated_delivery_date` varchar(50) NULL DEFAULT NULL ,
    PRIMARY KEY (
        `order_id`
    )
);


CREATE TABLE `olist_products_dataset` (
    `product_id` varchar(50)  NOT NULL ,
    `product_category_name` varchar(200) NULL DEFAULT 'default_category',
    `product_name_length` varchar(10) DEFAULT NULL ,
    `product_description_length` varchar(10) DEFAULT NULL ,
    `product_photos_qty` varchar(10) DEFAULT NULL ,
    `product_weight_g` double  NOT NULL DEFAULT 0 ,
    `product_length_cm` double  NOT NULL DEFAULT 0 ,
    `product_height_cm` double  NOT NULL DEFAULT 0 ,
    `product_width_cm` double  NOT NULL DEFAULT 0 ,
    PRIMARY KEY (
        `product_id`
    )
);

CREATE TABLE `olist_sellers_dataset` (
    `seller_id` varchar(50)  NOT NULL ,
    `seller_zip_code_prefix` int  NOT NULL ,
    `seller_city` varchar(50)  NOT NULL ,
    `seller_state` varchar(5)  NOT NULL ,
    PRIMARY KEY (
        `seller_id`
    )
);

CREATE TABLE `product_category_name_translation` (
	`product_category_id` int auto_increment primary key ,
    `product_category_name` varchar(200)  NOT NULL ,
    `product_category_name_english` varchar(200)  NOT NULL,
    INDEX `idx_product_category_name` (`product_category_name`)
)DEFAULT CHARSET=UTF8MB4;

ALTER TABLE `olist_customers_dataset` 
ADD CONSTRAINT `fk_olist_customers_dataset_customer_zip_code_prefix` 
FOREIGN KEY(`customer_zip_code_prefix`)
REFERENCES `olist_geolocation_dataset` (`geolocation_zip_code_prefix`);

ALTER TABLE `olist_order_items_dataset` 
ADD CONSTRAINT `fk_olist_order_items_dataset_order_id` 
FOREIGN KEY(`order_id`)
REFERENCES `olist_orders_dataset` (`order_id`);

ALTER TABLE `olist_order_items_dataset` 
ADD CONSTRAINT `fk_olist_order_items_dataset_product_id` 
FOREIGN KEY(`product_id`)
REFERENCES `olist_products_dataset` (`product_id`);

ALTER TABLE `olist_order_items_dataset` 
ADD CONSTRAINT `fk_olist_order_items_dataset_seller_id` 
FOREIGN KEY(`seller_id`)
REFERENCES `olist_sellers_dataset` (`seller_id`);

ALTER TABLE `olist_order_payments_dataset` 
ADD CONSTRAINT `fk_olist_order_payments_dataset_order_id` 
FOREIGN KEY(`order_id`)
REFERENCES `olist_orders_dataset` (`order_id`);

ALTER TABLE `olist_order_reviews_dataset` 
ADD CONSTRAINT `fk_olist_order_reviews_dataset_order_id` 
FOREIGN KEY(`order_id`)
REFERENCES `olist_orders_dataset` (`order_id`);

ALTER TABLE `olist_orders_dataset` 
ADD CONSTRAINT `fk_olist_orders_dataset_customer_id` 
FOREIGN KEY(`customer_id`)
REFERENCES `olist_customers_dataset` (`customer_id`);

ALTER TABLE `olist_products_dataset` 
ADD CONSTRAINT `fk_olist_products_dataset_product_category_name` 
FOREIGN KEY(`product_category_name`)
REFERENCES `product_category_name_translation` (`product_category_name`);

ALTER TABLE `olist_sellers_dataset` 
ADD CONSTRAINT `fk_olist_sellers_dataset_seller_zip_product_category_name_translationcode_prefix` 
FOREIGN KEY(`seller_zip_code_prefix`)
REFERENCES `olist_geolocation_dataset` (`geolocation_zip_code_prefix`);

