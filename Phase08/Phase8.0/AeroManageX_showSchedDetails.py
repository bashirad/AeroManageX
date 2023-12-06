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


def showSchedDetails(userId):
    class B(Frame):
        def __init__(self, parent):
            Frame.__init__(self, parent)
            self.CreateUI()
            self.LoadTable()
            self.grid(sticky=(N, S, W, E))
            parent.grid_rowconfigure(0, weight=1)
            parent.grid_columnconfigure(0, weight=1)

        def CreateUI(self):
            tv = Treeview(self)
            tv['columns'] = ('id', 'fname', 'lname', 'confirmation', 'bookingDate', 
                             'platform', 'flightNo')
            tv.heading('#0', text='id', anchor='center')
            tv.column('#0', anchor='center')
            tv.heading('#1', text='fname', anchor='center')
            tv.column('#1', anchor='center')
            tv.heading('#2', text='lname', anchor='center')
            tv.column('#2', anchor='center')
            tv.heading('#3', text='confirmation', anchor='center')
            tv.column('#3', anchor='center')
            tv.heading('#4', text='bookingDate', anchor='center')
            tv.column('#4', anchor='center')
            tv.heading('#5', text='platform', anchor='center')
            tv.column('#5', anchor='center')
            tv.heading('#6', text='flightNo', anchor='center')
            tv.column('#6', anchor='center')
            tv.grid(sticky=(N, S, W, E))
            self.treeview = tv
            self.grid_rowconfigure(0, weight=1)
            self.grid_columnconfigure(0, weight=1)

        def LoadTable(self):
            cur.execute("SELECT * FROM scheduleDetailsView")
            result = cur.fetchall()
            id = ""
            fname = ""
            lname = ""
            confirmation = ""
            bookingDate = ""
            platform = ""
            flightNo = ""
            for i in result:
                id = i[0]
                fname = i[1]
                lname = i[2]
                confirmation = i[3]
                bookingDate = i[4]
                platform = i[5]
                flightNo = i[6]
                self.treeview.insert("", 'end', text=id,
                                values=(fname, lname, confirmation, bookingDate, 
                                        platform, flightNo,))
    root = Tk()
    root.title("Schedule Details")
    B(root)
