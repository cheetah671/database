-- ============================================================================
-- MAHABHARAT DATABASE - DEMO VERIFICATION QUERIES
-- Quick Reference: One query per operation for BEFORE/AFTER verification
-- ============================================================================

USE mahabharat_db;

-- ============================================================================
-- OPERATION #8: INSERT - Add New Warrior
-- ============================================================================

-- BEFORE: Check if warrior 'Satyaki' exists
SELECT * FROM Warrior WHERE name = 'Satyaki';

-- [Run Python app: Option 8 - Insert warrior named 'Satyaki']

-- AFTER: Verify warrior was inserted
SELECT * FROM Warrior WHERE name = 'Satyaki';


-- ============================================================================
-- OPERATION #9: INSERT - Add Skill to Warrior
-- ============================================================================

-- BEFORE: Check Arjuna's existing skills
SELECT ws.skill_name FROM Warrior_Skills ws JOIN Warrior w ON ws.warrior_id = w.id WHERE w.name = 'Arjuna';

-- [Run Python app: Option 9 - Add skill 'Meditation' to Arjuna]

-- AFTER: Verify skill was added
SELECT ws.skill_name FROM Warrior_Skills ws JOIN Warrior w ON ws.warrior_id = w.id WHERE w.name = 'Arjuna';


-- ============================================================================
-- OPERATION #10: UPDATE - Change Warrior Status
-- ============================================================================

-- BEFORE: Check Nakula's current status
SELECT name, status FROM Warrior WHERE name = 'Nakula';

-- [Run Python app: Option 10 - Change Nakula's status to 'fallen']

-- AFTER: Verify status was updated
SELECT name, status FROM Warrior WHERE name = 'Nakula';


-- ============================================================================
-- OPERATION #11: UPDATE - Change Chariot Status
-- ============================================================================

-- BEFORE: Check Nandaka chariot's current status
SELECT name, status FROM Chariot WHERE name = 'Nandaka';

-- [Run Python app: Option 11 - Change Nandaka's status to 'destroyed']

-- AFTER: Verify chariot status was updated
SELECT name, status FROM Chariot WHERE name = 'Nandaka';


-- ============================================================================
-- OPERATION #12: DELETE - Remove Warrior Skill
-- ============================================================================

-- BEFORE: Check Bhima's skills
SELECT ws.skill_name FROM Warrior_Skills ws JOIN Warrior w ON ws.warrior_id = w.id WHERE w.name = 'Bhima';

-- [Run Python app: Option 12 - Remove a skill from Bhima]

-- AFTER: Verify skill was deleted
SELECT ws.skill_name FROM Warrior_Skills ws JOIN Warrior w ON ws.warrior_id = w.id WHERE w.name = 'Bhima';


-- ============================================================================
-- OPERATION #13: DELETE - Remove Boon/Curse
-- ============================================================================

-- BEFORE: Check Karna's boons/curses
SELECT bc.name, bcd.type FROM Boon_Curse bc JOIN Boon_Curse_Details bcd ON bc.name = bcd.name JOIN Warrior w ON bc.warrior_id = w.id WHERE w.name = 'Karna';

-- [Run Python app: Option 13 - Remove a boon/curse from Karna]

-- AFTER: Verify boon/curse was deleted
SELECT bc.name, bcd.type FROM Boon_Curse bc JOIN Boon_Curse_Details bcd ON bc.name = bcd.name JOIN Warrior w ON bc.warrior_id = w.id WHERE w.name = 'Karna';


-- ============================================================================
-- BONUS: Quick Data Checks
-- ============================================================================

-- Show all warriors (quick overview)
SELECT id, name, age, status, classification FROM Warrior ORDER BY id;

-- Show all chariots (for operation #11)
SELECT id, name, status FROM Chariot;

-- Show all available skills (for operations #9 and #12)
SELECT DISTINCT skill_name FROM Warrior_Skills ORDER BY skill_name;

-- Show all boons/curses (for operation #13)
SELECT name, type FROM Boon_Curse_Details ORDER BY type, name;
