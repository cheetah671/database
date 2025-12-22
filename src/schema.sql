-- ============================================================================
-- Mahabharat Mini-World Database Schema
-- Phase 4 - Database Implementation
-- ============================================================================

DROP DATABASE IF EXISTS mahabharat_db;
CREATE DATABASE mahabharat_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE mahabharat_db;

-- ============================================================================
-- Core Entity Tables
-- ============================================================================

-- Faction: Represents the two main sides (Pandavas, Kauravas)
CREATE TABLE Faction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    allegiance VARCHAR(100)
) ENGINE=InnoDB;

-- Kingdom: Kingdoms aligned with factions
CREATE TABLE Kingdom (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL UNIQUE,
    capital_city VARCHAR(120),
    faction_id INT,
    FOREIGN KEY (faction_id) REFERENCES Faction(id)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Unit_Details: Types of military units
CREATE TABLE Unit_Details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(80) NOT NULL UNIQUE,
    initial_strength INT NOT NULL CHECK (initial_strength >= 0)
) ENGINE=InnoDB;

-- Army_Unit: Actual army units belonging to kingdoms
CREATE TABLE Army_Unit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    kingdom_id INT NOT NULL,
    unit_details_id INT,
    current_strength INT DEFAULT 0,
    FOREIGN KEY (kingdom_id) REFERENCES Kingdom(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (unit_details_id) REFERENCES Unit_Details(id)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Chariot: War chariots used by warriors
CREATE TABLE Chariot (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL UNIQUE,
    status ENUM('active', 'destroyed', 'retired') NOT NULL DEFAULT 'active',
    armour_type VARCHAR(80),
    horse_count TINYINT UNSIGNED DEFAULT 4
) ENGINE=InnoDB;

-- Astra: Divine weapons
CREATE TABLE Astra (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL UNIQUE,
    type VARCHAR(80),
    description TEXT
) ENGINE=InnoDB;

-- Vyuha: Battle formations
CREATE TABLE Vyuha (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL UNIQUE,
    description TEXT,
    complexity_level INT NOT NULL CHECK (complexity_level >= 0)
) ENGINE=InnoDB;

-- Battle: Major battles in the war
CREATE TABLE Battle (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL UNIQUE,
    date DATE,
    victor_faction INT,
    FOREIGN KEY (victor_faction) REFERENCES Faction(id)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Warrior: Main warrior/character table
CREATE TABLE Warrior (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL UNIQUE,
    age INT,
    status ENUM('active', 'fallen', 'retired') NOT NULL DEFAULT 'active',
    dob DATE,
    classification VARCHAR(80),
    title VARCHAR(80),
    kingdom_id INT,
    chariot_id INT,
    FOREIGN KEY (kingdom_id) REFERENCES Kingdom(id)
        ON DELETE SET NULL 
        ON UPDATE CASCADE,
    FOREIGN KEY (chariot_id) REFERENCES Chariot(id)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================
-- Boon and Curse System
-- ============================================================================

-- Boon_Curse_Details: Master table for boons/curses
CREATE TABLE Boon_Curse_Details (
    name VARCHAR(120) PRIMARY KEY,
    type ENUM('boon', 'curse') NOT NULL,
    description TEXT
) ENGINE=InnoDB;

-- Boon_Curse: Association between warriors and boons/curses
CREATE TABLE Boon_Curse (
    warrior_id INT NOT NULL,
    name VARCHAR(120) NOT NULL,
    PRIMARY KEY (warrior_id, name),
    FOREIGN KEY (warrior_id) REFERENCES Warrior(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (name) REFERENCES Boon_Curse_Details(name)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================
-- Relationship Tables
-- ============================================================================

-- Warrior_Astra: Warriors and their known astras
CREATE TABLE Warrior_Astra (
    warrior_id INT NOT NULL,
    astra_id INT NOT NULL,
    PRIMARY KEY (warrior_id, astra_id),
    FOREIGN KEY (warrior_id) REFERENCES Warrior(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (astra_id) REFERENCES Astra(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Commander_Deploys_Vyuha: Commanders deploying formations in battles
CREATE TABLE Commander_Deploys_Vyuha (
    faction_id INT NOT NULL,
    vyuha_id INT NOT NULL,
    battle_id INT NOT NULL,
    commander_id INT NOT NULL,
    PRIMARY KEY (faction_id, vyuha_id, battle_id, commander_id),
    FOREIGN KEY (faction_id) REFERENCES Faction(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (vyuha_id) REFERENCES Vyuha(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (battle_id) REFERENCES Battle(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (commander_id) REFERENCES Warrior(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Uses_Astra_In_Duel: Records astra usage in duels
CREATE TABLE Uses_Astra_In_Duel (
    attacker_id INT NOT NULL,
    defender_id INT NOT NULL,
    battle_id INT NOT NULL,
    astra_id INT NOT NULL,
    PRIMARY KEY (attacker_id, defender_id, battle_id, astra_id),
    FOREIGN KEY (attacker_id) REFERENCES Warrior(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (defender_id) REFERENCES Warrior(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (battle_id) REFERENCES Battle(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (astra_id) REFERENCES Astra(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Warrior_Skills: Skills possessed by warriors
CREATE TABLE Warrior_Skills (
    warrior_id INT NOT NULL,
    skill_name VARCHAR(120) NOT NULL,
    PRIMARY KEY (warrior_id, skill_name),
    FOREIGN KEY (warrior_id) REFERENCES Warrior(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================
-- Warrior Classification Tables (ISA hierarchy)
-- ============================================================================

-- Maharathi: Elite warriors with mastery of all astras
CREATE TABLE Maharathi (
    warrior_id INT PRIMARY KEY,
    mastery_of_all_astras BOOLEAN NOT NULL DEFAULT FALSE,
    FOREIGN KEY (warrior_id) REFERENCES Warrior(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Atirathi: Expert chariot warriors
CREATE TABLE Atirathi (
    warrior_id INT PRIMARY KEY,
    chariot_combat_rating TINYINT UNSIGNED CHECK (chariot_combat_rating <= 10),
    FOREIGN KEY (warrior_id) REFERENCES Warrior(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Rathi: Regular warriors
CREATE TABLE Rathi (
    warrior_id INT PRIMARY KEY,
    FOREIGN KEY (warrior_id) REFERENCES Warrior(id)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================
-- Indexes for Performance
-- ============================================================================

CREATE INDEX idx_warrior_kingdom ON Warrior(kingdom_id);
CREATE INDEX idx_warrior_chariot ON Warrior(chariot_id);
CREATE INDEX idx_warrior_status ON Warrior(status);
CREATE INDEX idx_battle_date ON Battle(date);
CREATE INDEX idx_kingdom_faction ON Kingdom(faction_id);

-- ============================================================================
-- End of Schema
-- ============================================================================

