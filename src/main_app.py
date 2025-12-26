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

