from tkinter import *
from tkinter import ttk, messagebox
import mysql.connector

def connect_to_database():
    mypass = "Savfish4$"
    mydatabase = "mydb"

    try:
        connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password=mypass,
            database=mydatabase
        )
        return connection
    except mysql.connector.Error as err:
        print(f"Error: {err}")
        return None

def search_flights(origin, destination):
    connection = connect_to_database()
    
    if connection:
        try:
            cursor = connection.cursor()
            cursor.execute("SELECT * FROM flight WHERE Org_Airport_ID = %s AND Des_Airport_ID = %s", (origin, destination))
            flights = cursor.fetchall()
            
            if flights:
                show_flight_info_popup(flights)
            else:
                messagebox.showinfo("No Flights", "No flights found for the given criteria.")

        except mysql.connector.Error as err:
            print(f"Error: {err}")
        finally:
            cursor.close()
            connection.close()

def show_flight_info_popup(flights):
    popup = Toplevel()
    popup.title("Flight Information")

    # Define columns
    columns = ("Flight ID", "Departure Date and Time", "Arrival Date and Time")

    # Create Treeview
    tree = ttk.Treeview(popup, columns=columns, show="headings")

    # Set column headings
    for col in columns:
        tree.heading(col, text=col)
        tree.column(col, width=200, anchor="center")  # Adjust width as needed

    # Insert data into the Treeview
    for flight in flights:
        tree.insert("", "end", values=flight)

    tree.pack(expand=YES, fill=BOTH)

def create_search_flights_gui():
    connection = connect_to_database()
    if connection:
        try:
            root = Tk()
            root.title("Flight Search")

            # Create a style for the buttons
            button_style = ttk.Style()
            button_style.configure('TButton', font=('Arial', 12), padding=(10, 5))

            # Labels and Entry widgets for origin and destination
            origin_label = Label(root, text="Origin:")
            origin_label.grid(row=1, column=0, pady=10, padx=10)
            origin_entry = Entry(root)
            origin_entry.grid(row=1, column=1, pady=10, padx=10)

            destination_label = Label(root, text="Destination:")
            destination_label.grid(row=2, column=0, pady=10, padx=10)
            destination_entry = Entry(root)
            destination_entry.grid(row=2, column=1, pady=10, padx=10)

            # Button to trigger the flight search
            search_button = ttk.Button(root, text="Search Flights", command=lambda: search_button_click(origin_entry, destination_entry))
            search_button.grid(row=3, column=0, columnspan=2, pady=10)

            # Calculate center coordinates and set window size
            window_width = 500
            window_height = 250
            x_coordinate = (root.winfo_screenwidth() - window_width) // 2
            y_coordinate = (root.winfo_screenheight() - window_height) // 2
            root.geometry(f"{window_width}x{window_height}+{x_coordinate}+{y_coordinate}")
        except mysql.connector.Error as err:
            print(f"Error: {err}")

def search_button_click(origin_entry, destination_entry):
    origin_value = origin_entry.get()
    destination_value = destination_entry.get()

    if origin_value and destination_value:
        search_flights(origin_value, destination_value)
    else:
        messagebox.showinfo("Error", "Both origin and destination fields are required")

# Create the main window and run the Tkinter event loop
create_search_flights_gui()
