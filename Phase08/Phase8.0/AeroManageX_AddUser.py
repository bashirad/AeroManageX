from tkinter import *
from tkinter import messagebox
from tkinter import Button
import mysql.connector
import hashlib  # For password hashing

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

def userRegister(user_id):
    try:
        user_name = userName.get()
        user_password = userPassword.get()

        cur = con.cursor()
        cur.execute("SELECT COUNT(*) FROM user WHERE user_name = %s", (user_name,))
        user_name_count = cur.fetchone()[0]

        if user_name_count > 0:
            messagebox.showinfo("Info", "User already exists")
            return
        else:
            if user_name != "" and user_password != "":
                hashed_password = hashlib.sha256(user_password.encode()).hexdigest()  # Hash the password
                role_id = 1 if user_id > 0 else 2

                insert_user_query = "INSERT INTO user (user_name, user_password, role_id) VALUES (%s, %s, %s)"
                user_values = (user_name, hashed_password, role_id)

                # Execute the insert query
                with con.cursor() as cur:
                    cur.execute(insert_user_query, user_values)
                    con.commit()

                    if user_id > 0:
                        cur.execute("SELECT user_id FROM user WHERE user_name=%s", (user_name,))
                        contact_user_id = cur.fetchone()[0]

                        insert_user_contacts_query = "INSERT INTO usercontacts (user_id, name) VALUES (%s, %s)"
                        contacts_values = (user_id, user_name)

                        cur.execute(insert_user_contacts_query, contacts_values)
                        con.commit()

                messagebox.showinfo("Info", "Record Inserted")
                root.destroy()
            else:
                messagebox.showinfo("Info", "Enter Valid Records")

    except mysql.connector.Error as err:
        print(f"Error: {err}")

def addUser(args):
    global userName, userPassword, con, root

    root = Tk()
    root.title("Add a User")
    root.minsize(width=400, height=400)
    root.geometry("600x500")

    

    headingFrame1 = Frame(root, bg="#F8F9F9", bd=5)
    headingFrame1.place(relx=0.25, rely=0.1, relwidth=0.5, relheight=0.13)

    headingLabel = Label(headingFrame1, text="ADD A USER", bg='#F8F9F9', fg='black', font=15)
    headingLabel.place(relx=0, rely=0, relwidth=1, relheight=1)

    labelFrame = Frame(root, bg='#F8F9F9')
    labelFrame.place(relx=0.1, rely=0.4, relwidth=0.8, relheight=0.4)

    lb1 = Label(labelFrame, text="User Name : ", bg='#F8F9F9', fg='black')
    lb1.place(relx=0.05, rely=0.02, relheight=0.08)

    userName = Entry(labelFrame)
    userName.place(relx=0.3, rely=0.02, relwidth=0.62, relheight=0.08)

    lb4 = Label(labelFrame, text="User Password", bg='#F8F9F9', fg='black')
    lb4.place(relx=0.05, rely=0.60, relheight=0.08)

    userPassword = Entry(labelFrame)
    userPassword.place(relx=0.3, rely=0.60, relwidth=0.62, relheight=0.08)

    SubmitBtn = Button(root, text="SUBMIT", bg='#82E0AA', fg='black', command=lambda: userRegister(args))
    SubmitBtn.place(relx=0.28, rely=0.9, relwidth=0.18, relheight=0.08)

    quitBtn = Button(root, text="QUIT", bg='#EC7063', fg='black', command=root.destroy)
    quitBtn.place(relx=0.53, rely=0.9, relwidth=0.18, relheight=0.08)

    root.mainloop()

