-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema grade-manager
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `grade-manager` ;

-- -----------------------------------------------------
-- Schema grade-manager
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `grade-manager` DEFAULT CHARACTER SET utf8 ;
USE `grade-manager` ;

-- -----------------------------------------------------
-- Table `grade-manager`.`cities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grade-manager`.`cities` ;

CREATE TABLE IF NOT EXISTS `grade-manager`.`cities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `zip` VARCHAR(10) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grade-manager`.`countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grade-manager`.`countries` ;

CREATE TABLE IF NOT EXISTS `grade-manager`.`countries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `short` VARCHAR(2) NOT NULL,
  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grade-manager`.`schools`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grade-manager`.`schools` ;

CREATE TABLE IF NOT EXISTS `grade-manager`.`schools` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  `pobox` VARCHAR(45) NULL,
  `cities_id` INT NOT NULL,
  `countries_id` INT NOT NULL,
  `inserted_by` INT NOT NULL,
  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_schools_cities`
    FOREIGN KEY (`cities_id`)
    REFERENCES `grade-manager`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schools_countries1`
    FOREIGN KEY (`countries_id`)
    REFERENCES `grade-manager`.`countries` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_schools_users1`
    FOREIGN KEY (`inserted_by`)
    REFERENCES `grade-manager`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grade-manager`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grade-manager`.`users` ;

CREATE TABLE IF NOT EXISTS `grade-manager`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(500) NOT NULL,
  `admin` TINYINT NOT NULL DEFAULT 0,
  `schools_id` INT NOT NULL,
  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_users_schools1`
    FOREIGN KEY (`schools_id`)
    REFERENCES `grade-manager`.`schools` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grade-manager`.`classes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grade-manager`.`classes` ;

CREATE TABLE IF NOT EXISTS `grade-manager`.`classes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `owner_id` INT NOT NULL,
  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_classes_users1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `grade-manager`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grade-manager`.`subclasses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grade-manager`.`subclasses` ;

CREATE TABLE IF NOT EXISTS `grade-manager`.`subclasses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `classes_id` INT NOT NULL,
  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`, `classes_id`),
  CONSTRAINT `fk_subclasses_classes1`
    FOREIGN KEY (`classes_id`)
    REFERENCES `grade-manager`.`classes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grade-manager`.`semesters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grade-manager`.`semesters` ;

CREATE TABLE IF NOT EXISTS `grade-manager`.`semesters` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `start` TIMESTAMP NOT NULL,
  `end` TIMESTAMP NOT NULL,
  `users_id` INT NOT NULL,
  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_semesters_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `grade-manager`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `grade-manager`.`exames`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `grade-manager`.`exames` ;

CREATE TABLE IF NOT EXISTS `grade-manager`.`exames` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `date` TIMESTAMP NOT NULL,
  `grade` DOUBLE NOT NULL DEFAULT 1.0,
  `weight` DOUBLE NOT NULL DEFAULT 1.0,
  `users_id` INT NOT NULL,
  `subclasses_id` INT NOT NULL,
  `classes_id` INT NOT NULL,
  `semesters_id` INT NOT NULL,
  `insert_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_date` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_exames_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `grade-manager`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exames_subclasses1`
    FOREIGN KEY (`subclasses_id` , `classes_id`)
    REFERENCES `grade-manager`.`subclasses` (`id` , `classes_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exames_semesters1`
    FOREIGN KEY (`semesters_id`)
    REFERENCES `grade-manager`.`semesters` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
