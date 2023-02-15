-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 2023-02-15 08:31:36
-- 伺服器版本： 10.4.27-MariaDB
-- PHP 版本： 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `newyear`
--

-- --------------------------------------------------------

--
-- 資料表結構 `commodity`
--

CREATE TABLE `commodity` (
  `item_index` int(10) NOT NULL,
  `type` varchar(100) NOT NULL,
  `brand` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `cost` int(10) NOT NULL,
  `purchasetime` varchar(10) NOT NULL,
  `life_month` int(5) NOT NULL,
  `description` mediumtext NOT NULL,
  `retire` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 傾印資料表的資料 `commodity`
--

INSERT INTO `commodity` (`item_index`, `type`, `brand`, `location`, `cost`, `purchasetime`, `life_month`, `description`, `retire`) VALUES
(1, 'bed', 'A', '南', 10000, '2020-02-02', 60, '<h3>【White & Wood】北歐風雙人床架+床墊</h3>\r\n<p>大板拼接，穩固支撐</p>\r\n<p>琴弦造型床頭，簡約優雅</p>\r\n<p>安全無毒板材，歐美雙重認證</p>\r\n<p>床腳收合於床框內，避免碰撞</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/長/高)(cm) : 160 x 195 x 102 (床墊 : 寬152 x 長188 x 高42)</p>\r\n<p>床架材質 : 白橡木實木</p>\r\n<hr size=\"8px\" width=\"100%\">', 'yes'),
(2, 'bed', 'B', '中', 20000, '2021-05-05', 60, '<h3>【obis】Nivia北歐實木雙人床架+床墊</h3>\r\n<p>北歐簡約造型，搭配居家風格</p>\r\n<p>實木床腳，床架穩固耐用</p>\r\n<p>圓潤邊角設計</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/長/高)(cm) : 152 x 202 x 89 (床墊 : 寬150 x 長186 x高50)</p>\r\n<p>床架材質 : 白橡木實木</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(3, 'bed', 'C', '北', 30000, '2022-08-08', 60, '<h3>【sleepy tofu】眠豆腐標準雙人床架+床墊</h3>\r\n<p>符合歐盟低甲醛 E1 等級</p>\r\n<p>細緻的斜角處理，避免人體碰傷</p>\r\n<p>無框設計，環保水性漆塗裝</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/長/高)(cm) : 154 x 193 x 69 (床墊 : 寬152 x 長188 x 高28)</p>\r\n<p>床架材質 : 胡桃木</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(4, 'table', 'A', '南', 3000, '2018-09-09', 50, '<h3>【HappyLife】極簡風實木腳書桌</h3>\r\n<p>實木桌腳，耐重穩固不易搖晃</p>\r\n<p>抽拉便捷實木滑軌</p>\r\n<p>邊角塗漆處理，質感光滑細膩</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(長/寬/高)(cm) : 120 x 55 x 72 (抽屜 : 長28 x 寬55)</p>\r\n<p>書桌材質 : 實木</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(5, 'table', 'B', '中', 5000, '2019-06-22', 50, '<h3>【Kluster】The Lady 書桌</h3>\r\n<p>手工製作，匠心之作</p>\r\n<p>實木天然紋理，美觀耐用</p>\r\n<p>完美比例，靈性設計</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(長/寬/高)(cm) : 140 x 68 x75</p>\r\n<p>書桌材質 : 北美白蠟木</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(6, 'table', 'C', '北', 7000, '2020-01-01', 50, '<h3>【Kluster】The Lady 書桌</h3>\r\n<p>U型桌腿，牢靠結實</p>\r\n<p>桌上收納，擴容置物</p>\r\n<p>寬敞的檯面，高效辦公</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(長/寬/高)(cm) : 120 x 70 x 73</p>\r\n<p>書桌材質 : 密度板+白架</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(7, 'refrigerator', 'A', '南', 30000, '2018-10-10', 100, '<h3>【DOBON】單門復古小冰箱</h3>\r\n<p>柔和弧面&超薄設計</p>\r\n<p>冰箱內置超強靜音風扇和電機</p>\r\n<p>一體成型配上一級節能</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/深/高)(mm) : 495 x 470 x 825</p>\r\n<p>最大容積 : 93L </p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(8, 'refrigerator', 'B', '中', 50000, '2019-12-12', 100, '<h3>【WINIA】韓系復古小冰箱</h3>\r\n<p>可調式溫度控制</p>\r\n<p>多功能置物層架</p>\r\n<p>蔬果保鮮室</p>\r\n<p>3級能效，時尚與便利兼顧</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/深/高)(mm) : 489 x 580 x 918</p>\r\n<p>最大容積 : 120L </p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(9, 'refrigerator', 'C', '北', 70000, '2022-11-11', 100, '<h3>【SAMPO】歐風復古美型單門冰箱</h3>\r\n<p>冷凍冷藏一體</p>\r\n<p>可調式溫度器</p>\r\n<p>粉彩色調門板</p>\r\n<p>一級能效，圓弧曲線</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/深/高)(mm) : 480 x 535 x 906</p>\r\n<p>最大容積 : 99L </p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(10, 'television', 'A', '南', 20000, '2021-02-01', 80, '<h3>【SHARP】42型聯網LED顯示器</h3>\r\n<p>享受好聲音，不用外掛</p>\r\n<p>舒視模式，減低50%藍光</p>\r\n<p>日製面板，品質與畫質的唯一保證</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/高/深)(mm) : 956 x 569x 81</p>\r\n<p>螢幕解析度(水平×垂直) : 1920 x 1080</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(11, 'television', 'B', '中', 40000, '2019-01-09', 80, '<h3>【Kolin】42型FHD數位液晶顯示器</h3>\r\n<p>可調式藍光護眼</p>\r\n<p>預約關機設計</p>\r\n<p>影像/音效環繞模式</p>\r\n<p>4種影像模式，細緻處理</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/高/深)(mm) : 953 x 595 x 210</p>\r\n<p>螢幕解析度(水平×垂直) : 1920 x 1080</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(12, 'television', 'C', '北', 60000, '2022-12-12', 80, '<h3>【Sharp】42型智慧連網液晶顯示器</h3>\r\n<p>智慧雜訊抑制功能</p>\r\n<p>輕薄機身設計、窄邊框簡約造型</p>\r\n<p>高音質環繞揚聲系統搭載</p>\r\n<p>USB多媒體連結(靜、動態讀取)</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/高/深)(mm) : 726 x 432 x 82</p>\r\n<p>螢幕解析度(水平×垂直) : 1366 x 768</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(13, 'air_conditioner', 'A', '南', 20000, '2018-07-07', 100, '<h3>【Panasonic】頂級變頻冷專分離式冷氣機</h3>\r\n<p>ECONAVI智慧節能科技</p>\r\n<p>3D分向氣流、乾燥防霉、自體清淨</p>\r\n<p>內建Home IOT(Smart App)</p>\r\n<p>PM2.5智慧偵測，R32環保冷媒</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/高/深)(mm) : 820 x 315 x 245</p>\r\n<p>適用坪數 : 3坪以下</p>\r\n<p>電源 : 220v</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(14, 'air_conditioner', 'B', '中', 30000, '2019-09-09', 100, '<h3>【Panasonic】變頻冷暖空調</h3>\r\n<p>氣流⾃動控制系統</p>\r\n<p>乾燥防霉、自體清淨</p>\r\n<p>PM2.5智慧偵測，R32環保冷媒</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/高/深)(mm) : 1160 x 295 x 255</p>\r\n<p>適用坪數 : 5-7坪</p>\r\n<p>電源 : 220v</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(15, 'air_conditioner', 'C', '北', 40000, '2021-06-06', 100, '<h3>【Panasonic】變頻冷暖壁掛 一對一冷氣</h3>\r\n<p>ECONAVI(日照感應)</p>\r\n<p>乾燥防霉、自體清淨</p>\r\n<p>3D氣流，R32環保冷媒</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(寬/高/深)(mm) : 1160 x 295 x 255</p>\r\n<p>適用坪數 : 7-9坪</p>\r\n<p>電源 : 220v</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(16, 'laundry_machine', 'A', '南', 50000, '2020-07-07', 90, '<h3>【Whirlpool】滾筒洗衣機</h3>\r\n<p>榮獲經濟部金級省水、節能標章</p>\r\n<p>槽洗淨行程高溫殺菌</p>\r\n<p>8小時自動清新除皺</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(長/寬/高)(mm) : 600 x 635 x 850</p>\r\n<p>實際洗衣容量(kg) : 10.5kg</p>\r\n<p>電壓/頻率 : 110V/60Hz</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(17, 'laundry_machine', 'B', '中', 60000, '2021-08-08', 90, '<h3>【Whirlpool】變頻滾筒洗衣機</h3>\r\n<p>BLDC 變頻馬達</p>\r\n<p>第六感智能操控科技</p>\r\n<p>榮獲德國iF設計獎</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(長/寬/高)(mm) : 600 x 635 x 850</p>\r\n<p>實際洗衣容量(kg) : 10.5kg</p>\r\n<p>電源 : 110v</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no'),
(18, 'laundry_machine', 'C', '北', 70000, '2022-10-10', 90, '<h3>【Whirlpool】蒸氣洗脫烘變頻滾筒洗衣機</h3>\r\n<p>蒸氣深層洗淨</p>\r\n<p>Load & Go洗劑自動投遞</p>\r\n<p>99.9% 高效除菌</p>\r\n<hr size=\"8px\" width=\"100%\">\r\n<h3>商品規格</h3>\r\n<p>商品尺寸(長/寬/高)(mm) : 686 x 802 x 982</p>\r\n<p>實際洗衣容量(kg) : 15kg</p>\r\n<p>電源 : 110v</p>\r\n<hr size=\"8px\" width=\"100%\">', 'no');

-- --------------------------------------------------------

--
-- 資料表結構 `member`
--

CREATE TABLE `member` (
  `member_index` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `address` varchar(100) NOT NULL,
  `account` varchar(100) NOT NULL,
  `password` varchar(10) NOT NULL,
  `order_names` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 傾印資料表的資料 `member`
--

INSERT INTO `member` (`member_index`, `name`, `phone`, `address`, `account`, `password`, `order_names`) VALUES
(0, '系統管理員', '1234567890', '台灣', 'admin', 'admin', '不可以刪除'),
(1, '阿賢', '0987654321', '高雄市', 'Homology1996', 'S987654321', 'order1,order2'),
(2, '海夢', '5268752687', '日本', 'marin', 'S520520520', ''),
(3, '小孤獨', '3333333333', '下北澤', 'BOCCHI', 'S333333333', ''),
(4, '安妮亞', '4444444444', '某個國家', 'Anya', 'Anya', ''),
(5, '千花醬', '8787878787', '秀知院', 'chika', 'chika', '');

-- --------------------------------------------------------

--
-- 資料表結構 `orderlist`
--

CREATE TABLE `orderlist` (
  `order_index` int(10) NOT NULL,
  `account` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `order_name` varchar(100) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `item_index` int(10) NOT NULL,
  `item_rent_time` int(10) NOT NULL,
  `start` varchar(10) NOT NULL,
  `end` varchar(10) NOT NULL,
  `price` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 傾印資料表的資料 `orderlist`
--

INSERT INTO `orderlist` (`order_index`, `account`, `address`, `order_name`, `item_index`, `item_rent_time`, `start`, `end`, `price`) VALUES
(1, 'Homology1996', '高雄市', 'order1', 1, 1, '2022-02-02', '2022-03-04', 167),
(2, 'Homology1996', '高雄市', 'order2', 18, 12, '2023-02-28', '2024-02-23', 13199);

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `commodity`
--
ALTER TABLE `commodity`
  ADD PRIMARY KEY (`item_index`);

--
-- 資料表索引 `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`member_index`);

--
-- 資料表索引 `orderlist`
--
ALTER TABLE `orderlist`
  ADD PRIMARY KEY (`order_index`);

--
-- 在傾印的資料表使用自動遞增(AUTO_INCREMENT)
--

--
-- 使用資料表自動遞增(AUTO_INCREMENT) `commodity`
--
ALTER TABLE `commodity`
  MODIFY `item_index` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
