from tkinter import *
import tkinter as tk
from tkinter import messagebox
from AeroManageX_AddUser import *
from AeroManageX_DeleteUser import *
from AeroManageX_showAllRecord import showAll
import mysql.connector

from AeroManageX_showSchedDetails import showSchedDetails

# Add your own database name and password here to reflect in the code

mypass = "Savfish4$"
mydatabase = "mydb"
con = mysql.connector.connect(
    host="localhost",
    user="root",
    password=mypass,
    database=mydatabase
)
cur = con.cursor()

def add_flight_to_database(org_departure_time, des_arrival_time, flight_time, passenger_id, confirmation_id,
                           org_airport_id, des_airport_id, plane_id, pilot_id, flight_attendant_id):
    try:
        # Your SQL query to insert flight data into the database
        sql = ("INSERT INTO Flight "
               "(Org_Departure_Time, Des_Arrival_Time, Flight_Time, Passenger_ID, Confirmation_ID, "
               "Org_Airport_ID, Des_Airport_ID, Plane_ID, Pilot_ID, Flight_Att_ID) "
               "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)")

        flight_data = (org_departure_time, des_arrival_time, flight_time, passenger_id, confirmation_id,
                       org_airport_id, des_airport_id, plane_id, pilot_id, flight_attendant_id)

        cur.execute(sql, flight_data)
        con.commit()

        messagebox.showinfo("Success", "Flight added successfully.")
    except mysql.connector.Error as err:
        messagebox.showerror("Error", f"Error: {err}")

def remove_flight_from_database(flight_id):
    try:
        # Your SQL query to delete flight data from the database
        sql = "DELETE FROM Flight WHERE Flight_ID = %s"
        cur.execute(sql, (flight_id,))
        con.commit()

        messagebox.showinfo("Success", "Flight removed successfully.")
    except mysql.connector.Error as err:
        messagebox.showerror("Error", f"Error: {err}")

def add_flight_gui(userId):
    add_flight_window = Toplevel()
    add_flight_window.title("Add Flight Information")
    add_flight_window.geometry("400x400")

    # Labels
    tk.Label(add_flight_window, text="Org Departure Time:").grid(row=0, column=0, padx=10, pady=5)
    tk.Label(add_flight_window, text="Des Arrival Time:").grid(row=1, column=0, padx=10, pady=5)
    tk.Label(add_flight_window, text="Flight Time:").grid(row=2, column=0, padx=10, pady=5)
    tk.Label(add_flight_window, text="Passenger ID:").grid(row=3, column=0, padx=10, pady=5)
    tk.Label(add_flight_window, text="Confirmation ID:").grid(row=4, column=0, padx=10, pady=5)
    tk.Label(add_flight_window, text="Org Airport ID:").grid(row=5, column=0, padx=10, pady=5)
    tk.Label(add_flight_window, text="Des Airport ID:").grid(row=6, column=0, padx=10, pady=5)
    tk.Label(add_flight_window, text="Plane ID:").grid(row=7, column=0, padx=10, pady=5)
    tk.Label(add_flight_window, text="Pilot ID:").grid(row=8, column=0, padx=10, pady=5)
    tk.Label(add_flight_window, text="Flight Attendant ID:").grid(row=9, column=0, padx=10, pady=5)

    # Entry fields
    org_departure_time_entry = tk.Entry(add_flight_window)
    org_departure_time_entry.grid(row=0, column=1, padx=10, pady=5)

    des_arrival_time_entry = tk.Entry(add_flight_window)
    des_arrival_time_entry.grid(row=1, column=1, padx=10, pady=5)

    flight_time_entry = tk.Entry(add_flight_window)
    flight_time_entry.grid(row=2, column=1, padx=10, pady=5)

    passenger_id_entry = tk.Entry(add_flight_window)
    passenger_id_entry.grid(row=3, column=1, padx=10, pady=5)

    confirmation_id_entry = tk.Entry(add_flight_window)
    confirmation_id_entry.grid(row=4, column=1, padx=10, pady=5)

    org_airport_id_entry = tk.Entry(add_flight_window)
    org_airport_id_entry.grid(row=5, column=1, padx=10, pady=5)

    des_airport_id_entry = tk.Entry(add_flight_window)
    des_airport_id_entry.grid(row=6, column=1, padx=10, pady=5)

    plane_id_entry = tk.Entry(add_flight_window)
    plane_id_entry.grid(row=7, column=1, padx=10, pady=5)

    pilot_id_entry = tk.Entry(add_flight_window)
    pilot_id_entry.grid(row=8, column=1, padx=10, pady=5)

    flight_attendant_id_entry = tk.Entry(add_flight_window)
    flight_attendant_id_entry.grid(row=9, column=1, padx=10, pady=5)

    add_flight_button = tk.Button(add_flight_window, text="Add Flight",
                                  command=lambda: add_flight_to_database(org_departure_time_entry.get(),
                                                                         des_arrival_time_entry.get(),
                                                                         flight_time_entry.get(),
                                                                         passenger_id_entry.get(),
                                                                         confirmation_id_entry.get(),
                                                                         org_airport_id_entry.get(),
                                                                         des_airport_id_entry.get(),
                                                                         plane_id_entry.get(),
                                                                         pilot_id_entry.get(),
                                                                         flight_attendant_id_entry.get()))
    add_flight_button.grid(row=10, column=1, pady=10)


def remove_flight_gui(userId):
    remove_flight_window = Toplevel()
    remove_flight_window.title("Remove Flight Information")
    remove_flight_window.geometry("300x200")

    tk.Label(remove_flight_window, text="Enter Flight ID:").pack()

    flight_id_entry = Entry(remove_flight_window)
    flight_id_entry.pack()

    remove_flight_button = Button(remove_flight_window, text="Remove Flight",
                                  command=lambda: remove_flight_from_database(flight_id_entry.get()))
    remove_flight_button.pack()


# Rest of the code remains unchanged

def mainmenu1(userId):
    root = Tk()
    root.title("User_View")
    root.minsize(width=400, height=700)
    root.geometry("600x500")

    # Set background color
    root.configure(bg="#ECF0F1")

    headingFrame1 = Frame(root, bg="#3498DB", bd=5)
    headingFrame1.place(relx=0.2, rely=0.1, relwidth=0.6, relheight=0.16)

    headingLabel = Label(headingFrame1, text="AeroManageX", bg='#3498DB', fg='white', font=('Arial', 24, 'bold'))
    headingLabel.place(relx=0, rely=0, relwidth=1, relheight=1)

    btn1 = Button(root, text="Add a new user", bg='#3498DB', fg='white', 
                  command=lambda: addUser(userId),
                  font=('Arial', 14))
    btn1.place(relx=0.28, rely=0.35, relwidth=0.45, relheight=0.08)  # Reduced relheight and rely

    btn2 = Button(root, text="Show all users", bg='#3498DB', fg='white', 
                  command=lambda: showAll(userId),
                  font=('Arial', 14))
    btn2.place(relx=0.28, rely=0.45, relwidth=0.45, relheight=0.08)  # Adjusted rely

    btn3 = Button(root, text="Show Schedule Details", bg='#3498DB', fg='white', 
                  command=lambda: showSchedDetails(userId),
                  font=('Arial', 14))
    btn3.place(relx=0.28, rely=0.55, relwidth=0.45, relheight=0.08)  # Adjusted rely

    btn4 = Button(root, text="Delete a user", bg='#3498DB', fg='white', 
                  command=delete, font=('Arial', 14))
    btn4.place(relx=0.28, rely=0.65, relwidth=0.45, relheight=0.08)  # Adjusted rely

    btn5 = Button(root, text="Add Flight Information", bg='#3498DB', fg='white', 
                  command=lambda: add_flight_gui(userId),
                  font=('Arial', 14))
    btn5.place(relx=0.28, rely=0.75, relwidth=0.45, relheight=0.08)  # Adjusted rely

    btn6 = Button(root, text="Remove Flight Information", bg='#3498DB', fg='white',
                  command=lambda: remove_flight_gui(userId), font=('Arial', 14))
    btn6.place(relx=0.28, rely=0.85, relwidth=0.45, relheight=0.08)  # Adjusted rely

    root.mainloop()
