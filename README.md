# Mahabharat Mini-World Database - Phase 4

**Topic:** Mahabharat Epic War Database  
**Database Name:** `mahabharat_db`  
**Total Tables:** 18  
**Python Framework:** PyMySQL  
**Interface:** Command Line Interface (CLI)

**📂 Project Resources:** [Google Drive - Complete Project Files](https://drive.google.com/file/d/15COvdCV_tTcwZE2tKWRSXLRQd3SCEMY8/view?usp=sharing)

---

##  Complete Setup Guide

### **Prerequisites**

1. **MySQL Server** installed and running
2. **Python 3.6+** installed
3. **MySQL credentials** (username: `root`, password: `Manik69*`)

### **Step 1: Install Python Dependencies**

```bash
cd /home/manik/Downloads/dna_phase4
pip3 install pymysql
```

Or use the requirements file:
```bash
pip3 install -r requirements.txt
```

---

### **Step 2: Database Setup (Choose ONE method)**

#### **Method A: Automated Setup (RECOMMENDED) ✅**

Run the automated setup script that does everything:

```bash
cd /home/manik/Downloads/dna_phase4/src
./setup_database.sh
```

**This script will:**
- ✅ Drop existing database (if any)
- ✅ Create fresh `mahabharat_db` database
- ✅ Load schema (create 18 tables)
- ✅ Populate data (insert warriors, factions, battles, etc.)
- ✅ Verify setup with data counts
- ✅ Display sample warriors

**Expected Output:**
```
==================================================================
     MAHABHARAT DATABASE - AUTOMATED SETUP
==================================================================

Step 1/5: Dropping existing database (if any)...
✓ Old database dropped

Step 2/5: Creating fresh database...
✓ Database 'mahabharat_db' created

Step 3/5: Loading schema (creating 18 tables)...
✓ Schema loaded successfully

Step 4/5: Populating data...
✓ Data populated successfully

Step 5/5: Verifying database...

Tables created:
+-------------------------+
| Tables_in_mahabharat_db |
+-------------------------+
| Army_Unit               |
| Astra                   |
| Atirathi                |
| Battle                  |
| Boon_Curse              |
| Boon_Curse_Details      |
| Chariot                 |
| Commander_Deploys_Vyuha |
| Faction                 |
| Kingdom                 |
| Maharathi               |
| Rathi                   |
| Unit_Details            |
| Uses_Astra_In_Duel      |
| Vyuha                   |
| Warrior                 |
| Warrior_Astra           |
| Warrior_Skills          |
+-------------------------+

Data counts:
+------------+-------+
| Table_Name | Count |
+------------+-------+
| Warriors   |    15 |
| Factions   |     3 |
| Kingdoms   |     6 |
| Battles    |     7 |
| Astras     |     9 |
| Vyuhas     |     7 |
+------------+-------+

✓ DATABASE SETUP COMPLETE!
```

---

#### **Method B: Manual Setup**

If you prefer to run commands individually:

**Step 1: Drop and Create Database**
```bash
mysql -u root -pManik69* -e "DROP DATABASE IF EXISTS mahabharat_db; CREATE DATABASE mahabharat_db;"
```

**Step 2: Load Schema**
```bash
cd /home/manik/Downloads/dna_phase4/src
mysql -u root -pManik69* mahabharat_db < schema.sql
```

**Step 3: Populate Data**
```bash
mysql -u root -pManik69* mahabharat_db < populate.sql
```

**Step 4: Verify Setup**
```bash
mysql -u root -pManik69* mahabharat_db -e "SHOW TABLES;"
mysql -u root -pManik69* mahabharat_db -e "SELECT COUNT(*) FROM Warrior;"
```

---

### **Step 3: Verify Installation**

Run the verification script:

```bash
cd /home/manik/Downloads/dna_phase4/src
python3 verify_schema.py
```

Or manually check in MySQL:

```bash
mysql -u root -pManik69* mahabharat_db
```

Inside MySQL, run:
```sql
-- Show all tables (should be 18)
SHOW TABLES;

-- Check data counts
SELECT 'Warriors' as Table_Name, COUNT(*) as Count FROM Warrior
UNION ALL SELECT 'Factions', COUNT(*) FROM Faction
UNION ALL SELECT 'Kingdoms', COUNT(*) FROM Kingdom
UNION ALL SELECT 'Battles', COUNT(*) FROM Battle
UNION ALL SELECT 'Astras', COUNT(*) FROM Astra;

-- View sample warriors
SELECT name, age, status, classification FROM Warrior LIMIT 5;

-- Exit MySQL
EXIT;
```

**Expected Counts:**
- Warriors: 15
- Factions: 3
- Kingdoms: 6
- Battles: 7
- Astras: 9
- Vyuhas: 7

---

## 🖥️ Running the Application

### **Start the Python Application**

```bash
cd /home/manik/Downloads/dna_phase4/src
python3 main_app.py
```

**The application will:**
1. Automatically connect to MySQL with credentials (username: `root`, password: `Manik69*`)
2. Display a menu with 13 operations (7 READ + 6 WRITE)
3. Wait for your input

**Menu Options:**
```
==================================================================
                 MAHABHARAT MINI-WORLD DATABASE
==================================================================

📖 READ OPERATIONS (Queries):
  1. List warriors by kingdom
  2. Show warrior's astras (divine weapons)
  3. Show battle formations (vyuhas) deployed
  4. Show astra usage in duels
  5. List Maharathi warriors (elite class)
  6. Show warrior skills
  7. Show faction summary

✏️  WRITE OPERATIONS:
  8. INSERT: Add new warrior
  9. INSERT: Add skill to warrior
 10. UPDATE: Change warrior status
 11. UPDATE: Change chariot status
 12. DELETE: Remove warrior skill
 13. DELETE: Remove boon/curse from warrior

  q. Quit
```

---

## 📊 Database Schema Details

### **18 Tables Overview**

#### **Core Entity Tables**

1. **Faction** - Three main factions (Pandavas, Kauravas, Neutral)
   - Columns: `id`, `name`, `allegiance`

2. **Kingdom** - Six kingdoms aligned with factions
   - Columns: `id`, `name`, `capital_city`, `faction_id`
   - Foreign Key: `faction_id` → `Faction(id)`

3. **Warrior** - 15 warriors (main characters)
   - Columns: `id`, `name`, `age`, `status`, `dob`, `classification`, `title`, `kingdom_id`, `chariot_id`
   - Foreign Keys: `kingdom_id` → `Kingdom(id)`, `chariot_id` → `Chariot(id)`
   - Status: `active`, `fallen`, `retired`

4. **Chariot** - War chariots
   - Columns: `id`, `name`, `manufacturer`, `status`, `horse_count`

5. **Astra** - Divine weapons
   - Columns: `id`, `name`, `type`, `description`

6. **Vyuha** - Battle formations
   - Columns: `id`, `name`, `complexity_level`, `description`

7. **Battle** - Major battles
   - Columns: `id`, `name`, `date`, `victor_faction`

#### **Relationship Tables**

8. **Unit_Details** - Military unit types
9. **Army_Unit** - Kingdom's army units
10. **Boon_Curse_Details** - Boon/curse definitions
11. **Boon_Curse** - Warrior's boons/curses
12. **Warrior_Astra** - Many-to-many: Warriors ↔ Astras
13. **Warrior_Skills** - Warrior skills
14. **Commander_Deploys_Vyuha** - Formation deployments in battles
15. **Uses_Astra_In_Duel** - Weapon usage in battles

#### **ISA Hierarchy Tables (Warrior Classifications)**

16. **Maharathi** - Elite warriors (9 warriors)
17. **Atirathi** - Skilled warriors (6 warriors)
18. **Rathi** - Standard warriors

---

## 🎯 Functional Requirements Implementation

### **📖 READ OPERATIONS (7 Queries)**

#### **Query 1: List Warriors by Kingdom**

**Description:** Lists all warriors belonging to a specific kingdom with their details.

**SQL Query:**
```sql
SELECT w.name, w.title, w.age, w.status, w.classification, 
       k.name AS kingdom, k.capital_city
FROM Warrior w
JOIN Kingdom k ON w.kingdom_id = k.id
WHERE k.name = %s;
```

**Example Input:** `Indraprastha`

**Expected Output:**
```
Yudhishthira | Dharmaraja | 91 | retired | Maharathi | Indraprastha | Indraprastha City
Bhima        | Vrikodara  | 90 | retired | Maharathi | Indraprastha | Indraprastha City
Arjuna       | Savyasachi | 89 | retired | Maharathi | Indraprastha | Indraprastha City
...
```

---

#### **Query 2: Show Warrior's Astras**

**Description:** Lists all divine weapons (astras) known by a specific warrior.

**SQL Query:**
```sql
SELECT a.name, a.type, a.description
FROM Astra a
JOIN Warrior_Astra wa ON a.id = wa.astra_id
JOIN Warrior w ON wa.warrior_id = w.id
WHERE w.name = %s;
```

**Example Input:** `Arjuna`

**Expected Output:**
```
Brahmastra     | Celestial | Most powerful weapon
Pashupatastra  | Divine    | Weapon of Lord Shiva
Agneyastra     | Elemental | Fire weapon
...
```

---

#### **Query 3: Show Battle Formations (Vyuhas)**

**Description:** Displays battle formations deployed in a specific battle.

**SQL Query:**
```sql
SELECT b.name AS battle, f.name AS faction, v.name AS vyuha, 
       v.complexity_level, w.name AS commander
FROM Commander_Deploys_Vyuha cdv
JOIN Battle b ON cdv.battle_id = b.id
JOIN Faction f ON cdv.faction_id = f.id
JOIN Vyuha v ON cdv.vyuha_id = v.id
JOIN Warrior w ON cdv.commander_id = w.id
WHERE b.name = %s;
```

**Example Input:** `Kurukshetra Day 13`

**Expected Output:**
```
Kurukshetra Day 13 | Kauravas | Chakravyuha | 9 | Drona
```

---

#### **Query 4: Show Astra Usage in Duels**

**Description:** Shows all instances of divine weapons being used in combat.

**SQL Query:**
```sql
SELECT b.name AS battle, w1.name AS attacker, w2.name AS defender, 
       a.name AS astra, a.type
FROM Uses_Astra_In_Duel uad
JOIN Battle b ON uad.battle_id = b.id
JOIN Warrior w1 ON uad.attacker_id = w1.id
JOIN Warrior w2 ON uad.defender_id = w2.id
JOIN Astra a ON uad.astra_id = a.id;
```

**Expected Output:**
```
Kurukshetra Day 17 | Arjuna | Karna | Anjalika | Celestial
Kurukshetra Day 14 | Karna  | Arjuna | Vasavi Shakti | Divine
...
```

---

#### **Query 5: List Maharathi Warriors**

**Description:** Lists elite Maharathi class warriors with their abilities.

**SQL Query:**
```sql
SELECT w.name, w.title, m.mastery_level, k.name AS kingdom, 
       COUNT(wa.astra_id) AS total_astras
FROM Maharathi m
JOIN Warrior w ON m.warrior_id = w.id
LEFT JOIN Kingdom k ON w.kingdom_id = k.id
LEFT JOIN Warrior_Astra wa ON w.id = wa.warrior_id
GROUP BY w.id, w.name, w.title, m.mastery_level, k.name;
```

**Expected Output:**
```
Arjuna  | Savyasachi       | Expert | Indraprastha | 5
Bhishma | Grandsire        | Master | Hastinapura  | 3
Karna   | Suryaputra       | Expert | Anga         | 4
...
```

---

#### **Query 6: Show Warrior Skills**

**Description:** Displays all skills possessed by a specific warrior.

**SQL Query:**
```sql
SELECT w.name AS warrior, w.classification, ws.skill_name
FROM Warrior w
JOIN Warrior_Skills ws ON w.id = ws.warrior_id
WHERE w.name = %s;
```

**Example Input:** `Bhima`

**Expected Output:**
```
Bhima | Maharathi | Mace Fighting
Bhima | Maharathi | Wrestling
Bhima | Maharathi | Hand-to-Hand Combat
```

---

#### **Query 7: Show Faction Summary**

**Description:** Comprehensive statistics for each faction.

**SQL Query:**
```sql
SELECT f.name AS faction, 
       COUNT(DISTINCT k.id) AS total_kingdoms,
       COUNT(DISTINCT w.id) AS total_warriors,
       SUM(CASE WHEN w.status = 'active' THEN 1 ELSE 0 END) AS active_warriors,
       SUM(CASE WHEN w.status = 'fallen' THEN 1 ELSE 0 END) AS fallen_warriors,
       COUNT(DISTINCT b.id) AS battles_won
FROM Faction f
LEFT JOIN Kingdom k ON f.id = k.faction_id
LEFT JOIN Warrior w ON k.id = w.kingdom_id
LEFT JOIN Battle b ON f.id = b.victor_faction
GROUP BY f.id, f.name;
```

**Expected Output:**
```
Pandavas | 3 | 8 | 1 | 2 | 5
Kauravas | 2 | 4 | 0 | 3 | 2
Neutral  | 1 | 3 | 2 | 0 | 0
```

---

### **✏️ WRITE OPERATIONS (6 Operations)**

#### **Operation 8: INSERT - Add New Warrior**

**Description:** Inserts a new warrior into the database.

**SQL Query:**
```sql
INSERT INTO Warrior (name, age, status, dob, classification, title, kingdom_id, chariot_id)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s);
```

**Example Input:**
```
Name: Satyaki
Age: 45
Status: active
DOB: 1980-06-15
Classification: Maharathi
Title: Yadava Warrior
Kingdom: Indraprastha
Chariot: Devadatta
```

**Verification:**
```sql
SELECT * FROM Warrior WHERE name = 'Satyaki';
```

---

#### **Operation 9: INSERT - Add Skill to Warrior**

**Description:** Associates a new skill with an existing warrior.

**SQL Query:**
```sql
INSERT INTO Warrior_Skills (warrior_id, skill_name)
VALUES ((SELECT id FROM Warrior WHERE name = %s), %s);
```

**Example Input:**
```
Warrior: Arjuna
Skill: Meditation
```

**Verification:**
```sql
SELECT ws.skill_name 
FROM Warrior_Skills ws
JOIN Warrior w ON ws.warrior_id = w.id
WHERE w.name = 'Arjuna';
```

---

#### **Operation 10: UPDATE - Change Warrior Status**

**Description:** Updates a warrior's status (active/fallen/retired).

**SQL Query:**
```sql
UPDATE Warrior
SET status = %s
WHERE name = %s;
```

**Example Input:**
```
Warrior: Nakula
New Status: fallen
```

**Verification:**
```sql
SELECT name, status FROM Warrior WHERE name = 'Nakula';
```

---

#### **Operation 11: UPDATE - Change Chariot Status**

**Description:** Updates a chariot's operational status.

**SQL Query:**
```sql
UPDATE Chariot
SET status = %s
WHERE name = %s;
```

**Example Input:**
```
Chariot: Nandaka
New Status: destroyed
```

**Verification:**
```sql
SELECT name, status FROM Chariot WHERE name = 'Nandaka';
```

---

#### **Operation 12: DELETE - Remove Warrior Skill**

**Description:** Removes a skill from a warrior.

**SQL Query:**
```sql
DELETE FROM Warrior_Skills
WHERE warrior_id = (SELECT id FROM Warrior WHERE name = %s)
  AND skill_name = %s;
```

**Example Input:**
```
Warrior: Bhima
Skill: Wrestling
```

**Verification:**
```sql
SELECT ws.skill_name 
FROM Warrior_Skills ws
JOIN Warrior w ON ws.warrior_id = w.id
WHERE w.name = 'Bhima';
```

---

#### **Operation 13: DELETE - Remove Boon/Curse**

**Description:** Removes a boon or curse from a warrior.

**SQL Query:**
```sql
DELETE FROM Boon_Curse
WHERE warrior_id = (SELECT id FROM Warrior WHERE name = %s)
  AND name = %s;
```

**Example Input:**
```
Warrior: Karna
Boon/Curse: Kavach-Kundal
```

**Verification:**
```sql
SELECT bc.name, bcd.type 
FROM Boon_Curse bc
JOIN Boon_Curse_Details bcd ON bc.name = bcd.name
JOIN Warrior w ON bc.warrior_id = w.id
WHERE w.name = 'Karna';
```

---

## 🎥 Video Demonstration Guide

### **Setup: Two Terminals Side-by-Side**

#### **Terminal 1 (LEFT): MySQL Client**
```bash
mysql -u root -pManik69* mahabharat_db
```

Keep this terminal open for running BEFORE/AFTER verification queries.

#### **Terminal 2 (RIGHT): Python Application**
```bash
cd /home/manik/Downloads/dna_phase4/src
python3 main_app.py
```

Keep this terminal open for executing database operations.

---

### **Demo Flow (5 minutes maximum)**

#### **Part 1: Introduction (30 seconds)**

In **Terminal 1 (MySQL)**, show database is ready:
```sql
-- Show all tables
SHOW TABLES;

-- Show data counts
SELECT 'Warriors' as Table_Name, COUNT(*) as Count FROM Warrior
UNION ALL SELECT 'Factions', COUNT(*) FROM Faction
UNION ALL SELECT 'Battles', COUNT(*) FROM Battle;

-- Show sample warriors
SELECT name, age, status FROM Warrior LIMIT 5;
```

**Say:** "I have created the Mahabharat database with 18 tables and populated it with realistic data about the Mahabharat war."

---

#### **Part 2: READ Operations (2 minutes)**

In **Terminal 2 (Python App)**, demonstrate queries 1-7:

**Query 1:** Kingdom = `Indraprastha`  
**Query 2:** Warrior = `Arjuna`  
**Query 3:** Battle = `Kurukshetra Day 13`  
**Query 4:** All duels  
**Query 5:** Maharathi warriors  
**Query 6:** Warrior = `Bhima`  
**Query 7:** Faction summary  

**Say:** "These are the 7 read queries demonstrating various JOIN operations and complex data retrieval."

---

#### **Part 3: WRITE Operations (2.5 minutes)**

For each operation, follow this pattern: **BEFORE → ACTION → AFTER**

---

**Operation #8: INSERT Warrior**

**Terminal 1 (MySQL) - BEFORE:**
```sql
SELECT * FROM Warrior WHERE name = 'Satyaki';
```
*Expected: Empty set*

**Terminal 2 (Python App) - ACTION:**
- Choose option `8`
- Enter warrior details (Satyaki)

**Terminal 1 (MySQL) - AFTER:**
```sql
SELECT * FROM Warrior WHERE name = 'Satyaki';
```
*Expected: Shows new warrior*

**Say:** "As you can see, the warrior Satyaki has been successfully inserted."

---

**Operation #9: INSERT Skill**

**Terminal 1 (MySQL) - BEFORE:**
```sql
SELECT ws.skill_name FROM Warrior_Skills ws JOIN Warrior w ON ws.warrior_id = w.id WHERE w.name = 'Arjuna';
```
*Expected: Shows existing skills*

**Terminal 2 (Python App) - ACTION:**
- Choose option `9`
- Warrior: `Arjuna`, Skill: `Meditation`

**Terminal 1 (MySQL) - AFTER:**
```sql
SELECT ws.skill_name FROM Warrior_Skills ws JOIN Warrior w ON ws.warrior_id = w.id WHERE w.name = 'Arjuna';
```
*Expected: Shows new skill added*

---

**Operation #10: UPDATE Warrior Status**

**Terminal 1 (MySQL) - BEFORE:**
```sql
SELECT name, status FROM Warrior WHERE name = 'Nakula';
```
*Expected: Nakula | retired*

**Terminal 2 (Python App) - ACTION:**
- Choose option `10`
- Warrior: `Nakula`, Status: `fallen`

**Terminal 1 (MySQL) - AFTER:**
```sql
SELECT name, status FROM Warrior WHERE name = 'Nakula';
```
*Expected: Nakula | fallen*

---

**Operation #11: UPDATE Chariot Status**

**Terminal 1 (MySQL) - BEFORE:**
```sql
SELECT name, status FROM Chariot WHERE name = 'Nandaka';
```

**Terminal 2 (Python App) - ACTION:**
- Choose option `11`
- Chariot: `Nandaka`, Status: `destroyed`

**Terminal 1 (MySQL) - AFTER:**
```sql
SELECT name, status FROM Chariot WHERE name = 'Nandaka';
```

---

**Operation #12: DELETE Skill**

**Terminal 1 (MySQL) - BEFORE:**
```sql
SELECT ws.skill_name FROM Warrior_Skills ws JOIN Warrior w ON ws.warrior_id = w.id WHERE w.name = 'Bhima';
```

**Terminal 2 (Python App) - ACTION:**
- Choose option `12`
- Warrior: `Bhima`, remove a skill

**Terminal 1 (MySQL) - AFTER:**
```sql
SELECT ws.skill_name FROM Warrior_Skills ws JOIN Warrior w ON ws.warrior_id = w.id WHERE w.name = 'Bhima';
```
*Expected: One skill removed*

---

**Operation #13: DELETE Boon/Curse**

**Terminal 1 (MySQL) - BEFORE:**
```sql
SELECT bc.name, bcd.type FROM Boon_Curse bc JOIN Boon_Curse_Details bcd ON bc.name = bcd.name JOIN Warrior w ON bc.warrior_id = w.id WHERE w.name = 'Karna';
```

**Terminal 2 (Python App) - ACTION:**
- Choose option `13`
- Warrior: `Karna`, remove a boon/curse

**Terminal 1 (MySQL) - AFTER:**
```sql
SELECT bc.name, bcd.type FROM Boon_Curse bc JOIN Boon_Curse_Details bcd ON bc.name = bcd.name JOIN Warrior w ON bc.warrior_id = w.id WHERE w.name = 'Karna';
```
*Expected: One boon/curse removed*

---

#### **Part 4: Conclusion (30 seconds)**

**Say:** "I have successfully demonstrated all 7 read queries and 6 write operations with proper BEFORE/AFTER verification using raw SQL queries executed through my Python application. All foreign key constraints, data integrity rules, and parameterized queries are properly implemented. Thank you."

---

## 📝 Quick Reference Files

### **demo_queries.sql**
Contains one-line BEFORE/AFTER queries for quick copy-paste during demo.

**Usage:**
```bash
cat demo_queries.sql
```

Copy-paste queries as needed during demonstration.

---

### **verification_queries.sql**
Contains detailed verification queries with alternatives and explanations.

**Usage:**
```bash
cat src/verification_queries.sql
```

---

## 🔧 Troubleshooting

### **Issue: "Can't connect to MySQL server"**

**Solution:**
```bash
# Check MySQL status
sudo systemctl status mysql

# Start MySQL if not running
sudo systemctl start mysql
```

---

### **Issue: "Access denied for user 'root'"**

**Solution:**
- Verify your MySQL password is correct
- Update credentials in `src/setup_database.sh` and `src/main_app.py`

---

### **Issue: "Unknown database 'mahabharat_db'"**

**Solution:**
```bash
# Run setup script to create database
cd /home/manik/Downloads/dna_phase4/src
./setup_database.sh
```

---

### **Issue: "No module named 'pymysql'"**

**Solution:**
```bash
pip3 install pymysql
```

---

### **Issue: Empty results from queries**

**Solution:**
```bash
# Verify data is loaded
mysql -u root -pManik69* mahabharat_db -e "SELECT COUNT(*) FROM Warrior;"

# If 0, run populate script
cd /home/manik/Downloads/dna_phase4/src
mysql -u root -pManik69* mahabharat_db < populate.sql
```

---

### **Issue: Foreign key constraint fails**

**Solution:**
```bash
# Drop and recreate from scratch
cd /home/manik/Downloads/dna_phase4/src
./setup_database.sh
```

---

## 🔒 Security Features

### **SQL Injection Prevention**

All queries use **parameterized queries** with `%s` placeholders:

**✅ CORRECT (Secure):**
```python
kingdom = input("Enter kingdom: ")
query = "SELECT * FROM Warrior WHERE kingdom_id = (SELECT id FROM Kingdom WHERE name = %s)"
cursor.execute(query, (kingdom,))
```

**❌ INCORRECT (Vulnerable):**
```python
kingdom = input("Enter kingdom: ")
query = f"SELECT * FROM Warrior WHERE kingdom_id = (SELECT id FROM Kingdom WHERE name = '{kingdom}')"
cursor.execute(query)
```

---

## 📦 Submission Checklist

Before final submission:

- [ ] Database setup works (run `cd src && ./setup_database.sh` successfully)
- [ ] All 18 tables created
- [ ] Data populated (15 warriors, 3 factions, 7 battles, etc.)
- [ ] Python application runs without errors
- [ ] All 7 READ queries work correctly
- [ ] All 6 WRITE operations work correctly
- [ ] Demo queries file ready (`demo_queries.sql`)
- [ ] Video recorded (under 5 minutes)
- [ ] Video shows BEFORE/AFTER for all write operations
- [ ] Phase 3 PDF included
- [ ] README.md complete and accurate
- [ ] All files organized in proper structure

---

## 📞 Support & Documentation

### **Key Files:**
- `README.md` - Complete documentation (this file)
- `demo_queries.sql` - Quick reference for demo
- `src/setup_database.sh` - Automated database setup
- `src/schema.sql` - Database schema
- `src/populate.sql` - Sample data
- `src/main_app.py` - Python CLI application

### **Quick Commands:**

**Reset database:**
```bash
cd /home/manik/Downloads/dna_phase4/src
./setup_database.sh
```

**Run application:**
```bash
cd /home/manik/Downloads/dna_phase4/src
python3 main_app.py
```

**Open MySQL client:**
```bash
mysql -u root -pManik69* mahabharat_db
```

**View demo queries:**
```bash
cat demo_queries.sql
```

---

## 📊 Sample Data Summary

### **Warriors (15 total)**
- **Pandavas:** Yudhishthira, Bhima, Arjuna, Nakula, Sahadeva
- **Kauravas:** Duryodhana, Dushasana, Karna
- **Elders:** Bhishma, Drona, Ashwatthama, Kripa
- **Allies:** Abhimanyu, Dhrishtadyumna, Shikhandi

### **Factions (3 total)**
- Pandavas (Dharma and Justice)
- Kauravas (Power and Territory)
- Neutral (Independent)

### **Kingdoms (6 total)**
- Indraprastha (Pandavas)
- Hastinapura (Kauravas)
- Anga (Kauravas)
- Dwarka (Neutral)
- Panchala (Pandavas)
- Matsya (Pandavas)

### **Divine Weapons - Astras (9 total)**
- Brahmastra, Pashupatastra, Agneyastra
- Varunastra, Vayavastra, Narayanastra
- Vasavi Shakti, Sudarshana Chakra, Anjalika

### **Battle Formations - Vyuhas (7 total)**
- Chakravyuha (Complexity: 9)
- Padmavyuha, Garudavyuha, Vajra Vyuha
- Makara Vyuha, Krauncha Vyuha, Sarvatobhadra

### **Battles (7 total)**
- Kurukshetra Day 1 through Day 18
- Virata War

---

## 🎓 Technical Implementation Details

### **Database Features:**
- ✅ Foreign keys with proper `ON DELETE` and `ON UPDATE` actions
- ✅ `NOT NULL` constraints on required fields
- ✅ `UNIQUE` constraints on natural keys (names)
- ✅ `CHECK` constraints on numeric ranges
- ✅ `ENUM` types for status fields
- ✅ `AUTO_INCREMENT` primary keys
- ✅ Proper indexing on foreign keys

### **Application Features:**
- ✅ Parameterized queries (SQL injection prevention)
- ✅ Transaction support with commit/rollback
- ✅ Error handling with try-catch blocks
- ✅ Input validation
- ✅ User-friendly CLI interface
- ✅ Clear success/error messages

### **Data Quality:**
- ✅ Realistic Mahabharat-themed data
- ✅ Consistent naming conventions
- ✅ Proper date formats (YYYY-MM-DD)
- ✅ Age ordering maintained (older warriors have earlier birth dates)
- ✅ Referential integrity maintained

---

## 📂 Additional Resources

### **Google Drive - Complete Project Files**
🔗 **Link:** [https://drive.google.com/file/d/15COvdCV_tTcwZE2tKWRSXLRQd3SCEMY8/view?usp=sharing](https://drive.google.com/file/d/15COvdCV_tTcwZE2tKWRSXLRQd3SCEMY8/view?usp=sharing)

**What's included in the Drive:**
- 📄 Complete source code
- 📊 Database schema and populate scripts
- 🎥 Demo video
- 📝 Phase 3 report
- 📋 All documentation files
- 🔧 Setup scripts and utilities

**Access Instructions:**
1. Click the link above
2. View/download the complete project ZIP file
3. Extract and follow README instructions

---

## 🎯 Conclusion

This project successfully implements a complete database system for the Mahabharat Mini-World with:
- **18 normalized tables** following 3NF
- **7 complex read queries** with JOINs and aggregations
- **6 write operations** (INSERT, UPDATE, DELETE)
- **Secure parameterized queries** preventing SQL injection
- **Comprehensive error handling** and data validation
- **Professional CLI interface** for easy interaction

All functional requirements have been met and demonstrated through both the Python application and raw SQL verification queries.

---

**Good Luck with Your Phase 4 Submission! 🎯**

---

*Last Updated: November 22, 2025*
