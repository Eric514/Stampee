-- MySQL Script generated by MySQL Workbench
-- Sun Dec 11 13:20:33 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema stampee
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema stampee
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `stampee` DEFAULT CHARACTER SET utf8 ;
USE `stampee` ;

-- -----------------------------------------------------
-- Table `stampee`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stampee`.`Role` ;

CREATE TABLE IF NOT EXISTS `stampee`.`Role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role_nom` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stampee`.`Utilisateur`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stampee`.`Utilisateur` ;

CREATE TABLE IF NOT EXISTS `stampee`.`Utilisateur` (
  `utilisateur_id` INT NOT NULL AUTO_INCREMENT,
  `utilisateur_prenom` VARCHAR(45) NOT NULL,
  `utilisateur_nom` VARCHAR(30) NOT NULL,
  `utilisateur_email` VARCHAR(45) NOT NULL,
  `utilisateur_password` VARCHAR(255) NOT NULL,
  `Role_role_id` INT NOT NULL,
  PRIMARY KEY (`utilisateur_id`),
  INDEX `fk_Utilisateur_Role1_idx` (`Role_role_id` ASC),
  CONSTRAINT `fk_Utilisateur_Role1`
    FOREIGN KEY (`Role_role_id`)
    REFERENCES `stampee`.`Role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stampee`.`Mise`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stampee`.`Mise` ;

CREATE TABLE IF NOT EXISTS `stampee`.`Mise` (
  `mise_id` INT NOT NULL AUTO_INCREMENT,
  `mise_date` DATETIME NOT NULL,
  `mise_montant` DOUBLE NOT NULL,
  `Utilisateur_utilisateur_id` INT NOT NULL,
  PRIMARY KEY (`mise_id`),
  INDEX `fk_Mise_Utilisateur1_idx` (`Utilisateur_utilisateur_id` ASC),
  CONSTRAINT `fk_Mise_Utilisateur1`
    FOREIGN KEY (`Utilisateur_utilisateur_id`)
    REFERENCES `stampee`.`Utilisateur` (`utilisateur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stampee`.`Enchere`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stampee`.`Enchere` ;

CREATE TABLE IF NOT EXISTS `stampee`.`Enchere` (
  `enchere_id` INT NOT NULL AUTO_INCREMENT,
  `enchere_debut` DATETIME NOT NULL,
  `enchere_fin` DATETIME NOT NULL,
  `Utilisateur_utilisateur_id` INT NOT NULL,
  `Mise_mise_id` INT NOT NULL,
  PRIMARY KEY (`enchere_id`),
  INDEX `fk_Enchere_Utilisateur1_idx` (`Utilisateur_utilisateur_id` ASC),
  INDEX `fk_Enchere_Mise1_idx` (`Mise_mise_id` ASC),
  CONSTRAINT `fk_Enchere_Utilisateur1`
    FOREIGN KEY (`Utilisateur_utilisateur_id`)
    REFERENCES `stampee`.`Utilisateur` (`utilisateur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Enchere_Mise1`
    FOREIGN KEY (`Mise_mise_id`)
    REFERENCES `stampee`.`Mise` (`mise_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stampee`.`Timbre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stampee`.`Timbre` ;

CREATE TABLE IF NOT EXISTS `stampee`.`Timbre` (
  `timbre_id` INT NOT NULL AUTO_INCREMENT,
  `timbre_titre` VARCHAR(30) NOT NULL,
  `timbre_description` TEXT NOT NULL,
  `timbre_condition` VARCHAR(20) NOT NULL,
  `timbre_date` DATE NOT NULL,
  `timbre_lot` INT NOT NULL,
  `timbre_prix` DOUBLE NOT NULL,
  `timbre_dimension` DATE NOT NULL,
  `timbre_pays` VARCHAR(40) NOT NULL,
  `Enchere_enchere_id` INT NOT NULL,
  PRIMARY KEY (`timbre_id`),
  INDEX `fk_Timbre_enchere1_idx` (`Enchere_enchere_id` ASC),
  CONSTRAINT `fk_Timbre_enchere1`
    FOREIGN KEY (`Enchere_enchere_id`)
    REFERENCES `stampee`.`Enchere` (`enchere_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stampee`.`Image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stampee`.`Image` ;

CREATE TABLE IF NOT EXISTS `stampee`.`Image` (
  `image_id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(255) NOT NULL,
  `image_url_sup` VARCHAR(255) NOT NULL,
  `Timbre_timbre_id` INT NOT NULL,
  `Enchere_enchere_id` INT NOT NULL,
  PRIMARY KEY (`image_id`),
  INDEX `fk_Image_Timbre1_idx` (`Timbre_timbre_id` ASC),
  INDEX `fk_Image_Enchere1_idx` (`Enchere_enchere_id` ASC),
  CONSTRAINT `fk_Image_Timbre1`
    FOREIGN KEY (`Timbre_timbre_id`)
    REFERENCES `stampee`.`Timbre` (`timbre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Image_Enchere1`
    FOREIGN KEY (`Enchere_enchere_id`)
    REFERENCES `stampee`.`Enchere` (`enchere_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `stampee`.`Favoris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `stampee`.`Favoris` ;

CREATE TABLE IF NOT EXISTS `stampee`.`Favoris` (
  `favoris_id` INT NOT NULL AUTO_INCREMENT,
  `Utilisateur_utilisateur_id` INT NOT NULL,
  `Enchere_enchere_id` INT NOT NULL,
  PRIMARY KEY (`favoris_id`),
  INDEX `fk_favoris_Utilisateur1_idx` (`Utilisateur_utilisateur_id` ASC),
  INDEX `fk_favoris_enchere1_idx` (`Enchere_enchere_id` ASC),
  CONSTRAINT `fk_favoris_Utilisateur1`
    FOREIGN KEY (`Utilisateur_utilisateur_id`)
    REFERENCES `stampee`.`Utilisateur` (`utilisateur_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favoris_enchere1`
    FOREIGN KEY (`Enchere_enchere_id`)
    REFERENCES `stampee`.`Enchere` (`enchere_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
