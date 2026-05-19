VIEW `sakila`.`vw_categorias_mais_alugadas` AS
    SELECT 
        `cat`.`name` AS `name`,
        COUNT(`ren`.`rental_id`) AS `categorias_mais_alugadas`
    FROM
        (((`sakila`.`category` `cat`
        JOIN `sakila`.`film_category` `fic` ON ((`fic`.`category_id` = `cat`.`category_id`)))
        JOIN `sakila`.`inventory` `inv` ON ((`inv`.`film_id` = `fic`.`film_id`)))
        JOIN `sakila`.`rental` `ren` ON ((`ren`.`inventory_id` = `inv`.`inventory_id`)))
    GROUP BY `cat`.`category_id` , `cat`.`name`
    ORDER BY `categorias_mais_alugadas` DESC

VIEW `sakila`.`vw_clientes_mais_gastam` AS
    SELECT 
        `cus`.`first_name` AS `Nome`,
        `cus`.`last_name` AS `Sobrenome`,
        `cus`.`customer_id` AS `customer_id`,
        SUM(`pay`.`amount`) AS `Total_gastos`
    FROM
        (`sakila`.`customer` `cus`
        JOIN `sakila`.`payment` `pay` ON ((`pay`.`customer_id` = `cus`.`customer_id`)))
    GROUP BY `cus`.`customer_id` , `cus`.`first_name` , `cus`.`last_name`
    ORDER BY `Total_gastos` DESC

VIEW `sakila`.`vw_clientes_por_cidade` AS
    SELECT 
        `cou`.`country` AS `country`,
        `cit`.`city` AS `city`,
        COUNT(`cus`.`customer_id`) AS `numeros_de_clientes`
    FROM
        (((`sakila`.`country` `cou`
        JOIN `sakila`.`city` `cit` ON ((`cit`.`country_id` = `cou`.`country_id`)))
        JOIN `sakila`.`address` `ads` ON ((`cit`.`city_id` = `ads`.`city_id`)))
        JOIN `sakila`.`customer` `cus` ON ((`ads`.`address_id` = `cus`.`address_id`)))
    GROUP BY `cit`.`city` , `cou`.`country`
    ORDER BY `numeros_de_clientes` DESC

VIEW `sakila`.`vw_clientes_por_cidade` AS
    SELECT 
        `cou`.`country` AS `country`,
        `cit`.`city` AS `city`,
        COUNT(`cus`.`customer_id`) AS `numeros_de_clientes`
    FROM
        (((`sakila`.`country` `cou`
        JOIN `sakila`.`city` `cit` ON ((`cit`.`country_id` = `cou`.`country_id`)))
        JOIN `sakila`.`address` `ads` ON ((`cit`.`city_id` = `ads`.`city_id`)))
        JOIN `sakila`.`customer` `cus` ON ((`ads`.`address_id` = `cus`.`address_id`)))
    GROUP BY `cit`.`city` , `cou`.`country`
    ORDER BY `numeros_de_clientes` DESC

VIEW `sakila`.`vw_desempenho_funcionarios` AS
    SELECT 
        `sta`.`staff_id` AS `staff_id`,
        `sta`.`first_name` AS `first_name`,
        `sta`.`last_name` AS `last_name`,
        COUNT(`pay`.`payment_id`) AS `Total_de_pagamentos`,
        SUM(`pay`.`amount`) AS `Total_recebido`
    FROM
        (`sakila`.`staff` `sta`
        JOIN `sakila`.`payment` `pay` ON ((`sta`.`staff_id` = `pay`.`staff_id`)))
    GROUP BY `sta`.`staff_id` , `sta`.`first_name` , `sta`.`last_name`
    ORDER BY `Total_recebido` DESC

VIEW `sakila`.`vw_faturamento_mensal` AS
    SELECT 
        MONTH(`pay`.`payment_date`) AS `numero_mes`,
        MONTHNAME(`pay`.`payment_date`) AS `mes`,
        SUM(`pay`.`amount`) AS `Vendas_por_mes`
    FROM
        `sakila`.`payment` `pay`
    GROUP BY MONTH(`pay`.`payment_date`) , MONTHNAME(`pay`.`payment_date`)
    ORDER BY `Vendas_por_mes` DESC

VIEW `sakila`.`vw_media_valor_aluguel` AS
    SELECT 
        AVG(`sub`.`total`) AS `media_valor_por_aluguel`
    FROM
        (SELECT 
            `sakila`.`payment`.`rental_id` AS `rental_id`,
                SUM(`sakila`.`payment`.`amount`) AS `total`
        FROM
            `sakila`.`payment`
        GROUP BY `sakila`.`payment`.`rental_id`) `sub`

VIEW `sakila`.`vw_receita_filmes` AS
    SELECT 
        `fil`.`title` AS `title`,
        SUM(`pay`.`amount`) AS `filmes_mais_vendidos`
    FROM
        (((`sakila`.`film` `fil`
        JOIN `sakila`.`inventory` `inv` ON ((`inv`.`film_id` = `fil`.`film_id`)))
        JOIN `sakila`.`rental` `ren` ON ((`ren`.`inventory_id` = `inv`.`inventory_id`)))
        JOIN `sakila`.`payment` `pay` ON ((`pay`.`rental_id` = `ren`.`rental_id`)))
    GROUP BY `fil`.`film_id` , `fil`.`title`
    ORDER BY `filmes_mais_vendidos` DESC

VIEW `sakila`.`vw_receita_por_cidade` AS
    SELECT 
        `cit`.`city` AS `city`,
        SUM(`pay`.`amount`) AS `total_receita`
    FROM
        (((`sakila`.`city` `cit`
        JOIN `sakila`.`address` `ads` ON ((`cit`.`city_id` = `ads`.`city_id`)))
        JOIN `sakila`.`customer` `cus` ON ((`ads`.`address_id` = `cus`.`address_id`)))
        JOIN `sakila`.`payment` `pay` ON ((`cus`.`customer_id` = `pay`.`customer_id`)))
    GROUP BY `cit`.`city`
    ORDER BY `total_receita` DESC

VIEW `sakila`.`vw_receita_por_loja` AS
    SELECT 
        `sto`.`store_id` AS `store_id`,
        COUNT(`pay`.`payment_id`) AS `Total_de_vendas`,
        SUM(`pay`.`amount`) AS `valor_total`
    FROM
        ((`sakila`.`store` `sto`
        JOIN `sakila`.`staff` `sta` ON ((`sto`.`store_id` = `sta`.`store_id`)))
        JOIN `sakila`.`payment` `pay` ON ((`sta`.`staff_id` = `pay`.`staff_id`)))
    GROUP BY `sto`.`store_id`
    ORDER BY `valor_total` DESC

VIEW `sakila`.`vw_receita_por_pais` AS
    SELECT 
        `cou`.`country_id` AS `country_id`,
        `cou`.`country` AS `country`,
        SUM(`pay`.`amount`) AS `total_receitas`
    FROM
        ((((`sakila`.`country` `cou`
        JOIN `sakila`.`city` `cit` ON ((`cou`.`country_id` = `cit`.`country_id`)))
        JOIN `sakila`.`address` `ads` ON ((`cit`.`city_id` = `ads`.`city_id`)))
        JOIN `sakila`.`customer` `cus` ON ((`ads`.`address_id` = `cus`.`address_id`)))
        JOIN `sakila`.`payment` `pay` ON ((`cus`.`customer_id` = `pay`.`customer_id`)))
    GROUP BY `cou`.`country_id` , `cou`.`country`
    ORDER BY `total_receitas` DESC

VIEW `sakila`.`vw_ticket_medio_por_cliente` AS
    SELECT 
        AVG(`sub`.`total_gasto`) AS `ticket_medio_cliente`
    FROM
        (SELECT 
            `sakila`.`payment`.`customer_id` AS `customer_id`,
                SUM(`sakila`.`payment`.`amount`) AS `total_gasto`
        FROM
            `sakila`.`payment`
        GROUP BY `sakila`.`payment`.`customer_id`) `sub`
