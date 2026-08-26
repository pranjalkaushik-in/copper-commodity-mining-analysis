CREATE DATABASE mining_project;
USE mining_project;
CREATE TABLE prices (
    date DATE,
    commodity DECIMAL(10,4),
    FCX DECIMAL(10,4),
    SCCO DECIMAL(10,4),
    BHP DECIMAL(10,4)
);

CREATE TABLE returns (
    date DATE,
    commodity DECIMAL(10,6),
    FCX DECIMAL(10,6),
    SCCO DECIMAL(10,6),
    BHP DECIMAL(10,6)
);
SELECT COUNT(*) AS total_rows FROM prices;
SELECT * FROM prices LIMIT 10;

SELECT COUNT(*) AS total_rows FROM prices;
SELECT * FROM prices LIMIT 10;
SELECT * FROM prices ORDER BY date DESC LIMIT 10;

DROP TABLE IF EXISTS returns;

CREATE TABLE returns (
    date DATE,
    commodity DECIMAL(10,6),
    FCX DECIMAL(10,6),
    SCCO DECIMAL(10,6),
    BHP DECIMAL(10,6)
);
 
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\prices.csv'
INTO TABLE prices
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM prices;
SELECT * FROM prices LIMIT 5;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\returns.csv'
INTO TABLE returns
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM returns;
SELECT * FROM returns LIMIT 5;


   




TRUNCATE TABLE prices;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\prices.csv'
INTO TABLE prices
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM prices;

SELECT date, commodity, FCX, SCCO, BHP 
FROM prices 
ORDER BY date ASC 
LIMIT 10;

SELECT COUNT(*) FROM returns;

SELECT date, commodity, FCX, SCCO, BHP 
FROM returns 
ORDER BY date ASC 
LIMIT 10;

SELECT YEAR(date) AS year, 
		ROUND(AVG(commodity), 2) AS avg_copper_price  #Yearly average commodity price
FROM prices
GROUP BY year
ORDER BY year;

SELECT YEAR(date) AS year,
	ROUND(MIN(commodity), 2) AS min_price,
       ROUND(MAX(commodity), 2) AS max_price,
       ROUND(MAX(commodity) - MIN(commodity), 2) AS price_range   #Yearly price range
FROM prices
GROUP BY year
ORDER BY year;

SELECT 
	ROUND(AVG(commodity), 6) AS avg_commodity_return,
	ROUND(AVG(FCX), 6) AS avg_fcx_return,
	ROUND(AVG(SCCO), 6) AS avg_scco_return,
	ROUND(AVG(BHP), 6) AS avg_bhp_return,
    ROUND(STDDEV(commodity), 6) AS commodity_volatility,  #Overall average return and volatility per stock
    ROUND(STDDEV(FCX), 6) AS fcx_volatility,
    ROUND(STDDEV(SCCO), 6) AS scco_volatility,
    ROUND(STDDEV(BHP), 6) AS bhp_volatility
FROM returns;


SELECT date, FCX FROM returns ORDER BY FCX DESC LIMIT 5;  -- best days   #Best and worst single days for FCX
SELECT date, FCX FROM returns ORDER BY FCX ASC LIMIT 5;   -- worst days


SELECT YEAR(date) AS year,
       ROUND(AVG(commodity)*100, 2) AS avg_copper_return_pct,
       ROUND(AVG(FCX)*100, 2) AS avg_fcx_return_pct,
       ROUND(AVG(SCCO)*100, 2) AS avg_scco_return_pct,       #Average yearly return: copper vs. each miner
       ROUND(AVG(BHP)*100, 2) AS avg_bhp_return_pct
FROM returns
GROUP BY year
ORDER BY year;


SELECT YEAR(date) AS year,
       ROUND(STDDEV(commodity)*100, 2) AS copper_volatility_pct,
       ROUND(STDDEV(FCX)*100, 2) AS fcx_volatility_pct,
       ROUND(STDDEV(SCCO)*100, 2) AS scco_volatility_pct,     #Yearly volatility comparison
       ROUND(STDDEV(BHP)*100, 2) AS bhp_volatility_pct
FROM returns
GROUP BY year
ORDER BY year;


SELECT
    SUM(CASE WHEN ABS(FCX) > 0.05 THEN 1 ELSE 0 END) AS fcx_big_move_days,
    SUM(CASE WHEN ABS(SCCO) > 0.05 THEN 1 ELSE 0 END) AS scco_big_move_days,      #Count of "big move" days (>5% single-day move) per stock
    SUM(CASE WHEN ABS(BHP) > 0.05 THEN 1 ELSE 0 END) AS bhp_big_move_days
FROM returns;



