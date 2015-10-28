-- MySQL Script generated by MySQL Workbench
-- 10/26/15 14:05:17
-- Model: New Model	Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema slit_v0.1
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `slit_v0.1` ;

-- -----------------------------------------------------
-- Schema slit_v0.1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `slit_v0.1` DEFAULT CHARACTER SET utf8 ;
USE `slit_v0.1` ;

-- -----------------------------------------------------
-- Table `slit_v0.1`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slit_v0.1`.`user` ;

CREATE TABLE IF NOT EXISTS `slit_v0.1`.`user` (
  `idUser` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `firstname` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `email` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `lastname` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idUser`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `slit_v0.1`.`module`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slit_v0.1`.`module` ;

CREATE TABLE IF NOT EXISTS `slit_v0.1`.`module` (
  `idmodule` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `responsibleTeacher` INT(11) NULL DEFAULT NULL COMMENT '',
  `description` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idmodule`)  COMMENT '',
  INDEX `teacher_idx` (`responsibleTeacher` ASC)  COMMENT '',
  CONSTRAINT `teacher`
	FOREIGN KEY (`responsibleTeacher`)
	REFERENCES `slit_v0.1`.`user` (`idUser`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `slit_v0.1`.`progress`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slit_v0.1`.`progress` ;

CREATE TABLE IF NOT EXISTS `slit_v0.1`.`progress` (
  `idprogress` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `user` INT(11) NULL DEFAULT NULL COMMENT '',
  `module` INT(11) NULL DEFAULT NULL COMMENT '',
  `evaluated_by` INT(11) NULL DEFAULT NULL COMMENT '',
  `approved` TINYINT(4) NULL DEFAULT NULL COMMENT '',
  `evaluate_date` DATE NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idprogress`)  COMMENT '',
  INDEX `progess_user_idx` (`user` ASC)  COMMENT '',
  INDEX `progress_module_idx` (`module` ASC)  COMMENT '',
  INDEX `progress_approved_by_idx` (`evaluated_by` ASC)  COMMENT '',
  CONSTRAINT `progess_user`
	FOREIGN KEY (`user`)
	REFERENCES `slit_v0.1`.`user` (`idUser`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
  CONSTRAINT `progress_evaluated_by`
	FOREIGN KEY (`evaluated_by`)
	REFERENCES `slit_v0.1`.`user` (`idUser`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
  CONSTRAINT `progress_module`
	FOREIGN KEY (`module`)
	REFERENCES `slit_v0.1`.`module` (`idmodule`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `slit_v0.1`.`feedbak`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slit_v0.1`.`feedbak` ;

CREATE TABLE IF NOT EXISTS `slit_v0.1`.`feedbak` (
  `idfeedbak` INT(11) NOT NULL COMMENT '',
  `progress` INT(11) NULL DEFAULT NULL COMMENT '',
  `upload_date` DATE NULL DEFAULT NULL COMMENT '',
  `text` BLOB NULL DEFAULT NULL COMMENT '',
  `created_by` INT(11) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idfeedbak`)  COMMENT '',
  INDEX `feedback_created_by_idx` (`created_by` ASC)  COMMENT '',
  INDEX `feedback_progress_idx` (`progress` ASC)  COMMENT '',
  CONSTRAINT `feedback_created_by`
	FOREIGN KEY (`created_by`)
	REFERENCES `slit_v0.1`.`user` (`idUser`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
  CONSTRAINT `feedback_progress`
	FOREIGN KEY (`progress`)
	REFERENCES `slit_v0.1`.`progress` (`idprogress`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `slit_v0.1`.`file`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slit_v0.1`.`file` ;

CREATE TABLE IF NOT EXISTS `slit_v0.1`.`file` (
  `idfile` INT(11) NOT NULL COMMENT '',
  `filename` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `upload_date` DATE NULL DEFAULT NULL COMMENT '',
  `file` BLOB NULL DEFAULT NULL COMMENT '',
  `progress` INT(11) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idfile`)  COMMENT '',
  INDEX `file_progress_idx` (`progress` ASC)  COMMENT '',
  CONSTRAINT `file_progress`
	FOREIGN KEY (`progress`)
	REFERENCES `slit_v0.1`.`progress` (`idprogress`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `slit_v0.1`.`ressource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slit_v0.1`.`ressource` ;

CREATE TABLE IF NOT EXISTS `slit_v0.1`.`ressource` (
  `idressource` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  `text` BLOB NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idressource`)  COMMENT '')
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `slit_v0.1`.`module_ressources`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slit_v0.1`.`module_ressources` ;

CREATE TABLE IF NOT EXISTS `slit_v0.1`.`module_ressources` (
  `idmoduleRessources` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `module` INT(11) NULL DEFAULT NULL COMMENT '',
  `ressource` INT(11) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idmoduleRessources`)  COMMENT '',
  INDEX `modules_idx` (`module` ASC)  COMMENT '',
  CONSTRAINT `modules`
	FOREIGN KEY (`module`)
	REFERENCES `slit_v0.1`.`module` (`idmodule`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION,
  CONSTRAINT `ressource`
	FOREIGN KEY (`module`)
	REFERENCES `slit_v0.1`.`ressource` (`idressource`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `slit_v0.1`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `slit_v0.1`.`role` ;

CREATE TABLE IF NOT EXISTS `slit_v0.1`.`role` (
  `idrole` INT(11) NOT NULL AUTO_INCREMENT COMMENT '',
  `user` INT(11) NULL DEFAULT NULL COMMENT '',
  `role` VARCHAR(45) NULL DEFAULT NULL COMMENT '',
  PRIMARY KEY (`idrole`)  COMMENT '',
  INDEX `user_idx` (`user` ASC)  COMMENT '',
  CONSTRAINT `user`
	FOREIGN KEY (`user`)
	REFERENCES `slit_v0.1`.`user` (`idUser`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


