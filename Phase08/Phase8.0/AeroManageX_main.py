from tkinter import *
from tkinter import messagebox
from AeroManageX_UserPage import *
from AeroManageX_Admin import create_search_flights_gui
import mysql.connector
from dotenv import load_dotenv
from PIL import Image, ImageTk

import os

load_dotenv()

mypass = os.getenv("DB_PASSWORD")
mydatabase = os.getenv("DB_NAME")

con = mysql.connector.connect(
    host=os.getenv("DB_HOST"),
    user=os.getenv("DB_USER"),
    password=mypass,
    database=mydatabase
)

cur = con.cursor()

root = Tk()
root.title("Login")
root.geometry("600x480")


headingFrame1 = Frame(root, bg="#3498DB", bd=5)
headingFrame1.place(relx=0.2, rely=0.1, relwidth=0.6, relheight=0.16)

headingLabel = Label(headingFrame1, text="AeroManageX", bg='#3498DB', fg='white', font=('Arial', 24, 'bold'))
headingLabel.place(relx=0, rely=0, relwidth=1, relheight=1)


def callClient():
    usern = username_box.get()
    passw = password_box.get()

    if usern == "" or passw == "":
        messagebox.showinfo("Error", "All fields are required")
    else:
        try:
            cur.execute("select * from user where user_name=%s and user_password=%s", (usern, passw))
            op = cur.fetchone()
            print(op[1])
            if op is None:
                messagebox.showinfo("Error", "Invalid Username or Password")
            else:
                root.destroy()
                create_search_flights_gui()  
        except Exception as es:
            messagebox.showerror("Error", f"Error Due to: {str(es)}")

            
def callUser():
    usern = username_box.get()
    passw = password_box.get()

    if usern == "" or passw == "":
        messagebox.showinfo("Error", "All fields are required")
    else:
        try:
            cur.execute("select * from user where user_name=%s and user_password=%s", (usern, passw))
            op = cur.fetchone()
            if op == None:
                messagebox.showinfo("Error", "Invalid Username or Password")
            else:
                root.destroy()
                mainmenu1(op[0])
        except Exception as es:
            messagebox.showerror("Error", f"Error Due to: {str(es)}")

del_frame = Frame(root, bd=4, relief=RIDGE, bg="#BBD8FF")
del_frame.place(x=100, y=150, width=400, height=180)  # Adjusteprint("")d y coordinate

username = Label(del_frame, text="USERNAME", bg="#BBD8FF", fg="black", font=15)
username.grid(row=12, column=0, sticky=W, padx=10, pady=10)
password = Label(del_frame, text="PASSWORD", bg="#BBD8FF", fg="black", font=15)
password.grid(row=14, column=0, sticky=W, padx=10, pady=10)

global username_box
username_box = Entry(del_frame, font=15, bd=5, relief=GROOVE)
username_box.grid(row=12, column=1, pady=10, padx=10, sticky="w")
global password_box
password_box = Entry(del_frame, font=15, bd=5, relief=GROOVE, show='*')  # Set show attribute to '*'
password_box.grid(row=14, column=1, pady=10, padx=10, sticky="w")

client_login = Button(del_frame, 
                      text="Client Login", bg="white", fg="black", font=15, command=callClient)
client_login.grid(row=20, column=0, pady=10, padx=10)

admin_login = Button(del_frame, 
                     text="Admin Login", bg="white", fg="black", font=15, command=callUser)
admin_login.grid(row=20, column=1, pady=10, padx=10)

root.mainloop()
