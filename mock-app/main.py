import os
import pyodbc

def test_mssql_connectivity(server, user, password, database):
    connection_string = f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={user};PWD={password}"
    
    try:
        # Establishing the connection
        conn = pyodbc.connect(connection_string)
        cursor = conn.cursor()
        
        # Testing a simple query
        cursor.execute("SELECT @@version;")
        row = cursor.fetchone()
        
        if row:
            print(f"Connected! SQL Server version is: {row[0]}")
        conn.close()
    except Exception as e:
        print(f"Connection failed! Error: {e}")

if __name__ == "__main__":
    # Database details
    SERVER = 'localhost'
    USER = 'sa'
    PASSWORD = os.environ.get('SA_PASSWORD')  # Get the password from environment variable
    DATABASE = 'master'
    
    test_mssql_connectivity(SERVER, USER, PASSWORD, DATABASE)