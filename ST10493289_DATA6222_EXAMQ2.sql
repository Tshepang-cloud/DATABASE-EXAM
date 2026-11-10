-- Drop in child-to-parent order so FKs don't block re-runs
DROP TABLE IF EXISTS AVAILABILITY;
DROP TABLE IF EXISTS EQUIPMENT;
DROP TABLE IF EXISTS WAREHOUSE;

-- ---------- EQUIPMENT ----------
CREATE TABLE EQUIPMENT (
    EquipmentID     VARCHAR(5)  NOT NULL,
    Equipment_Name  VARCHAR(40) NOT NULL,
    PRIMARY KEY (EquipmentID)
) ENGINE = InnoDB;

-- ---------- WAREHOUSE ----------
CREATE TABLE WAREHOUSE (
    WarehouseID    VARCHAR(5)  NOT NULL,
    WarehouseName  VARCHAR(20) NOT NULL,
    Address        VARCHAR(40) NOT NULL,
    PRIMARY KEY (WarehouseID)
) ENGINE = InnoDB;

-- ---------- AVAILABILITY ----------
CREATE TABLE AVAILABILITY (
    EquipmentID  VARCHAR(5) NOT NULL,
    WarehouseID  VARCHAR(5) NOT NULL,
    Quantity     SMALLINT   NOT NULL,
    PRIMARY KEY (EquipmentID, WarehouseID),
    CONSTRAINT fk_avail_equipment
        FOREIGN KEY (EquipmentID) REFERENCES EQUIPMENT (EquipmentID)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_avail_warehouse
        FOREIGN KEY (WarehouseID) REFERENCES WAREHOUSE (WarehouseID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

INSERT INTO EQUIPMENT (EquipmentID, Equipment_Name) VALUES
    ('E001', 'FOOTBALL NETS'),
    ('E002', 'TRAINING CONES'),
    ('E003', 'CRICKET BATS'),
    ('E004', 'TENNIS RACKET'),
    ('E005', 'GYM MATS');