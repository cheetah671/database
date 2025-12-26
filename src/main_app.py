#!/usr/bin/env python3
"""
Mahabharat Mini-World Database - CLI Application
Phase 4 - Database Interface

This application provides a command-line interface to interact with the Mahabharat database.
Implements minimum 5 read queries and 3 write operations using raw SQL.

Requirements: pymysql
Run: python3 src/main_app.py
"""

import sys
from getpass import getpass
import pymysql
from datetime import datetime


def get_db_connection(db_user, db_pass, db_host, db_name):
    """Establishes a connection to the MySQL database."""
    try:
        connection = pymysql.connect(
            host=db_host,
            user=db_user,
            password=db_pass,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor,
            autocommit=False
        )
        print("✓ Database connection successful.")
        return connection
    except pymysql.Error as e:
        print(f"✗ Error connecting to MySQL Database: {e}", file=sys.stderr)
        return None


def print_separator():
    """Print a visual separator."""
    print("\n" + "="*70)


def print_results(results, title="Results"):
    """Pretty print query results."""
    print(f"\n{title}:")
    print("-" * 70)
    if not results:
        print("No data found.")
        return
    
    for idx, row in enumerate(results, 1):
        print(f"\n[{idx}]")
        for key, value in row.items():
            print(f"  {key}: {value}")
    print(f"\nTotal records: {len(results)}")
# ============================================================================
# READ OPERATIONS (Queries)
# ============================================================================

def query1_warriors_by_kingdom(connection):
    """
    Query 1: List all warriors from a specific kingdom
    Shows warrior details including their status and classification.
    """
    print_separator()
    print("QUERY 1: List Warriors by Kingdom")
    print_separator()
    
    kingdom_name = input("Enter kingdom name (e.g., Indraprastha, Hastinapura): ").strip()
    
    sql = """
        SELECT 
            w.name AS warrior_name,
            w.title,
            w.age,
            w.status,
            w.classification,
            k.name AS kingdom,
            k.capital_city
        FROM Warrior w
        LEFT JOIN Kingdom k ON w.kingdom_id = k.id
        WHERE k.name = %s
        ORDER BY w.status, w.name
    """
    
    try:
        with connection.cursor() as cursor:
            cursor.execute(sql, (kingdom_name,))
            results = cursor.fetchall()
            print_results(results, f"Warriors from {kingdom_name}")
    except pymysql.Error as e:
        print(f"Error executing query: {e}", file=sys.stderr)


def query2_warrior_astras(connection):
    """
    Query 2: Show all astras known by a specific warrior
    Displays the divine weapons a warrior can use.
    """
    print_separator()
    print("QUERY 2: Warrior's Astras (Divine Weapons)")
    print_separator()
    
    warrior_name = input("Enter warrior name (e.g., Arjuna, Karna): ").strip()
    
    sql = """
        SELECT 
            w.name AS warrior,
            a.name AS astra_name,
            a.type AS astra_type,
            a.description
        FROM Warrior w
        JOIN Warrior_Astra wa ON w.id = wa.warrior_id
        JOIN Astra a ON wa.astra_id = a.id
        WHERE w.name = %s
        ORDER BY a.type, a.name
    """
    
    try:
        with connection.cursor() as cursor:
            cursor.execute(sql, (warrior_name,))
            results = cursor.fetchall()
            print_results(results, f"Astras known by {warrior_name}")
    except pymysql.Error as e:
        print(f"Error executing query: {e}", file=sys.stderr)


def query3_battle_formations(connection):
    """
    Query 3: Show vyuhas (formations) deployed in a specific battle
    Lists commanders and their battle formations.
    """
    print_separator()
    print("QUERY 3: Battle Formations (Vyuhas) Deployed")
    print_separator()
    
    battle_name = input("Enter battle name (e.g., 'Kurukshetra Day 13'): ").strip()
    
    sql = """
        SELECT 
            b.name AS battle,
            b.date AS battle_date,
            f.name AS faction,
            v.name AS vyuha,
            v.complexity_level,
            w.name AS commander
        FROM Commander_Deploys_Vyuha cdv
        JOIN Battle b ON cdv.battle_id = b.id
        JOIN Faction f ON cdv.faction_id = f.id
        JOIN Vyuha v ON cdv.vyuha_id = v.id
        JOIN Warrior w ON cdv.commander_id = w.id
        WHERE b.name = %s
        ORDER BY f.name, v.complexity_level DESC
    """
    
    try:
        with connection.cursor() as cursor:
            cursor.execute(sql, (battle_name,))
            results = cursor.fetchall()
            print_results(results, f"Formations in {battle_name}")
    except pymysql.Error as e:
        print(f"Error executing query: {e}", file=sys.stderr)


def query4_astra_duels(connection):
    """
    Query 4: Show all astra usages in battles (duels)
    Displays which warriors used which astras against whom.
    """
    print_separator()
    print("QUERY 4: Astra Usage in Duels")
    print_separator()
    
    sql = """
        SELECT 
            b.name AS battle,
            attacker.name AS attacker,
            defender.name AS defender,
            a.name AS astra_used,
            a.type AS astra_type
        FROM Uses_Astra_In_Duel uad
        JOIN Battle b ON uad.battle_id = b.id
        JOIN Warrior attacker ON uad.attacker_id = attacker.id
        JOIN Warrior defender ON uad.defender_id = defender.id
        JOIN Astra a ON uad.astra_id = a.id
        ORDER BY b.date, attacker.name
    """
    
    try:
        with connection.cursor() as cursor:
            cursor.execute(sql)
            results = cursor.fetchall()
            print_results(results, "All Astra Duels")
    except pymysql.Error as e:
        print(f"Error executing query: {e}", file=sys.stderr)


def query5_maharathi_warriors(connection):
    """
    Query 5: List all Maharathi warriors with their special abilities
    Shows elite warriors and their mastery status.
    """
    print_separator()
    print("QUERY 5: Maharathi Warriors (Elite Class)")
    print_separator()
    
    sql = """
        SELECT 
            w.name AS warrior,
            w.title,
            w.age,
            w.status,
            m.mastery_of_all_astras,
            k.name AS kingdom,
            COUNT(DISTINCT wa.astra_id) AS total_astras_known
        FROM Maharathi m
        JOIN Warrior w ON m.warrior_id = w.id
        LEFT JOIN Kingdom k ON w.kingdom_id = k.id
        LEFT JOIN Warrior_Astra wa ON w.id = wa.warrior_id
        GROUP BY w.id, w.name, w.title, w.age, w.status, 
                 m.mastery_of_all_astras, k.name
        ORDER BY m.mastery_of_all_astras DESC, total_astras_known DESC
    """
    
    try:
        with connection.cursor() as cursor:
            cursor.execute(sql)
            results = cursor.fetchall()
            print_results(results, "Maharathi Warriors")
    except pymysql.Error as e:
        print(f"Error executing query: {e}", file=sys.stderr)


def query6_warrior_skills(connection):
    """
    Query 6: Show all skills of a specific warrior
    """
    print_separator()
    print("QUERY 6: Warrior Skills")
    print_separator()
    
    warrior_name = input("Enter warrior name: ").strip()
    
    sql = """
        SELECT 
            w.name AS warrior,
            w.classification,
            ws.skill_name
        FROM Warrior w
        JOIN Warrior_Skills ws ON w.id = ws.warrior_id
        WHERE w.name = %s
        ORDER BY ws.skill_name
    """
    
    try:
        with connection.cursor() as cursor:
            cursor.execute(sql, (warrior_name,))
            results = cursor.fetchall()
            print_results(results, f"Skills of {warrior_name}")
    except pymysql.Error as e:
        print(f"Error executing query: {e}", file=sys.stderr)


def query7_faction_summary(connection):
    """
    Query 7: Show faction summary with warrior count and victories
    """
    print_separator()
    print("QUERY 7: Faction Summary")
    print_separator()
    
    sql = """
        SELECT 
            f.name AS faction,
            f.allegiance,
            COUNT(DISTINCT k.id) AS total_kingdoms,
            COUNT(DISTINCT w.id) AS total_warriors,
            COUNT(DISTINCT CASE WHEN w.status = 'active' THEN w.id END) AS active_warriors,
            COUNT(DISTINCT CASE WHEN w.status = 'fallen' THEN w.id END) AS fallen_warriors,
            COUNT(DISTINCT b.id) AS battles_won
        FROM Faction f
        LEFT JOIN Kingdom k ON f.id = k.faction_id
        LEFT JOIN Warrior w ON k.id = w.kingdom_id
        LEFT JOIN Battle b ON f.id = b.victor_faction
        GROUP BY f.id, f.name, f.allegiance
        ORDER BY total_warriors DESC
    """
    
    try:
        with connection.cursor() as cursor:
            cursor.execute(sql)
            results = cursor.fetchall()
            print_results(results, "Faction Summary")
    except pymysql.Error as e:
        print(f"Error executing query: {e}", file=sys.stderr)

# ============================================================================
# WRITE OPERATIONS (INSERT, UPDATE, DELETE)
# ============================================================================

def insert_new_warrior(connection):
    """
    INSERT Operation: Add a new warrior to the database
    """
    print_separator()
    print("INSERT: Add New Warrior")
    print_separator()
    
    name = input("Warrior name: ").strip()
    age_input = input("Age (press Enter to skip): ").strip()
    age = int(age_input) if age_input else None
    
    print("Status options: active, fallen, retired")
    status = input("Status (default: active): ").strip() or 'active'
    
    dob_input = input("Date of birth (YYYY-MM-DD, press Enter to skip): ").strip()
    dob = dob_input if dob_input else None
    
    classification = input("Classification (e.g., Maharathi, Atirathi): ").strip() or None
    title = input("Title: ").strip() or None
    
    kingdom_name = input("Kingdom name (press Enter to skip): ").strip()
    chariot_name = input("Chariot name (press Enter to skip): ").strip()
    
    try:
        with connection.cursor() as cursor:
            # Get kingdom_id if provided
            kingdom_id = None
            if kingdom_name:
                cursor.execute("SELECT id FROM Kingdom WHERE name = %s", (kingdom_name,))
                kingdom_row = cursor.fetchone()
                if kingdom_row:
                    kingdom_id = kingdom_row['id']
                else:
                    print(f"Warning: Kingdom '{kingdom_name}' not found. Setting NULL.")
            
            # Get chariot_id if provided
            chariot_id = None
            if chariot_name:
                cursor.execute("SELECT id FROM Chariot WHERE name = %s", (chariot_name,))
                chariot_row = cursor.fetchone()
                if chariot_row:
                    chariot_id = chariot_row['id']
                else:
                    print(f"Warning: Chariot '{chariot_name}' not found. Setting NULL.")
            
            # Insert warrior
            sql = """
                INSERT INTO Warrior (name, age, status, dob, classification, title, kingdom_id, chariot_id)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(sql, (name, age, status, dob, classification, title, kingdom_id, chariot_id))
            connection.commit()
            
            print(f"\n✓ Successfully added warrior '{name}' (ID: {cursor.lastrowid})")
            
    except pymysql.IntegrityError as e:
        connection.rollback()
        print(f"✗ Error: Warrior with name '{name}' may already exist. {e}")
    except pymysql.Error as e:
        connection.rollback()
        print(f"✗ Error inserting warrior: {e}", file=sys.stderr)


def update_warrior_status(connection):
    """
    UPDATE Operation: Change a warrior's status
    """
    print_separator()
    print("UPDATE: Change Warrior Status")
    print_separator()
    
    warrior_name = input("Warrior name: ").strip()
    
    print("\nStatus options: active, fallen, retired")
    new_status = input("New status: ").strip()
    
    if new_status not in ['active', 'fallen', 'retired']:
        print("✗ Invalid status. Must be: active, fallen, or retired")
        return
    
    try:
        with connection.cursor() as cursor:
            sql = "UPDATE Warrior SET status = %s WHERE name = %s"
            cursor.execute(sql, (new_status, warrior_name))
            
            if cursor.rowcount == 0:
                print(f"✗ No warrior found with name '{warrior_name}'")
                connection.rollback()
            else:
                connection.commit()
                print(f"✓ Successfully updated {warrior_name}'s status to '{new_status}'")
                
    except pymysql.Error as e:
        connection.rollback()
        print(f"✗ Error updating warrior: {e}", file=sys.stderr)


def delete_warrior_skill(connection):
    """
    DELETE Operation: Remove a skill from a warrior
    """
    print_separator()
    print("DELETE: Remove Warrior Skill")
    print_separator()
    
    warrior_name = input("Warrior name: ").strip()
    skill_name = input("Skill to remove: ").strip()
    
    try:
        with connection.cursor() as cursor:
            # First get warrior_id
            cursor.execute("SELECT id FROM Warrior WHERE name = %s", (warrior_name,))
            warrior = cursor.fetchone()
            
            if not warrior:
                print(f"✗ Warrior '{warrior_name}' not found")
                return
            
            warrior_id = warrior['id']
            
            # Delete the skill
            sql = "DELETE FROM Warrior_Skills WHERE warrior_id = %s AND skill_name = %s"
            cursor.execute(sql, (warrior_id, skill_name))
            
            if cursor.rowcount == 0:
                print(f"✗ Skill '{skill_name}' not found for warrior '{warrior_name}'")
                connection.rollback()
            else:
                connection.commit()
                print(f"✓ Successfully removed skill '{skill_name}' from {warrior_name}")
                
    except pymysql.Error as e:
        connection.rollback()
        print(f"✗ Error deleting skill: {e}", file=sys.stderr)


def insert_warrior_skill(connection):
    """
    INSERT Operation: Add a new skill to a warrior
    """
    print_separator()
    print("INSERT: Add Warrior Skill")
    print_separator()
    
    warrior_name = input("Warrior name: ").strip()
    skill_name = input("Skill to add: ").strip()
    
    try:
        with connection.cursor() as cursor:
            # Get warrior_id
            cursor.execute("SELECT id FROM Warrior WHERE name = %s", (warrior_name,))
            warrior = cursor.fetchone()
            
            if not warrior:
                print(f"✗ Warrior '{warrior_name}' not found")
                return
            
            warrior_id = warrior['id']
            
            # Insert skill
            sql = "INSERT INTO Warrior_Skills (warrior_id, skill_name) VALUES (%s, %s)"
            cursor.execute(sql, (warrior_id, skill_name))
            connection.commit()
            
            print(f"✓ Successfully added skill '{skill_name}' to {warrior_name}")
            
    except pymysql.IntegrityError:
        connection.rollback()
        print(f"✗ Skill '{skill_name}' already exists for {warrior_name}")
    except pymysql.Error as e:
        connection.rollback()
        print(f"✗ Error adding skill: {e}", file=sys.stderr)


def update_chariot_status(connection):
    """
    UPDATE Operation: Change chariot status
    """
    print_separator()
    print("UPDATE: Change Chariot Status")
    print_separator()
    
    chariot_name = input("Chariot name: ").strip()
    
    print("\nStatus options: active, destroyed, retired")
    new_status = input("New status: ").strip()
    
    if new_status not in ['active', 'destroyed', 'retired']:
        print("✗ Invalid status. Must be: active, destroyed, or retired")
        return
    
    try:
        with connection.cursor() as cursor:
            sql = "UPDATE Chariot SET status = %s WHERE name = %s"
            cursor.execute(sql, (new_status, chariot_name))
            
            if cursor.rowcount == 0:
                print(f"✗ No chariot found with name '{chariot_name}'")
                connection.rollback()
            else:
                connection.commit()
                print(f"✓ Successfully updated {chariot_name}'s status to '{new_status}'")
                
    except pymysql.Error as e:
        connection.rollback()
        print(f"✗ Error updating chariot: {e}", file=sys.stderr)


def delete_boon_curse(connection):
    """
    DELETE Operation: Remove a boon/curse from a warrior
    """
    print_separator()
    print("DELETE: Remove Boon/Curse from Warrior")
    print_separator()
    
    warrior_name = input("Warrior name: ").strip()
    boon_curse_name = input("Boon/Curse name to remove: ").strip()
    
    try:
        with connection.cursor() as cursor:
            # Get warrior_id
            cursor.execute("SELECT id FROM Warrior WHERE name = %s", (warrior_name,))
            warrior = cursor.fetchone()
            
            if not warrior:
                print(f"✗ Warrior '{warrior_name}' not found")
                return
            
            warrior_id = warrior['id']
            
            # Delete the boon/curse
            sql = "DELETE FROM Boon_Curse WHERE warrior_id = %s AND name = %s"
            cursor.execute(sql, (warrior_id, boon_curse_name))
            
            if cursor.rowcount == 0:
                print(f"✗ Boon/Curse '{boon_curse_name}' not found for {warrior_name}")
                connection.rollback()
            else:
                connection.commit()
                print(f"✓ Successfully removed '{boon_curse_name}' from {warrior_name}")
                
    except pymysql.Error as e:
        connection.rollback()
        print(f"✗ Error deleting boon/curse: {e}", file=sys.stderr)


# ============================================================================
# MAIN CLI
# ============================================================================

def main_cli(connection):
    """The main command-line interface loop."""
    try:
        while True:
            print_separator()
            print("     MAHABHARAT MINI-WORLD DATABASE")
            print_separator()
            print("\n📖 READ OPERATIONS (Queries):")
            print("  1. List warriors by kingdom")
            print("  2. Show warrior's astras (divine weapons)")
            print("  3. Show battle formations (vyuhas) deployed")
            print("  4. Show astra usage in duels")
            print("  5. List Maharathi warriors (elite class)")
            print("  6. Show warrior skills")
            print("  7. Show faction summary")
            
            print("\n✏️  WRITE OPERATIONS:")
            print("  8. INSERT: Add new warrior")
            print("  9. INSERT: Add skill to warrior")
            print(" 10. UPDATE: Change warrior status")
            print(" 11. UPDATE: Change chariot status")
            print(" 12. DELETE: Remove warrior skill")
            print(" 13. DELETE: Remove boon/curse from warrior")
            
            print("\n  q. Quit")
            print_separator()
            
            choice = input("\nEnter your choice: ").strip().lower()
            
            if choice == '1':
                query1_warriors_by_kingdom(connection)
            elif choice == '2':
                query2_warrior_astras(connection)
            elif choice == '3':
                query3_battle_formations(connection)
            elif choice == '4':
                query4_astra_duels(connection)
            elif choice == '5':
                query5_maharathi_warriors(connection)
            elif choice == '6':
                query6_warrior_skills(connection)
            elif choice == '7':
                query7_faction_summary(connection)
            elif choice == '8':
                insert_new_warrior(connection)
            elif choice == '9':
                insert_warrior_skill(connection)
            elif choice == '10':
                update_warrior_status(connection)
            elif choice == '11':
                update_chariot_status(connection)
            elif choice == '12':
                delete_warrior_skill(connection)
            elif choice == '13':
                delete_boon_curse(connection)
            elif choice == 'q':
                print("\n👋 Exiting application. Thank you!")
                break
            else:
                print("✗ Invalid choice. Please try again.")
                
    finally:
        if connection:
            connection.close()
            print("✓ Database connection closed.")


if __name__ == "__main__":
    DB_HOST = 'localhost'
    DB_NAME = 'mahabharat_db'
    
    print_separator()
    print("     MAHABHARAT DATABASE - PHASE 4")
    print_separator()
    
    # Default credentials for demonstration
    DB_USER = "root"
    DB_PASS = "Manik69*"
    
    print("\nConnecting to database with default credentials...")
    
    db_conn = get_db_connection(DB_USER, DB_PASS, DB_HOST, DB_NAME)
    
    if db_conn:
        main_cli(db_conn)
    else:
        print("✗ Failed to connect to the database. Application will exit.")
        sys.exit(1)


