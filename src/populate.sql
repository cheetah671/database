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
