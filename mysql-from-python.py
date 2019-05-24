import os
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
    # Run a Query
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        sql = "SELECT * FROM Genre;"
        cursor.execute(sql)
        for row in cursor:
            print(row)
finally:
    # Close the connection, regardless of whether the above successful or not
    connection.close()
    
    