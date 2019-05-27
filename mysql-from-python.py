import os
import datetime
import pymysql

# Get username from Cloud9 workspace
# (modify this variable if running on another environment)
username = os.getenv("C9_USER")

# Connect to the Database
connection = pymysql.connect(host="localhost",
                             user=username,
                             password="",
                             db="Chinook")

try:
    # Run a Query [using 'dictionary' result (default is tuple)]
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        sql = "SELECT * FROM Genre;"
        cursor.execute(sql)
        for row in cursor:
            print(row)
    
    # Create a table
    with connection.cursor() as cursor:
        cursor.execute("""CREATE TABLE IF NOT EXISTS
                          Friends(name char(20), age int, DOB datetime);""")
        # Note that the above will still display a warning (not error) if the
        # table already exists
    
    # Insert Into the table (single row)
    with connection.cursor() as cursor:
        row = ("Bob", 21, "1999-05-21 22:22:22")
        cursor.execute("INSERT INTO Friends VALUES (%s, %s, %s);", row)
        connection.commit()
        
    # Insert Into table multiple rows ('execute many')
    with connection.cursor() as cursor:
        rows = [ ("Jim", 56, "1955-05-09"), ("Kevin", 40, "1978-10-21"), ("Jodie", 30, "1989-05-28") ]
        cursor.executemany("INSERT INTO Friends VALUES (%s, %s, %s);", rows)
        connection.commit()
    
    # Update Table at specific field / record
    with connection.cursor() as cursor:
        cursor.execute("UPDATE Friends SET age = 22 WHERE name = 'bob';")
        connection.commit()
    
    # Alternate Update with string interpolation
    with connection.cursor() as cursor:
        cursor.execute("UPDATE Friends SET age = %s WHERE name = %s;",
                        (23, 'Bob'))
        connection.commit()
    
    # Update Many at once
    with connection.cursor() as cursor:
        rows = [ (24, 'Bob'), (33, 'Kevin'), (21, 'Jodie') ]
        cursor.executemany("UPDATE Friends SET age = %s WHERE name = %s;", rows)
        connection.commit()
    
    # Delete a row or record from the table
    with connection.cursor() as cursor:
        cursor.execute("DELETE FROM Friends WHERE name = 'Bob';")
        connection.commit()
        
    # Delete many with string interpolation
    with connection.cursor() as cursor:
        cursor.executemany("DELETE FROM Friends WHERE name = %s;", ['Bob', 'Jim'])
        connection.commit()
    
    # Dynamically delete using interpolation & python
    with connection.cursor() as cursor:
        list_of_names = ['Kevin', 'Jodie']
        # Prepare a string with the same number of placeholders in list_of_names
        format_string = ','.join(['%s']*len(list_of_names))
        cursor.execute("DELETE FROM Friends WHERE name IN ({});".format(format_string), list_of_names)
        connection.commit()
finally:
    connection.close()
    
    