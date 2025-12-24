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
