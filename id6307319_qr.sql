-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 06, 2018 at 01:40 AM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 7.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `id6307319_qr`
--

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `cid` int(5) NOT NULL,
  `cname` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`cid`, `cname`) VALUES
(57, '.NET'),
(55, 'ANDROID'),
(60, 'ASP'),
(58, 'HTML/CSS'),
(31, 'IOS'),
(59, 'JAVA'),
(56, 'PHP');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `lid` int(5) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pwd` varchar(15) NOT NULL,
  `role` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`lid`, `email`, `pwd`, `role`) VALUES
(1, 'silviyavelani@gmail.com', 'Torts2192*', 'admin'),
(45, 'silviyavelani@icloud.com', 'Torts2192*', 'user'),
(46, 'silviyavelani2810@gmail.com', 'Svv1997*', 'user'),
(47, 'vijayvelani37@gmail.com', 'Vpv1970*', 'user'),
(54, 'bans@gmail.com', 'Torts2192*', 'user'),
(55, 'ayushi@gmail.com', 'Torts2192*', 'user'),
(56, 'rushan@gmail.com', 'Rvv2004*', 'user'),
(57, 'heena@gmail.com', 'Torts2192*', 'user'),
(58, 'ayu@gmail.com', 'Torts2192*', 'user'),
(59, 'ravikanjia.rk@gmail.com', 'Torts2192*', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `opening`
--

CREATE TABLE `opening` (
  `openid` int(5) NOT NULL,
  `cid` int(5) NOT NULL,
  `noofpositions` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `opening`
--

INSERT INTO `opening` (`openid`, `cid`, `noofpositions`) VALUES
(2, 55, 7),
(8, 58, 1),
(9, 59, 5),
(10, 60, 5);

-- --------------------------------------------------------

--
-- Table structure for table `qpapermaster`
--

CREATE TABLE `qpapermaster` (
  `qid` int(5) NOT NULL,
  `setname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `qpapermaster`
--

INSERT INTO `qpapermaster` (`qid`, `setname`) VALUES
(22, 'Set 1'),
(23, 'Set 2'),
(24, 'Set 2');

-- --------------------------------------------------------

--
-- Table structure for table `register`
--

CREATE TABLE `register` (
  `rid` int(5) NOT NULL,
  `lid` int(5) NOT NULL,
  `firstname` varchar(20) NOT NULL,
  `middlename` varchar(20) NOT NULL,
  `lastname` varchar(20) NOT NULL,
  `no` bigint(15) NOT NULL,
  `photo` varchar(110) NOT NULL,
  `gender` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `register`
--

INSERT INTO `register` (`rid`, `lid`, `firstname`, `middlename`, `lastname`, `no`, `photo`, `gender`) VALUES
(1, 45, 'Silviya', 'Vijay', 'Velani', 9825089794, 'profile/45.png', 'Female'),
(2, 46, 'Silly', 'Vijay', 'Velani', 9898989898, 'profile/46.png', 'Female'),
(3, 47, 'Vijay', 'Pyarali', 'Velani', 9825589794, 'profile/47.png', 'Male'),
(5, 54, 'Bansi', 'Jatin', 'Sojitra', 5555555555, 'profile/45.png', 'Female'),
(6, 55, 'Ayushi', 'Ajay', 'Patel', 9852525252, 'profile/55.png', 'Female'),
(7, 56, 'Rushan', 'Vijay', 'Velani', 9825789794, 'profile/56.png', 'Male'),
(8, 57, 'Heena', 'Sunil', 'Vidhani', 7777777777, 'profile/57.png', 'Female'),
(9, 58, 'Aayu', 'Ajay', 'Patel', 8888888888, 'profile/58.png', 'Female'),
(10, 59, 'Jay', 'Hajdb', 'Bsjxk', 8888888888, 'profile/59.png', 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `resume`
--

CREATE TABLE `resume` (
  `resumeid` int(5) NOT NULL,
  `lid` int(5) NOT NULL,
  `cid` int(5) NOT NULL,
  `filepath` varchar(150) NOT NULL,
  `examstatus` tinyint(1) DEFAULT NULL,
  `qrstatus` tinyint(1) DEFAULT NULL,
  `applystatus` tinyint(1) DEFAULT NULL,
  `marks` int(2) NOT NULL,
  `schedulestatus` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `resume`
--

INSERT INTO `resume` (`resumeid`, `lid`, `cid`, `filepath`, `examstatus`, `qrstatus`, `applystatus`, `marks`, `schedulestatus`) VALUES
(1, 45, 31, 'http://silviyavelani.com', 1, 1, 1, 10, 1),
(2, 46, 31, '', 0, 0, 0, 0, 0),
(3, 47, 55, 'hajsjsja', 1, 1, 1, 11, 1),
(6, 54, 31, '', 0, 0, 0, 0, 0),
(7, 55, 55, 'hajkxxks', 1, 1, 1, 17, 0),
(8, 56, 56, 'bskxlv', 1, 1, 1, 10, 0),
(9, 57, 31, 'hhhlandnxisoa', 0, 1, 1, 0, 0),
(10, 58, 58, 'http://ayu.com', 0, 1, 1, 0, 0),
(11, 59, 55, 'www.hsjidf.com', 0, 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `sid` int(5) NOT NULL,
  `lid` int(5) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `cdate` date NOT NULL,
  `ctime` time NOT NULL,
  `schedulestatus` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `subqpaper`
--

CREATE TABLE `subqpaper` (
  `sqid` int(5) NOT NULL,
  `qid` int(5) NOT NULL,
  `question` varchar(500) NOT NULL,
  `opa` varchar(150) NOT NULL,
  `opb` varchar(150) NOT NULL,
  `opc` varchar(150) NOT NULL,
  `opd` varchar(150) NOT NULL,
  `correctop` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `subqpaper`
--

INSERT INTO `subqpaper` (`sqid`, `qid`, `question`, `opa`, `opb`, `opc`, `opd`, `correctop`) VALUES
(1, 22, 'In the first 10 overs of a cricket game, the run rate was only 3.2. What should be the run rate in the remaining 40 overs to reach the target of 282 runs?', '6.25', '6.5', '6.75', '7', 'Option One'),
(2, 22, 'The average of 20 numbers is zero. Of them, at the most, how many may be greater than zero?', '0', '1', '10', '19', 'Option Four'),
(3, 22, 'If the average marks of three batches of 55, 60 and 45 students respectively is 50, 55, 60, then the average marks of all the students is:', '53.33', '54.68', '55', 'None', 'Option Two'),
(4, 22, 'The cost price of 20 articles is the same as the selling price of x articles. If the profit is 25%, then the value of x is:', '15', '16', '18', '25', 'Option Two'),
(5, 22, 'If selling price is doubled, the profit triples. Find the profit percent.', '66 2/3', '100', '105 1/3', '120', 'Option Two'),
(6, 22, 'A vendor bought toffees at 6 for a rupee. How many for a rupee must he sell to gain 20%?', '3', '4', '5', '6', 'Option Three'),
(7, 22, 'A shopkeeper expects a gain of 22.5% on his cost price. If in a week, his sale was of Rs. 392, what was his profit?', '70', '75', '72', '69', 'Option Three'),
(8, 22, 'A man buys a cycle for Rs. 1400 and sells it at a loss of 15%. What is the selling price of the cycle?', '1170', '1175', '1190', '1159', 'Option Three'),
(9, 22, 'Some articles were bought at 6 articles for Rs. 5 and sold at 5 articles for Rs. 6. Gain percent is', '44', '32', '56', '40', 'Option One'),
(10, 22, 'On selling 17 balls at Rs. 720, there is a loss equal to the cost price of 5 balls. The cost price of a ball is:', '50', '55', '59', '60', 'Option Four'),
(11, 22, 'When a plot is sold for Rs. 18,700, the owner loses 15%. At what price must that plot be sold in order to gain 15%?', '25050', '25555', '25300', '25060', 'Option Three'),
(12, 22, 'A fruit seller had some apples. He sells 40% apples and still has 420 apples. Originally, he had:', '650', '750', '700', '725', 'Option Three'),
(13, 22, 'What percentage of numbers from 1 to 70 have 1 or 9 in the units digit?', '12', '14', '20', '21', 'Option Three'),
(14, 22, 'If A = x% of y and B = y% of x, then which of the following is true?', 'A is smaller than B.', 'A is greater than B.', 'Relationship between A and B cannot be determined.', 'None', 'Option Four'),
(15, 22, 'If 20% of a = b, then b% of 20 is the same as:', '4% of a', '5% of a', '20% of a', 'None', 'Option One'),
(16, 22, 'It was Sunday on Jan 1, 2006. What was the day of the week Jan 1, 2010?', 'Sunday', 'Saturday', 'Friday', 'Wednesday', 'Option Three'),
(17, 22, 'What was the day of the week on 28th May, 2006?', 'Sunday', 'Saturday', 'Friday', 'Wednesday', 'Option One'),
(18, 22, 'What was the day of the week on 17th June, 1998?', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Option Three'),
(19, 22, 'What will be the day of the week 15th August, 2010?', 'Monday', 'Tuesday', 'Sunday', 'Thursday', 'Option Three'),
(20, 22, 'Today is Monday. After 61 days, it will be:', 'Monday', 'Tuesday', 'Saturday', 'Thursday', 'Option Three');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`cid`),
  ADD UNIQUE KEY `cname` (`cname`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`lid`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `opening`
--
ALTER TABLE `opening`
  ADD PRIMARY KEY (`openid`),
  ADD KEY `cid` (`cid`);

--
-- Indexes for table `qpapermaster`
--
ALTER TABLE `qpapermaster`
  ADD PRIMARY KEY (`qid`);

--
-- Indexes for table `register`
--
ALTER TABLE `register`
  ADD PRIMARY KEY (`rid`),
  ADD KEY `lid` (`lid`);

--
-- Indexes for table `resume`
--
ALTER TABLE `resume`
  ADD PRIMARY KEY (`resumeid`),
  ADD KEY `lid` (`lid`),
  ADD KEY `cid` (`cid`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`sid`),
  ADD KEY `lid` (`lid`);

--
-- Indexes for table `subqpaper`
--
ALTER TABLE `subqpaper`
  ADD PRIMARY KEY (`sqid`),
  ADD KEY `qid` (`qid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `cid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `lid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `opening`
--
ALTER TABLE `opening`
  MODIFY `openid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `qpapermaster`
--
ALTER TABLE `qpapermaster`
  MODIFY `qid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `register`
--
ALTER TABLE `register`
  MODIFY `rid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `resume`
--
ALTER TABLE `resume`
  MODIFY `resumeid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `sid` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subqpaper`
--
ALTER TABLE `subqpaper`
  MODIFY `sqid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `opening`
--
ALTER TABLE `opening`
  ADD CONSTRAINT `opening_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `category` (`cid`);

--
-- Constraints for table `register`
--
ALTER TABLE `register`
  ADD CONSTRAINT `register_ibfk_1` FOREIGN KEY (`lid`) REFERENCES `login` (`lid`);

--
-- Constraints for table `resume`
--
ALTER TABLE `resume`
  ADD CONSTRAINT `resume_ibfk_1` FOREIGN KEY (`lid`) REFERENCES `login` (`lid`),
  ADD CONSTRAINT `resume_ibfk_2` FOREIGN KEY (`cid`) REFERENCES `category` (`cid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`lid`) REFERENCES `login` (`lid`);

--
-- Constraints for table `subqpaper`
--
ALTER TABLE `subqpaper`
  ADD CONSTRAINT `subqpaper_ibfk_1` FOREIGN KEY (`qid`) REFERENCES `qpapermaster` (`qid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
