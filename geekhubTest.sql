SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `GeekhubTesting` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `GeekhubTesting` ;

-- -----------------------------------------------------
-- Table `GeekhubTesting`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeekhubTesting`.`student` ;

CREATE TABLE IF NOT EXISTS `GeekhubTesting`.`student` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci
COMMENT = 'Students';


-- -----------------------------------------------------
-- Table `GeekhubTesting`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeekhubTesting`.`course` ;

CREATE TABLE IF NOT EXISTS `GeekhubTesting`.`course` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Courses';


-- -----------------------------------------------------
-- Table `GeekhubTesting`.`student_course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeekhubTesting`.`student_course` ;

CREATE TABLE IF NOT EXISTS `GeekhubTesting`.`student_course` (
  `student_id` BIGINT UNSIGNED NOT NULL,
  `course_id` BIGINT UNSIGNED NOT NULL,
  `point` INT UNSIGNED NULL COMMENT 'points earned',
  PRIMARY KEY (`student_id`, `course_id`),
  INDEX `fk_student_has_course_course1_idx` (`course_id` ASC),
  INDEX `fk_student_has_course_student_idx` (`student_id` ASC),
  CONSTRAINT `fk_student_has_course_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `GeekhubTesting`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_has_course_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `GeekhubTesting`.`course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `GeekhubTesting`.`theme`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeekhubTesting`.`theme` ;

CREATE TABLE IF NOT EXISTS `GeekhubTesting`.`theme` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` BIGINT UNSIGNED NULL DEFAULT 0 COMMENT 'id of parents theme',
  `title` VARCHAR(255) NOT NULL COMMENT 'theme title',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci
COMMENT = 'themes for the questions and answers';


-- -----------------------------------------------------
-- Table `GeekhubTesting`.`question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeekhubTesting`.`question` ;

CREATE TABLE IF NOT EXISTS `GeekhubTesting`.`question` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `theme_id` BIGINT UNSIGNED NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `type` ENUM('check', 'radio') NOT NULL COMMENT 'Question`s type: check list, radio list',
  PRIMARY KEY (`id`, `theme_id`),
  INDEX `fk_question_theme1_idx` (`theme_id` ASC),
  CONSTRAINT `fk_question_theme1`
    FOREIGN KEY (`theme_id`)
    REFERENCES `GeekhubTesting`.`theme` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Questions for Courses';


-- -----------------------------------------------------
-- Table `GeekhubTesting`.`course_question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeekhubTesting`.`course_question` ;

CREATE TABLE IF NOT EXISTS `GeekhubTesting`.`course_question` (
  `course_id` BIGINT UNSIGNED NOT NULL,
  `question_id` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`course_id`, `question_id`),
  INDEX `fk_course_has_question_question1_idx` (`question_id` ASC),
  INDEX `fk_course_has_question_course1_idx` (`course_id` ASC),
  CONSTRAINT `fk_course_has_question_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `GeekhubTesting`.`course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_has_question_question1`
    FOREIGN KEY (`question_id`)
    REFERENCES `GeekhubTesting`.`question` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GeekhubTesting`.`answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeekhubTesting`.`answer` ;

CREATE TABLE IF NOT EXISTS `GeekhubTesting`.`answer` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `theme_id` BIGINT UNSIGNED NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`, `theme_id`),
  INDEX `fk_answer_theme1_idx` (`theme_id` ASC),
  CONSTRAINT `fk_answer_theme1`
    FOREIGN KEY (`theme_id`)
    REFERENCES `GeekhubTesting`.`theme` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'answer to question';


-- -----------------------------------------------------
-- Table `GeekhubTesting`.`question_answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeekhubTesting`.`question_answer` ;

CREATE TABLE IF NOT EXISTS `GeekhubTesting`.`question_answer` (
  `question_id` BIGINT UNSIGNED NOT NULL,
  `answer_id` BIGINT UNSIGNED NOT NULL,
  `right` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'is answer right?' /* comment truncated */ /*0 - no, 1 - yes*/,
  `point` INT UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (`question_id`, `answer_id`),
  INDEX `fk_question_has_answer_answer1_idx` (`answer_id` ASC),
  INDEX `fk_question_has_answer_question1_idx` (`question_id` ASC),
  CONSTRAINT `fk_question_has_answer_question1`
    FOREIGN KEY (`question_id`)
    REFERENCES `GeekhubTesting`.`question` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_question_has_answer_answer1`
    FOREIGN KEY (`answer_id`)
    REFERENCES `GeekhubTesting`.`answer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GeekhubTesting`.`passed_test`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeekhubTesting`.`passed_test` ;

CREATE TABLE IF NOT EXISTS `GeekhubTesting`.`passed_test` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `student_id` BIGINT UNSIGNED NOT NULL,
  `course_id` BIGINT UNSIGNED NOT NULL,
  `course_title` VARCHAR(255) NULL,
  `course_description` VARCHAR(255) NULL,
  `course_point` INT UNSIGNED NULL,
  PRIMARY KEY (`id`, `student_id`),
  INDEX `fk_passed_test_student_idx` (`student_id` ASC),
  CONSTRAINT `fk_passed_test_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `GeekhubTesting`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'The test that was passed by the student';


-- -----------------------------------------------------
-- Table `GeekhubTesting`.`test_question`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeekhubTesting`.`test_question` ;

CREATE TABLE IF NOT EXISTS `GeekhubTesting`.`test_question` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `passed_test_id` BIGINT UNSIGNED NOT NULL,
  `question_id` BIGINT UNSIGNED NULL,
  `description` VARCHAR(255) NULL,
  `theme_id` BIGINT UNSIGNED NULL,
  `theme_title` VARCHAR(255) NULL COMMENT 'theme title ',
  `type` ENUM('check', 'radio') NULL COMMENT 'Question`s type: check list, radio list',
  `point` INT UNSIGNED NULL,
  PRIMARY KEY (`id`, `passed_test_id`),
  INDEX `fk_test_question_passed_test_idx` (`passed_test_id` ASC),
  CONSTRAINT `fk_test_question_passed_test`
    FOREIGN KEY (`passed_test_id`)
    REFERENCES `GeekhubTesting`.`passed_test` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'questions that was in test';


-- -----------------------------------------------------
-- Table `GeekhubTesting`.`test_answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GeekhubTesting`.`test_answer` ;

CREATE TABLE IF NOT EXISTS `GeekhubTesting`.`test_answer` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `test_question_id` BIGINT UNSIGNED NOT NULL,
  `theme_id` BIGINT UNSIGNED NOT NULL,
  `theme_title` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NULL,
  `right` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`, `test_question_id`),
  INDEX `fk_test_answer_test_question_idx` (`test_question_id` ASC),
  CONSTRAINT `fk_test_answer_test_question`
    FOREIGN KEY (`test_question_id`)
    REFERENCES `GeekhubTesting`.`test_question` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'answer that was given by the student';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
