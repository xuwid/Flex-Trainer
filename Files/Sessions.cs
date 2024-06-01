﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;
using static LoginForm.LoginForm;

namespace LoginForm
{
    public partial class Sessions : Form
    {
        private int loggedInUserID; // Define a variable to store the logged-in user's ID

        public Sessions()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            // Code for button2 click event (if any)
        }

        private void button1_Click(object sender, EventArgs e)
        {
            NewSession newSession = new NewSession();
            newSession.Show();
        }

        private void Sessions_Load(object sender, EventArgs e)
        {
            // Retrieve the logged-in user's ID
            loggedInUserID = GlobalVariables.LoggedInUserID;

            try
            {
                string connectionString = "Data Source=DESKTOP-U9S8MFO\\SQLEXPRESS02;Initial Catalog=GYMDATABASE;Integrated Security=True;";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Query to retrieve personal training sessions for the logged-in user
                    string query = "SELECT * FROM AppointmentWithClients WHERE Member_ID = @LoggedInUserID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add parameter for MemberID (using the logged-in user's ID)
                        cmd.Parameters.AddWithValue("@LoggedInUserID", loggedInUserID);

                        // Create a DataTable to hold the query results
                        DataTable dt = new DataTable();

                        // Fill the DataTable with the query results
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        adapter.Fill(dt);

                        // Display the query results in the DataGridView
                        dataGridView1.DataSource = dt;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An error occurred while fetching personal training sessions: {ex.Message}");
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            loggedInUserID = GlobalVariables.LoggedInUserID;

            try
            {
                string connectionString = "Data Source=DESKTOP-U9S8MFO\\SQLEXPRESS02;Initial Catalog=GYMDATABASE;Integrated Security=True;";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Query to retrieve personal training sessions for the logged-in user
                    string query = "SELECT * FROM AppointmentWithClients WHERE Member_ID = @LoggedInUserID";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add parameter for MemberID (using the logged-in user's ID)
                        cmd.Parameters.AddWithValue("@LoggedInUserID", loggedInUserID);

                        // Create a DataTable to hold the query results
                        DataTable dt = new DataTable();

                        // Fill the DataTable with the query results
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        adapter.Fill(dt);

                        // Display the query results in the DataGridView
                        dataGridView1.DataSource = dt;
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An error occurred while fetching personal training sessions: {ex.Message}");
            }
        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            // Check if any row is selected in the DataGridView
            if (dataGridView1.SelectedRows.Count > 0)
            {
                // Get the AppointmentID from the selected row
                int appointmentID = Convert.ToInt32(dataGridView1.SelectedRows[0].Cells["AppointmentID"].Value);

                // Prompt the user for confirmation
                DialogResult result = MessageBox.Show("Are you sure you want to cancel this appointment?", "Confirmation", MessageBoxButtons.YesNo, MessageBoxIcon.Question);

                if (result == DialogResult.Yes)
                {
                    try
                    {
                        // Connection string
                        string connectionString = "Data Source=DESKTOP-U9S8MFO\\SQLEXPRESS02;Initial Catalog=GYMDATABASE;Integrated Security=True;";

                        // SQL command to delete the appointment
                        string query = "DELETE FROM AppointmentWithClients WHERE AppointmentID = @AppointmentID";

                        using (SqlConnection conn = new SqlConnection(connectionString))
                        {
                            conn.Open();

                            using (SqlCommand cmd = new SqlCommand(query, conn))
                            {
                                // Add parameters
                                cmd.Parameters.AddWithValue("@AppointmentID", appointmentID);

                                // Execute the command
                                int rowsAffected = cmd.ExecuteNonQuery();

                                // Check if the appointment was successfully canceled
                                if (rowsAffected > 0)
                                {
                                    MessageBox.Show("Appointment canceled successfully.", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);

                                    // Refresh the DataGridView to reflect the changes
                                    RefreshDataGridView();
                                }
                                else
                                {
                                    MessageBox.Show("Failed to cancel appointment.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show($"An error occurred: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }
            }
            else
            {
                MessageBox.Show("Please select an appointment to cancel.", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void RefreshDataGridView()
        {
            // Refresh or reload data in the DataGridView
            // You need to implement this method based on how you initially populated the DataGridView
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
    }
}
