#!/bin/bash
# Mahabharat Database - Complete Automated Setup Script
# Run this script to set up the entire database from scratch

set -e  # Exit on any error

echo "=================================================================="
echo "     MAHABHARAT DATABASE - AUTOMATED SETUP"
echo "=================================================================="
echo ""

# Configuration
DB_USER="root"
DB_PASS="Manik69*"
DB_NAME="mahabharat_db"

echo "Step 1/5: Dropping existing database (if any)..."
mysql -u $DB_USER -p$DB_PASS -e "DROP DATABASE IF EXISTS $DB_NAME;" 2>/dev/null
echo "✓ Old database dropped"
echo ""

echo "Step 2/5: Creating fresh database..."
mysql -u $DB_USER -p$DB_PASS -e "CREATE DATABASE $DB_NAME;" 2>/dev/null
echo "✓ Database '$DB_NAME' created"
echo ""

echo "Step 3/5: Loading schema (creating 18 tables)..."
mysql -u $DB_USER -p$DB_PASS $DB_NAME < schema.sql 2>/dev/null
echo "✓ Schema loaded successfully"
echo ""

echo "Step 4/5: Populating data..."
mysql -u $DB_USER -p$DB_PASS $DB_NAME < populate.sql 2>/dev/null
echo "✓ Data populated successfully"
echo ""

echo "Step 5/5: Verifying database..."
echo ""
echo "Tables created:"
mysql -u $DB_USER -p$DB_PASS $DB_NAME -e "SHOW TABLES;" 2>/dev/null
echo ""

echo "Data counts:"
mysql -u $DB_USER -p$DB_PASS $DB_NAME -e "
SELECT 'Warriors' as Table_Name, COUNT(*) as Count FROM Warrior
UNION ALL SELECT 'Factions', COUNT(*) FROM Faction
UNION ALL SELECT 'Kingdoms', COUNT(*) FROM Kingdom
UNION ALL SELECT 'Battles', COUNT(*) FROM Battle
UNION ALL SELECT 'Astras', COUNT(*) FROM Astra
UNION ALL SELECT 'Vyuhas', COUNT(*) FROM Vyuha;" 2>/dev/null
echo ""

echo "Sample warriors (oldest 5):"
mysql -u $DB_USER -p$DB_PASS $DB_NAME -e "
SELECT name, age, dob, status 
FROM Warrior 
ORDER BY dob 
LIMIT 5;" 2>/dev/null
echo ""

echo "=================================================================="
echo "✓ DATABASE SETUP COMPLETE!"
echo "=================================================================="
echo ""
echo "You can now run the application:"
echo "  python3 main_app.py"
echo ""
