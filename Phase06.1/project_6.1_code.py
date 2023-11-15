import tkinter as tk
from tkinter import messagebox
import mysql.connector

# Function to connect to the MySQL database
def connect_to_database():
    return mysql.connector.connect(
        host="root",
        user="localhost:3306",
        password="Savfish4$",
        database="aeromanagex"
    )

# Function to authenticate user credentials
def authenticate_user(username, password):
    # Replace this with actual authentication logic
    return username == "user" and password == "password"

# Function to change the password for a regular user
def change_password(username):
    new_password = input("Enter your new password: ")

    try:
        connection = connect_to_database()
        cursor = connection.cursor()

        update_query = "UPDATE users SET password = %s WHERE username = %s"
        cursor.execute(update_query, (new_password, username))

        connection.commit()
        print("Password updated successfully!")

    except mysql.connector.Error as err:
        print(f"Error: {err}")

    finally:
        cursor.close()
        connection.close()

# Function to display the login window
def show_login_window():
    login_window = tk.Tk()
    login_window.title("Login Page")

    # Make the window fullscreen
    login_window.attributes("-fullscreen", True)

    # Load the image
    logo_image = tk.PhotoImage(file="C:/logo.png")  # Replace with the actual path to your image

    # Create and place an image widget in the window
    logo_label = tk.Label(login_window, image=logo_image)
    logo_label.grid(row=0, column=0, columnspan=2, padx=10, pady=10)

    label_username = tk.Label(login_window, text="Username:")
    label_username.grid(row=1, column=0, padx=10, pady=10, sticky=tk.W)

    entry_username = tk.Entry(login_window)
    entry_username.grid(row=1, column=1, padx=10, pady=10)

    label_password = tk.Label(login_window, text="Password:")
    label_password.grid(row=2, column=0, padx=10, pady=10, sticky=tk.W)

    entry_password = tk.Entry(login_window, show="*")
    entry_password.grid(row=2, column=1, padx=10, pady=10)

    def login_clicked():
        username = entry_username.get()
        password = entry_password.get()

        if authenticate_user(username, password):
            messagebox.showinfo("Login Successful", "Welcome, {}".format(username))
            login_window.destroy()
            show_main_menu_window()
        else:
            messagebox.showerror("Login Failed", "Invalid username or password")

    login_button = tk.Button(login_window, text="Login", command=login_clicked)
    login_button.grid(row=3, column=0, columnspan=2, pady=10)

    login_window.mainloop()

# Function to display the main menu window
def show_main_menu_window():
    main_menu_window = tk.Tk()
    main_menu_window.title("Main Menu")

    # Make the window fullscreen
    main_menu_window.attributes("-fullscreen", True)

    def handle_menu_choice(choice):
        if choice == "0":
            main_menu_window.destroy()
        elif choice == "1":
            show_insertion_form_window()
        elif choice == "2":
            # Call the corresponding function for deletion
            pass
        elif choice == "6":
            show_change_password_window()
        elif choice == "7":
            show_user_administration_window()
       

    label_menu = tk.Label(main_menu_window, text="Main Menu")
    label_menu.grid(row=0, column=0, columnspan=2, padx=10, pady=10)

    button_insertion = tk.Button(main_menu_window, text="Insertion", command=lambda: handle_menu_choice("1"))
    button_insertion.grid(row=1, column=0, padx=10, pady=10)

    button_deletion = tk.Button(main_menu_window, text="Deletion", command=lambda: handle_menu_choice("2"))
    button_deletion.grid(row=1, column=1, padx=10, pady=10)

    button_change_password = tk.Button(main_menu_window, text="Change Password", command=lambda: handle_menu_choice("6"))
    button_change_password.grid(row=2, column=0, columnspan=2, pady=10)

    button_user_administration = tk.Button(main_menu_window, text="User Administration", command=lambda: handle_menu_choice("7"))
    button_user_administration.grid(row=3, column=0, columnspan=2, pady=10)

    button_log_out = tk.Button(main_menu_window, text="Log Out", command=lambda: handle_menu_choice("0"))
    button_log_out.grid(row=4, column=0, columnspan=2, pady=10)
    
    main_menu_window.mainloop()

# Function to display the insertion form window
def show_insertion_form_window():
    insertion_form_window = tk.Tk()
    insertion_form_window.title("Insertion Form")
    insertion_form_window.attributes("-fullscreen", True)

    def submit_form():
        pass

    button_submit = tk.Button(insertion_form_window, text="Submit", command=submit_form)
    button_submit.pack(pady=10)

    button_back = tk.Button(insertion_form_window, text="Back", command=lambda: insertion_form_window.destroy())
    button_back.pack(pady=10)


    insertion_form_window.mainloop()

# Function to display the change password window
def show_change_password_window():
    change_password_window = tk.Tk()
    change_password_window.title("Change Password")

    

    def submit_password_change():
    
        pass

    button_change_password = tk.Button(change_password_window, text="Change Password", command=submit_password_change)
    button_change_password.pack(pady=10)

    change_password_window.mainloop()

# Function to display the user administration window
def show_user_administration_window():
    user_administration_window = tk.Tk()
    user_administration_window.title("User Administration")
    user_administration_window.attributes("-fullscreen", True)

    def submit_user_administration():
        pass

    button_user_administration = tk.Button(user_administration_window, text="Submit", command=submit_user_administration)
    button_user_administration.pack(pady=10)

    button_back = tk.Button(user_administration_window, text="Back", command=lambda: user_administration_window.destroy())
    button_back.pack(pady=10)


    user_administration_window.mainloop()

# Main function to start the application
def main():
    show_login_window()

main()
