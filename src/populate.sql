-- ============================================================================
-- Mahabharat Mini-World Database - Data Population
-- Phase 4 - Realistic Mahabharat Data
-- ============================================================================

USE mahabharat_db;

-- ============================================================================
-- Factions
-- ============================================================================
INSERT INTO Faction (name, allegiance) VALUES
('Pandavas', 'Dharma and Justice'),
('Kauravas', 'Power and Territory'),
('Neutral', 'Independent');

-- ============================================================================
-- Kingdoms
-- ============================================================================
INSERT INTO Kingdom (name, capital_city, faction_id) VALUES
('Indraprastha', 'Indraprastha City', (SELECT id FROM Faction WHERE name='Pandavas')),
('Hastinapura', 'Hastinapur', (SELECT id FROM Faction WHERE name='Kauravas')),
('Anga', 'Champapuri', (SELECT id FROM Faction WHERE name='Kauravas')),
('Dwarka', 'Dwaraka City', (SELECT id FROM Faction WHERE name='Neutral')),
('Panchala', 'Kampilya', (SELECT id FROM Faction WHERE name='Pandavas')),
('Matsya', 'Virata Nagar', (SELECT id FROM Faction WHERE name='Pandavas'));

-- ============================================================================
-- Unit Details
-- ============================================================================
INSERT INTO Unit_Details (type, initial_strength) VALUES
('Infantry', 10000),
('Cavalry', 5000),
('Chariot-Unit', 2000),
('Elephant-Unit', 500),
('Archer-Unit', 8000);

-- ============================================================================
-- Army Units
-- ============================================================================
INSERT INTO Army_Unit (kingdom_id, unit_details_id, current_strength) VALUES
((SELECT id FROM Kingdom WHERE name='Indraprastha'), 1, 9500),
((SELECT id FROM Kingdom WHERE name='Indraprastha'), 3, 1800),
((SELECT id FROM Kingdom WHERE name='Hastinapura'), 1, 12000),
((SELECT id FROM Kingdom WHERE name='Hastinapura'), 2, 5500),
((SELECT id FROM Kingdom WHERE name='Anga'), 3, 1500),
((SELECT id FROM Kingdom WHERE name='Panchala'), 5, 7000),
((SELECT id FROM Kingdom WHERE name='Matsya'), 1, 6000);

-- ============================================================================
-- Chariots
-- ============================================================================
INSERT INTO Chariot (name, status, armour_type, horse_count) VALUES
('Nandaka', 'active', 'Divine Gold', 4),
('Vijaya', 'destroyed', 'Celestial Iron', 4),
('Devadatta', 'active', 'Bronze Reinforced', 4),
('Sugriva', 'active', 'Silver Plated', 4),
('Manipushpaka', 'retired', 'Standard Iron', 2),
('Raktavarna', 'destroyed', 'Red Steel', 4);

-- ============================================================================
-- Astras (Divine Weapons)
-- ============================================================================
INSERT INTO Astra (name, type, description) VALUES
('Brahmastra', 'Divine', 'Most powerful weapon created by Lord Brahma, capable of destroying entire armies'),
('Pashupatastra', 'Divine', 'Weapon of Lord Shiva, the most destructive astra'),
('Agneyastra', 'Elemental', 'Weapon of Agni, god of fire, creates walls of flame'),
('Varunastra', 'Elemental', 'Weapon of Varuna, counters fire with torrential rain'),
('Vayavastra', 'Elemental', 'Weapon of wind god Vayu, creates devastating storms'),
('Narayanastra', 'Divine', 'Weapon of Lord Vishnu, releases millions of deadly missiles'),
('Vajra', 'Divine', 'Thunderbolt weapon of Indra'),
('Sudarshana Chakra', 'Divine', 'Discus of Lord Vishnu, never misses its target'),
('Vasavi Shakti', 'Divine', 'Single-use weapon given by Indra, guaranteed to kill');

-- ============================================================================
-- Vyuhas (Battle Formations)
-- ============================================================================
INSERT INTO Vyuha (name, description, complexity_level) VALUES
('Chakravyuha', 'Complex spiral formation with seven layers, extremely difficult to penetrate and escape', 9),
('Padmavyuha', 'Lotus formation with petals radiating from center, defensive structure', 7),
('Garudavyuha', 'Eagle-shaped formation with strong flanks for encirclement', 6),
('Sarvatomukha Vyuha', 'All-directional formation that can attack from any side', 8),
('Makara Vyuha', 'Crocodile formation for aggressive assault', 5),
('Kurma Vyuha', 'Turtle formation for maximum defense', 4),
('Vajra Vyuha', 'Thunderbolt formation for concentrated attack', 7);

-- ============================================================================
-- Battles
-- ============================================================================
INSERT INTO Battle (name, date, victor_faction) VALUES
('Kurukshetra Day 1', '3139-10-01', NULL),
('Kurukshetra Day 2', '3139-10-02', NULL),
('Kurukshetra Day 13', '3139-10-13', (SELECT id FROM Faction WHERE name='Kauravas')),
('Kurukshetra Day 14', '3139-10-14', (SELECT id FROM Faction WHERE name='Pandavas')),
('Kurukshetra Day 17', '3139-10-17', (SELECT id FROM Faction WHERE name='Pandavas')),
('Kurukshetra Day 18', '3139-10-18', (SELECT id FROM Faction WHERE name='Pandavas')),
('Virata War', '3138-03-15', (SELECT id FROM Faction WHERE name='Pandavas'));

-- ============================================================================
-- Warriors
-- ============================================================================
-- Note: DOB calculated from age 91 (Yudhishthira) = born 1934, age 16 (Abhimanyu) = born 2009
-- This maintains proper age ordering: older warriors have earlier birth dates
INSERT INTO Warrior (name, age, status, dob, classification, title, kingdom_id, chariot_id) VALUES
-- Pandavas (in birth order: eldest to youngest)
('Yudhishthira', 91, 'retired', '1934-07-15', 'Maharathi', 'Dharmaraja', 
    (SELECT id FROM Kingdom WHERE name='Indraprastha'), NULL),
('Bhima', 90, 'retired', '1935-05-22', 'Maharathi', 'Vrikodara', 
    (SELECT id FROM Kingdom WHERE name='Indraprastha'), NULL),
('Arjuna', 89, 'retired', '1936-03-18', 'Maharathi', 'Savyasachi', 
    (SELECT id FROM Kingdom WHERE name='Indraprastha'), (SELECT id FROM Chariot WHERE name='Nandaka')),
('Nakula', 88, 'retired', '1937-01-10', 'Atirathi', 'Sword Master', 
    (SELECT id FROM Kingdom WHERE name='Indraprastha'), NULL),
('Sahadeva', 88, 'retired', '1937-01-10', 'Atirathi', 'Astrologer Prince', 
    (SELECT id FROM Kingdom WHERE name='Indraprastha'), NULL),

-- Pandava Allies
('Abhimanyu', 16, 'fallen', '2009-08-12', 'Atirathi', 'Young Warrior', 
    (SELECT id FROM Kingdom WHERE name='Indraprastha'), (SELECT id FROM Chariot WHERE name='Devadatta')),
('Dhrishtadyumna', 35, 'fallen', '1990-06-25', 'Maharathi', 'Commander', 
    (SELECT id FROM Kingdom WHERE name='Panchala'), NULL),
('Shikhandi', 40, 'retired', '1985-11-08', 'Atirathi', 'Bhishma Slayer', 
    (SELECT id FROM Kingdom WHERE name='Panchala'), NULL),

-- Kauravas (Duryodhana and Karna same age as Yudhishthira/older)
('Duryodhana', 92, 'fallen', '1933-09-05', 'Maharathi', 'Crown Prince', 
    (SELECT id FROM Kingdom WHERE name='Hastinapura'), (SELECT id FROM Chariot WHERE name='Sugriva')),
('Dushasana', 90, 'fallen', '1935-02-14', 'Atirathi', 'Prince', 
    (SELECT id FROM Kingdom WHERE name='Hastinapura'), NULL),
('Karna', 92, 'fallen', '1933-06-01', 'Maharathi', 'Suryaputra', 
    (SELECT id FROM Kingdom WHERE name='Anga'), (SELECT id FROM Chariot WHERE name='Vijaya')),

-- Elders and Teachers (oldest warriors)
('Bhishma', 150, 'fallen', '1875-12-21', 'Maharathi', 'Grandsire', 
    (SELECT id FROM Kingdom WHERE name='Hastinapura'), NULL),
('Drona', 85, 'fallen', '1940-04-30', 'Maharathi', 'Acharya', 
    (SELECT id FROM Kingdom WHERE name='Hastinapura'), NULL),
('Ashwatthama', 50, 'retired', '1975-10-18', 'Maharathi', 'Immortal Warrior', 
    (SELECT id FROM Kingdom WHERE name='Hastinapura'), NULL),
('Kripa', 100, 'retired', '1925-03-07', 'Atirathi', 'Royal Teacher', 
    (SELECT id FROM Kingdom WHERE name='Hastinapura'), NULL);

-- ============================================================================
-- Boon and Curse Details
-- ============================================================================
INSERT INTO Boon_Curse_Details (name, type, description) VALUES
('Kavach-Kundal', 'boon', 'Divine armor and earrings making warrior invincible'),
('Immortality', 'boon', 'Cannot be killed by conventional means'),
('Death-Choice', 'boon', 'Ability to choose the time of one\'s death'),
('All-Weapon-Mastery', 'boon', 'Complete mastery over all weapons and astras'),
('Brahma-Curse', 'curse', 'Cursed to forget knowledge at crucial moment'),
('Single-Use-Limit', 'curse', 'Powerful weapon can only be used once'),
('Chariot-Stuck', 'curse', 'Chariot wheel will be stuck in crucial battle'),
('Truth-Bound', 'boon', 'Always speaks truth, cannot lie');

-- ============================================================================
-- Assign Boons and Curses to Warriors
-- ============================================================================
INSERT INTO Boon_Curse (warrior_id, name) VALUES
((SELECT id FROM Warrior WHERE name='Karna'), 'Kavach-Kundal'),
((SELECT id FROM Warrior WHERE name='Karna'), 'Brahma-Curse'),
((SELECT id FROM Warrior WHERE name='Karna'), 'Chariot-Stuck'),
((SELECT id FROM Warrior WHERE name='Ashwatthama'), 'Immortality'),
((SELECT id FROM Warrior WHERE name='Bhishma'), 'Death-Choice'),
((SELECT id FROM Warrior WHERE name='Arjuna'), 'All-Weapon-Mastery'),
((SELECT id FROM Warrior WHERE name='Yudhishthira'), 'Truth-Bound'),
((SELECT id FROM Warrior WHERE name='Karna'), 'Single-Use-Limit');

-- ============================================================================
-- Warrior-Astra Associations
-- ============================================================================
INSERT INTO Warrior_Astra (warrior_id, astra_id) VALUES
-- Arjuna's astras
((SELECT id FROM Warrior WHERE name='Arjuna'), (SELECT id FROM Astra WHERE name='Brahmastra')),
((SELECT id FROM Warrior WHERE name='Arjuna'), (SELECT id FROM Astra WHERE name='Pashupatastra')),
((SELECT id FROM Warrior WHERE name='Arjuna'), (SELECT id FROM Astra WHERE name='Agneyastra')),
((SELECT id FROM Warrior WHERE name='Arjuna'), (SELECT id FROM Astra WHERE name='Varunastra')),
((SELECT id FROM Warrior WHERE name='Arjuna'), (SELECT id FROM Astra WHERE name='Vayavastra')),

-- Karna's astras
((SELECT id FROM Warrior WHERE name='Karna'), (SELECT id FROM Astra WHERE name='Brahmastra')),
((SELECT id FROM Warrior WHERE name='Karna'), (SELECT id FROM Astra WHERE name='Vasavi Shakti')),
((SELECT id FROM Warrior WHERE name='Karna'), (SELECT id FROM Astra WHERE name='Agneyastra')),

-- Bhishma's astras
((SELECT id FROM Warrior WHERE name='Bhishma'), (SELECT id FROM Astra WHERE name='Brahmastra')),
((SELECT id FROM Warrior WHERE name='Bhishma'), (SELECT id FROM Astra WHERE name='Vajra')),

-- Drona's astras
((SELECT id FROM Warrior WHERE name='Drona'), (SELECT id FROM Astra WHERE name='Brahmastra')),
((SELECT id FROM Warrior WHERE name='Drona'), (SELECT id FROM Astra WHERE name='Narayanastra')),

-- Ashwatthama's astras
((SELECT id FROM Warrior WHERE name='Ashwatthama'), (SELECT id FROM Astra WHERE name='Brahmastra')),
((SELECT id FROM Warrior WHERE name='Ashwatthama'), (SELECT id FROM Astra WHERE name='Narayanastra')),

-- Abhimanyu's astras
((SELECT id FROM Warrior WHERE name='Abhimanyu'), (SELECT id FROM Astra WHERE name='Agneyastra')),

-- Bhima's astras
((SELECT id FROM Warrior WHERE name='Bhima'), (SELECT id FROM Astra WHERE name='Vayavastra'));

-- ============================================================================
-- Commander Deploys Vyuha
-- ============================================================================
INSERT INTO Commander_Deploys_Vyuha (faction_id, vyuha_id, battle_id, commander_id) VALUES
-- Day 13 - Chakravyuha by Kauravas
((SELECT id FROM Faction WHERE name='Kauravas'), 
 (SELECT id FROM Vyuha WHERE name='Chakravyuha'),
 (SELECT id FROM Battle WHERE name='Kurukshetra Day 13'),
 (SELECT id FROM Warrior WHERE name='Drona')),

-- Day 14 - Padmavyuha by Pandavas
((SELECT id FROM Faction WHERE name='Pandavas'),
 (SELECT id FROM Vyuha WHERE name='Padmavyuha'),
 (SELECT id FROM Battle WHERE name='Kurukshetra Day 14'),
 (SELECT id FROM Warrior WHERE name='Dhrishtadyumna')),

-- Day 1 - Vajra Vyuha by Kauravas
((SELECT id FROM Faction WHERE name='Kauravas'),
 (SELECT id FROM Vyuha WHERE name='Vajra Vyuha'),
 (SELECT id FROM Battle WHERE name='Kurukshetra Day 1'),
 (SELECT id FROM Warrior WHERE name='Bhishma')),

-- Day 2 - Garudavyuha by Pandavas
((SELECT id FROM Faction WHERE name='Pandavas'),
 (SELECT id FROM Vyuha WHERE name='Garudavyuha'),
 (SELECT id FROM Battle WHERE name='Kurukshetra Day 2'),
 (SELECT id FROM Warrior WHERE name='Arjuna'));

-- ============================================================================
-- Uses Astra in Duel
-- ============================================================================
INSERT INTO Uses_Astra_In_Duel (attacker_id, defender_id, battle_id, astra_id) VALUES
-- Arjuna vs Karna
((SELECT id FROM Warrior WHERE name='Arjuna'),
 (SELECT id FROM Warrior WHERE name='Karna'),
 (SELECT id FROM Battle WHERE name='Kurukshetra Day 17'),
 (SELECT id FROM Astra WHERE name='Agneyastra')),

-- Karna vs Arjuna 
((SELECT id FROM Warrior WHERE name='Karna'),
 (SELECT id FROM Warrior WHERE name='Arjuna'),
 (SELECT id FROM Battle WHERE name='Kurukshetra Day 17'),
 (SELECT id FROM Astra WHERE name='Vasavi Shakti')),

-- Drona vs Dhrishtadyumna
((SELECT id FROM Warrior WHERE name='Drona'),
 (SELECT id FROM Warrior WHERE name='Dhrishtadyumna'),
 (SELECT id FROM Battle WHERE name='Kurukshetra Day 14'),
 (SELECT id FROM Astra WHERE name='Brahmastra')),

-- Ashwatthama uses Narayanastra
((SELECT id FROM Warrior WHERE name='Ashwatthama'),
 (SELECT id FROM Warrior WHERE name='Bhima'),
 (SELECT id FROM Battle WHERE name='Kurukshetra Day 14'),
 (SELECT id FROM Astra WHERE name='Narayanastra'));

-- ============================================================================
-- Warrior Skills
-- ============================================================================
INSERT INTO Warrior_Skills (warrior_id, skill_name) VALUES
-- Arjuna
((SELECT id FROM Warrior WHERE name='Arjuna'), 'Archery'),
((SELECT id FROM Warrior WHERE name='Arjuna'), 'Chariot Warfare'),
((SELECT id FROM Warrior WHERE name='Arjuna'), 'Sword Fighting'),
((SELECT id FROM Warrior WHERE name='Arjuna'), 'Diplomacy'),

-- Bhima
((SELECT id FROM Warrior WHERE name='Bhima'), 'Mace Combat'),
((SELECT id FROM Warrior WHERE name='Bhima'), 'Wrestling'),
((SELECT id FROM Warrior WHERE name='Bhima'), 'Superhuman Strength'),

-- Yudhishthira
((SELECT id FROM Warrior WHERE name='Yudhishthira'), 'Spear Fighting'),
((SELECT id FROM Warrior WHERE name='Yudhishthira'), 'Dharma Knowledge'),
((SELECT id FROM Warrior WHERE name='Yudhishthira'), 'Governance'),

-- Nakula
((SELECT id FROM Warrior WHERE name='Nakula'), 'Sword Fighting'),
((SELECT id FROM Warrior WHERE name='Nakula'), 'Horse Management'),

-- Sahadeva
((SELECT id FROM Warrior WHERE name='Sahadeva'), 'Astrology'),
((SELECT id FROM Warrior WHERE name='Sahadeva'), 'Sword Fighting'),

-- Karna
((SELECT id FROM Warrior WHERE name='Karna'), 'Archery'),
((SELECT id FROM Warrior WHERE name='Karna'), 'Chariot Warfare'),
((SELECT id FROM Warrior WHERE name='Karna'), 'Spear Fighting'),

-- Duryodhana
((SELECT id FROM Warrior WHERE name='Duryodhana'), 'Mace Combat'),
((SELECT id FROM Warrior WHERE name='Duryodhana'), 'Strategy'),

-- Bhishma
((SELECT id FROM Warrior WHERE name='Bhishma'), 'Archery'),
((SELECT id FROM Warrior WHERE name='Bhishma'), 'All Weapons'),
((SELECT id FROM Warrior WHERE name='Bhishma'), 'Military Strategy'),

-- Drona
((SELECT id FROM Warrior WHERE name='Drona'), 'Archery'),
((SELECT id FROM Warrior WHERE name='Drona'), 'Teaching'),
((SELECT id FROM Warrior WHERE name='Drona'), 'Astra Knowledge'),

-- Abhimanyu
((SELECT id FROM Warrior WHERE name='Abhimanyu'), 'Archery'),
((SELECT id FROM Warrior WHERE name='Abhimanyu'), 'Chakravyuha Entry'),

-- Ashwatthama
((SELECT id FROM Warrior WHERE name='Ashwatthama'), 'Archery'),
((SELECT id FROM Warrior WHERE name='Ashwatthama'), 'Divine Powers');

-- ============================================================================
-- Warrior Classifications (ISA Hierarchy)
-- ============================================================================

-- Maharathi (can fight 10,000 warriors simultaneously)
INSERT INTO Maharathi (warrior_id, mastery_of_all_astras) VALUES
((SELECT id FROM Warrior WHERE name='Arjuna'), TRUE),
((SELECT id FROM Warrior WHERE name='Bhishma'), TRUE),
((SELECT id FROM Warrior WHERE name='Drona'), TRUE),
((SELECT id FROM Warrior WHERE name='Karna'), TRUE),
((SELECT id FROM Warrior WHERE name='Ashwatthama'), TRUE),
((SELECT id FROM Warrior WHERE name='Bhima'), FALSE),
((SELECT id FROM Warrior WHERE name='Yudhishthira'), FALSE),
((SELECT id FROM Warrior WHERE name='Duryodhana'), FALSE),
((SELECT id FROM Warrior WHERE name='Dhrishtadyumna'), FALSE);

-- Atirathi (can fight 10 warriors simultaneously)
INSERT INTO Atirathi (warrior_id, chariot_combat_rating) VALUES
((SELECT id FROM Warrior WHERE name='Nakula'), 8),
((SELECT id FROM Warrior WHERE name='Sahadeva'), 8),
((SELECT id FROM Warrior WHERE name='Abhimanyu'), 9),
((SELECT id FROM Warrior WHERE name='Dushasana'), 7),
((SELECT id FROM Warrior WHERE name='Shikhandi'), 7),
((SELECT id FROM Warrior WHERE name='Kripa'), 8);

-- Rathi (can fight 1 warrior)
INSERT INTO Rathi (warrior_id) VALUES
((SELECT id FROM Warrior WHERE name='Yudhishthira'));

-- ============================================================================
-- End of Data Population
-- ============================================================================

COMMIT;
