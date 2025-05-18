-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: May 17, 2025 at 09:00 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `G00472910`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `price` decimal(5,2) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(100) DEFAULT 'fiction'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `title`, `author`, `price`, `image`, `description`, `category`) VALUES
(1, 'The Great Gatsby', 'F. Scott Fitzgerald', 12.99, 'gatsby.jpg', 'Classic novel set in the Jazz Age.', 'fiction'),
(2, '1984', 'George Orwell', 10.50, '1984.jpg', 'Dystopian political fiction and social commentary.', 'fiction'),
(3, 'To Kill a Mockingbird', 'Harper Lee', 11.25, 'mockingbird.jpg', 'A story of racial injustice and moral growth.', 'fiction'),
(4, 'Brave New World', 'Aldous Huxley', 13.40, 'brave.jpg', 'Dystopian sci-fi exploring futuristic control.', 'sci-fi'),
(5, 'Jane Eyre', 'Charlotte Brontë', 9.95, 'janeeyre.jpg', 'Classic gothic romance and moral growth.', 'fiction'),
(6, 'The Catcher in the Rye', 'J.D. Salinger', 11.00, 'catcher.jpg', 'Teenage alienation and identity crisis.', 'fiction'),
(7, 'The Midnight Library', 'Matt Haig', 14.20, 'midnight.jpg', 'Between life and death lies a library of regrets.', 'fiction'),
(8, 'Project Hail Mary', 'Andy Weir', 15.00, 'hailmary.jpg', 'A lone astronaut’s mission to save Earth.', 'sci-fi'),
(9, 'Klara and the Sun', 'Kazuo Ishiguro', 13.99, 'klara.jpg', 'An AI’s emotional journey to understand humanity.', 'sci-fi'),
(10, 'Lessons in Chemistry', 'Bonnie Garmus', 12.75, 'chemistry.jpg', 'A female scientist breaks 1960s norms.', 'history'),
(11, 'Tomorrow, and Tomorrow, and Tomorrow', 'Gabrielle Zevin', 14.10, 'tomorrow.jpg', 'Love, creativity, and gaming culture.', 'fiction'),
(12, 'Sea of Tranquility', 'Emily St. John Mandel', 13.60, 'tranquility.jpg', 'Time travel and plague in literary sci-fi.', 'sci-fi'),
(13, 'Fourth Wing', 'Rebecca Yarros', 16.50, 'fourthwing.jpg', 'Epic fantasy with dragons and deadly trials.', 'fantasy'),
(14, 'Happy Place', 'Emily Henry', 12.80, 'happyplace.jpg', 'A broken-up couple fakes love at a getaway.', 'romance'),
(15, 'It Ends With Us', 'Colleen Hoover', 11.40, 'endswithus.jpg', 'Romance with deep emotional themes.', 'romance'),
(16, 'The Silent Patient', 'Alex Michaelides', 13.25, 'silentpatient.jpg', 'A woman’s silence after a shocking crime.', 'fiction'),
(17, 'Verity', 'Colleen Hoover', 12.50, 'verity.jpg', 'Thriller with disturbing truths and deception.', 'fiction'),
(18, 'Atomic Habits', 'James Clear', 14.90, 'atomichabits.jpg', 'Practical guide to breaking bad habits.', 'nonfiction'),
(19, 'A Man Called Ove', 'Fredrik Backman', 11.99, 'ove.jpg', 'A grumpy old man’s life changes with unexpected friendships.', 'fiction'),
(20, 'The Alchemist', 'Paulo Coelho', 10.99, 'alchemist.jpg', 'A philosophical journey about following your dreams.', 'fiction'),
(21, 'Educated', 'Tara Westover', 13.50, 'educated.jpg', 'Memoir of a woman who grows up in a survivalist family and escapes through education.', 'nonfiction'),
(22, 'Sapiens', 'Yuval Noah Harari', 15.20, 'sapiens.jpg', 'A brief history of humankind from biology to culture.', 'nonfiction'),
(23, 'Circe', 'Madeline Miller', 12.60, 'circe.jpg', 'A retelling of the Greek myth through the eyes of the witch Circe.', 'fantasy'),
(24, 'The Night Circus', 'Erin Morgenstern', 13.80, 'nightcircus.jpg', 'Two magicians bound in a magical competition.', 'fantasy'),
(25, 'The Subtle Art of Not Giving a F*ck', 'Mark Manson', 14.00, 'subtleart.jpg', 'A brutally honest self-help book about living meaningfully.', 'nonfiction'),
(26, 'Where the Crawdads Sing', 'Delia Owens', 12.95, 'crawdads.jpg', 'A murder mystery set in a quiet southern town with nature and poetry.', 'mystery'),
(27, 'Dune', 'Frank Herbert', 14.75, 'dune.jpg', 'Epic science fiction saga set on the desert planet Arrakis.', 'science fiction');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`) VALUES
(1, 'user@123.com', 'pass');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
