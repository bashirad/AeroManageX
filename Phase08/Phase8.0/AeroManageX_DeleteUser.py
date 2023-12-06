from tkinter import *
from tkinter import messagebox
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

def delete():
    global userInfo, Canvas1, con, cur, root

    root = Tk()
    root.title("Delete")
    root.minsize(width=400, height=400)
    root.geometry("600x500")

    Canvas1 = Canvas(root)
    Canvas1.config(bg="#FDFEFE")
    Canvas1.pack(expand=True, fill=BOTH)

    headingFrame1 = Frame(root, bg="#FDFEFE", bd=5)
    headingFrame1.place(relx=0.25, rely=0.1, relwidth=0.5, relheight=0.13)

    headingLabel = Label(headingFrame1, text="Delete An Existing User", bg='#FDFEFE', fg='black', font=15)
    headingLabel.place(relx=0, rely=0, relwidth=1, relheight=1)

    labelFrame = Frame(root, bg='#FDFEFE')
    labelFrame.place(relx=0.1, rely=0.3, relwidth=0.8, relheight=0.5)

    lb1 = Label(labelFrame, text="Enter user name: ", bg='#FDFEFE', fg='black')
    lb1.place(relx=0.05, rely=0.5)

    userInfo = Entry(labelFrame)
    userInfo.place(relx=0.3, rely=0.5, relwidth=0.62)

    SubmitBtn = Button(root, text="Delete", bg='#d1ccc0', fg='black', command=deleteUser)
    SubmitBtn.place(relx=0.28, rely=0.9, relwidth=0.18, relheight=0.08)

    quitBtn = Button(root, text="Quit", bg='#f7f1e3', fg='black', command=root.destroy)
    quitBtn.place(relx=0.53, rely=0.9, relwidth=0.18, relheight=0.08)

    root.mainloop()

def deleteUser():
    userName = userInfo.get()
    print(userName)
    getUserId = "SELECT user_id FROM user WHERE user_name = %s"
    print(getUserId)
    deleteByUserName = "DELETE FROM user WHERE user_name = %s"

    try:
        # Execute the getUserId query
        cur.execute(getUserId, (userName,))
        result = cur.fetchone()

        # Check if the user was found
        if result:
            user_id = result[0]

            # Execute the deleteJunctionTableRecords query
            deleteJunctionTableRecords = "DELETE FROM user WHERE user_id = %s"
            cur.execute(deleteJunctionTableRecords, (user_id,))

            # Execute the deleteByUserName query
            cur.execute(deleteByUserName, (userName,))
            
            # Commit the changes
            con.commit()

            # Display a message
            messagebox.showinfo("Information", "Record Deleted")
        else:
            messagebox.showinfo("Error", "User not found")

    except Exception as e:
        messagebox.showinfo("Error", str(e))
        print(f"Failed SQL Query: {getUserId} with parameters: {userName}")



