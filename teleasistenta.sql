-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gazdă: localhost:3306
-- Timp de generare: iun. 11, 2025 la 09:32 AM
-- Versiune server: 10.4.32-MariaDB
-- Versiune PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Bază de date: `teleasistenta`
--

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `admins`
--

CREATE TABLE `admins` (
  `aemail` varchar(255) NOT NULL,
  `apassword` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel `admins`
--

INSERT INTO `admins` (`aemail`, `apassword`) VALUES
('admin@vitalink.com', '123');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `alarme`
--

CREATE TABLE `alarme` (
  `id` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `tip` varchar(255) NOT NULL,
  `valoare` varchar(255) NOT NULL,
  `data_generare` datetime DEFAULT current_timestamp(),
  `rezolvata` tinyint(1) DEFAULT 0,
  `observatii` text DEFAULT NULL,
  `data_rezolvare` datetime DEFAULT NULL,
  `supraveghetor_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `appointments`
--

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL,
  `patientID` int(11) NOT NULL,
  `doctorID` int(11) NOT NULL,
  `date` varchar(50) NOT NULL,
  `time` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'In asteptare',
  `serviceID` int(11) NOT NULL,
  `createdAt` date NOT NULL DEFAULT current_timestamp(),
  `timeslot` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel `appointments`
--

INSERT INTO `appointments` (`id`, `patientID`, `doctorID`, `date`, `time`, `status`, `serviceID`, `createdAt`, `timeslot`) VALUES
(37, 1, 17, '2025-06-25', '09:00-09:30', 'Confirmată', 1, '2025-06-09', '09:00-09:30');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `citiri_senzori`
--

CREATE TABLE `citiri_senzori` (
  `id` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tensiune` varchar(10) DEFAULT NULL,
  `puls` int(11) DEFAULT NULL,
  `temperatura_corp` decimal(3,1) DEFAULT NULL,
  `greutate` decimal(5,2) DEFAULT NULL,
  `glicemie` int(11) DEFAULT NULL,
  `lumina` tinyint(1) DEFAULT NULL,
  `temperatura_ambient` int(11) DEFAULT NULL,
  `gaz` tinyint(1) DEFAULT NULL,
  `umiditate` tinyint(1) DEFAULT NULL,
  `proximitate` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel `citiri_senzori`
--

INSERT INTO `citiri_senzori` (`id`, `pid`, `timestamp`, `tensiune`, `puls`, `temperatura_corp`, `greutate`, `glicemie`, `lumina`, `temperatura_ambient`, `gaz`, `umiditate`, `proximitate`) VALUES
(2, 1, '0000-00-00 00:00:00', '120', 80, 37.2, 70.50, 95, 1, 24, 0, 0, 1);

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `doctor`
--

CREATE TABLE `doctor` (
  `docid` int(11) NOT NULL,
  `docemail` varchar(255) DEFAULT NULL,
  `docname` varchar(255) DEFAULT NULL,
  `docpassword` varchar(255) DEFAULT NULL,
  `doctel` varchar(15) DEFAULT NULL,
  `specialties` int(2) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel `doctor`
--

INSERT INTO `doctor` (`docid`, `docemail`, `docname`, `docpassword`, `doctel`, `specialties`, `image`) VALUES
(17, 'doc1@vitalink.com', 'doc1', '123', '0744534523', 1, '1');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `ingrijitor`
--

CREATE TABLE `ingrijitor` (
  `iid` int(11) NOT NULL,
  `iname` varchar(100) DEFAULT NULL,
  `iemail` varchar(100) DEFAULT NULL,
  `ipassword` varchar(255) DEFAULT NULL,
  `iaddress` varchar(255) DEFAULT NULL,
  `idob` date DEFAULT NULL,
  `itel` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel `ingrijitor`
--

INSERT INTO `ingrijitor` (`iid`, `iname`, `iemail`, `ipassword`, `iaddress`, `idob`, `itel`) VALUES
(1, 'i1', 'i1@vitalink.com', '123', 'Timisoara', '1989-07-07', '0789876231');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `pacient`
--

CREATE TABLE `pacient` (
  `pid` int(11) NOT NULL,
  `cnp` varchar(13) NOT NULL,
  `sex` enum('M','F') DEFAULT NULL,
  `pemail` varchar(255) DEFAULT NULL,
  `pname` varchar(255) DEFAULT NULL,
  `ppassword` varchar(255) DEFAULT NULL,
  `paddress` varchar(255) DEFAULT NULL,
  `pdob` date DEFAULT NULL,
  `ptel` varchar(15) DEFAULT NULL,
  `status` enum('activ','inactiv') DEFAULT 'activ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel `pacient`
--

INSERT INTO `pacient` (`pid`, `cnp`, `sex`, `pemail`, `pname`, `ppassword`, `paddress`, `pdob`, `ptel`, `status`) VALUES
(1, '5011016350078', 'M', 'alex@vitalink.com', 'Alex', '123', 'Timisoara', '2001-10-16', '0745646765', 'activ'),
(13, '5020612016471', 'M', 'p1@vitalink.com', 'P1', '123', 'Timisoara', '2005-10-19', '0734761239', 'activ'),
(14, '5020612016471', 'M', 'p2@vitalink.com', 'P2', '123', 'TM', '2004-06-12', '0745646765', 'activ');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `servicii`
--

CREATE TABLE `servicii` (
  `id` int(3) NOT NULL,
  `specialitate_id` int(2) NOT NULL,
  `serviciu` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel `servicii`
--

INSERT INTO `servicii` (`id`, `specialitate_id`, `serviciu`) VALUES
(1, 1, 'Control medical general'),
(2, 1, 'Prescriptie medicală'),
(3, 2, 'Control cardiologic'),
(4, 2, 'Electrocardiograma'),
(5, 3, 'Consult dermatologic'),
(6, 3, 'Tratament dermatologic'),
(7, 4, 'Consult stomatologic'),
(8, 4, 'Detartraj'),
(9, 4, 'Implant'),
(10, 5, 'Consult oftalmologic'),
(11, 5, 'Corectie de vedere'),
(12, 6, 'Operatie chirurgicala'),
(13, 6, 'Consult chirurgical'),
(14, 7, 'Consult ortopedic'),
(15, 7, 'Tratament ortopedic'),
(16, 8, 'Consult pediatric'),
(17, 8, 'Vaccinari'),
(18, 9, 'Consult boli infectioase'),
(19, 9, 'Tratament boli infectioase'),
(20, 10, 'Analize de laborator'),
(21, 10, 'Consult medicina de laborator');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `specialitati`
--

CREATE TABLE `specialitati` (
  `id` int(2) NOT NULL,
  `sname` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel `specialitati`
--

INSERT INTO `specialitati` (`id`, `sname`) VALUES
(1, 'Medic de familie'),
(2, 'Cardiologie'),
(3, 'Dermatologie'),
(4, 'Stomatologie'),
(5, 'Oftalmologie'),
(6, 'Chirurgie'),
(7, 'Ortopedie'),
(8, 'Pediatrie'),
(9, 'Boli infectioase'),
(10, 'Medicina de laborator');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `supraveghetor`
--

CREATE TABLE `supraveghetor` (
  `sid` int(11) NOT NULL,
  `sname` varchar(100) NOT NULL,
  `semail` varchar(100) NOT NULL,
  `spassword` varchar(255) NOT NULL,
  `saddress` varchar(255) NOT NULL,
  `sdob` date NOT NULL,
  `stel` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Eliminarea datelor din tabel `supraveghetor`
--

INSERT INTO `supraveghetor` (`sid`, `sname`, `semail`, `spassword`, `saddress`, `sdob`, `stel`) VALUES
(1, 's1', 's1@vitalink.com', '123', 'Timisoara', '1992-06-17', '0732345668');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `webuser`
--

CREATE TABLE `webuser` (
  `email` varchar(255) NOT NULL,
  `usertype` char(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Eliminarea datelor din tabel `webuser`
--

INSERT INTO `webuser` (`email`, `usertype`) VALUES
('admin@vitalink.com', 'a'),
('p2@vitalink.com', 'p'),
('i1@vitalink.com', 'i'),
('s1@vitalink.com', 's'),
('alex@vitalink.com', 'p'),
('doc1@vitalink.com', 'd');

--
-- Indexuri pentru tabele eliminate
--

--
-- Indexuri pentru tabele `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`aemail`);

--
-- Indexuri pentru tabele `alarme`
--
ALTER TABLE `alarme`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- Indexuri pentru tabele `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patientID` (`patientID`),
  ADD KEY `doctorID` (`doctorID`),
  ADD KEY `serviceID` (`serviceID`);

--
-- Indexuri pentru tabele `citiri_senzori`
--
ALTER TABLE `citiri_senzori`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pid` (`pid`);

--
-- Indexuri pentru tabele `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`docid`),
  ADD KEY `specialties` (`specialties`);

--
-- Indexuri pentru tabele `ingrijitor`
--
ALTER TABLE `ingrijitor`
  ADD PRIMARY KEY (`iid`),
  ADD UNIQUE KEY `iemail` (`iemail`);

--
-- Indexuri pentru tabele `pacient`
--
ALTER TABLE `pacient`
  ADD PRIMARY KEY (`pid`);

--
-- Indexuri pentru tabele `servicii`
--
ALTER TABLE `servicii`
  ADD PRIMARY KEY (`id`),
  ADD KEY `specialitate_id` (`specialitate_id`);

--
-- Indexuri pentru tabele `specialitati`
--
ALTER TABLE `specialitati`
  ADD PRIMARY KEY (`id`);

--
-- Indexuri pentru tabele `supraveghetor`
--
ALTER TABLE `supraveghetor`
  ADD PRIMARY KEY (`sid`),
  ADD UNIQUE KEY `semail` (`semail`);

--
-- Indexuri pentru tabele `webuser`
--
ALTER TABLE `webuser`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT pentru tabele eliminate
--

--
-- AUTO_INCREMENT pentru tabele `alarme`
--
ALTER TABLE `alarme`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pentru tabele `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT pentru tabele `citiri_senzori`
--
ALTER TABLE `citiri_senzori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pentru tabele `doctor`
--
ALTER TABLE `doctor`
  MODIFY `docid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pentru tabele `ingrijitor`
--
ALTER TABLE `ingrijitor`
  MODIFY `iid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pentru tabele `pacient`
--
ALTER TABLE `pacient`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pentru tabele `servicii`
--
ALTER TABLE `servicii`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pentru tabele `supraveghetor`
--
ALTER TABLE `supraveghetor`
  MODIFY `sid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constrângeri pentru tabele eliminate
--

--
-- Constrângeri pentru tabele `alarme`
--
ALTER TABLE `alarme`
  ADD CONSTRAINT `alarme_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `pacient` (`pid`);

--
-- Constrângeri pentru tabele `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patientID`) REFERENCES `pacient` (`pid`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctorID`) REFERENCES `doctor` (`docid`),
  ADD CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`serviceID`) REFERENCES `servicii` (`id`);

--
-- Constrângeri pentru tabele `citiri_senzori`
--
ALTER TABLE `citiri_senzori`
  ADD CONSTRAINT `citiri_senzori_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `pacient` (`pid`);

--
-- Constrângeri pentru tabele `servicii`
--
ALTER TABLE `servicii`
  ADD CONSTRAINT `servicii_ibfk_1` FOREIGN KEY (`specialitate_id`) REFERENCES `specialitati` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
