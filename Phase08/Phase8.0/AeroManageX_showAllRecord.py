from tkinter import *
from tkinter.ttk import Treeview
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


def showAll(userId):
    class A(Frame):
        def __init__(self, parent):
            Frame.__init__(self, parent)
            self.CreateUI()
            self.LoadTable()
            self.grid(sticky=(N, S, W, E))
            parent.grid_rowconfigure(0, weight=1)
            parent.grid_columnconfigure(0, weight=1)

        def CreateUI(self):
            tv = Treeview(self)
            tv['columns'] = ('user_id', 'user_name', 'role_id')
            tv.heading('#0', text='user_id', anchor='center')
            tv.column('#0', anchor='center')
            tv.heading('#1', text='user_name', anchor='center')
            tv.column('#1', anchor='center')
            tv.heading('#2', text='role_id', anchor='center')
            tv.column('#2', anchor='center')
            tv.grid(sticky=(N, S, W, E))
            self.treeview = tv
            self.grid_rowconfigure(0, weight=1)
            self.grid_columnconfigure(0, weight=1)

        def LoadTable(self):
            cur.execute("SELECT * FROM usercontacts WHERE user_id = %s", (userId,))
            result = cur.fetchall()
            user_id = ""
            user_name = ""
            role_id = ""
            for i in result:
                user_id = i[0]
                user_name = i[1]
                role_id = i[2]
                self.treeview.insert("", 'end', text=user_id,
                             values=(user_name, role_id))
    root = Tk()
    root.title("Your contacts")
    A(root)
