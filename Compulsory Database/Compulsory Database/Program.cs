using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Compulsory_Database
{
    class Program
    {
        private static readonly SqlConnection Conn = new SqlConnection("Data Source=DESKTOP-0CHMIE4;Initial Catalog=Company;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=True;ApplicationIntent=ReadWrite;MultiSubnetFailover=False");
        static void Main(string[] args)
        {
            int userInput = 0;
            do
            {
                userInput = DisplayMenu();
                if (userInput == 1)
                {
                    CreateDepartment();
                }
                if (userInput == 2)
                {
                    UpdateDepartmentName();
                }
                if (userInput == 3)
                {
                    UpdateDepartmentManager();
                }
                if (userInput == 4)
                {
                    DeleteDepartment();
                }
                if (userInput == 5)
                {
                    GetDepartment();
                }
                if (userInput == 6)
                {
                   GetAllDepartments();
                }
            } while (userInput != 7);

            
            
        }

        static public int DisplayMenu()
        {
            Console.Clear();
            Console.WriteLine("Company Database Manager");
            Console.WriteLine();
            Console.WriteLine("1. Create a Department");
            Console.WriteLine("2. Update a Department Name");
            Console.WriteLine("3. Update a Department Manager");
            Console.WriteLine("4. Delete a Department");
            Console.WriteLine("5. Get Department");
            Console.WriteLine("6. Get All Departments");
            Console.WriteLine("7. Exit");
            var resultt = Console.ReadLine();
            return Convert.ToInt32(resultt);
        }

        private static void CreateDepartment()
        {
            try
            {
                Console.WriteLine("Please input the name of the Department");
                var DName = Convert.ToString(Console.ReadLine());
                Console.WriteLine("Please input the MgrSSN of the Department");
                int MgrSSN = Convert.ToInt32(Console.ReadLine());
                using (SqlCommand _cmd = new SqlCommand("dbo.usp_CreateDepartment", Conn))
                {
                    _cmd.CommandType = CommandType.StoredProcedure;
                    _cmd.Parameters.AddWithValue("@DName", ""+DName+"");
                    _cmd.Parameters.AddWithValue("@MgrSSN", "" + MgrSSN + "");
                    _cmd.Parameters.Add("@DNumberOut", SqlDbType.Int).Direction = ParameterDirection.Output;
                    Conn.Open();
                    var result = _cmd.ExecuteNonQuery();
                    int DNumberOut = Convert.ToInt32(_cmd.Parameters["@DNumberOut"].Value);
                    Conn.Close();
                    if (result < 0)
                    {
                        Console.WriteLine("The Department with Dnumber : " + DNumberOut + " has been added to the database");
                        Console.ReadLine();
                    }
                    else
                    {
                        Console.WriteLine("The Department with Dnumber : " + DNumberOut + " couldnt be added to the database");
                        Console.ReadLine();
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Cannot open connection: " + e.ToString());
                Console.ReadLine();
            }
        }

        private static void UpdateDepartmentName()
        {
            try
            {
                Console.WriteLine("Please input the new name of the Department");
                var DName = Convert.ToString(Console.ReadLine());
                Console.WriteLine("Please input the DNumber of the Department you want to change");
                int DNumber = Convert.ToInt32(Console.ReadLine());
                using (SqlCommand _cmd = new SqlCommand("EXECUTE dbo.usp_UpdateDepartmentName " + DName + ", "+DNumber+"", Conn))
                {
                    SqlDataAdapter _dap = new SqlDataAdapter(_cmd);
                    Conn.Open();
                    var result = _cmd.ExecuteNonQuery();
                    Conn.Close();
                    if (result < 0)
                    {
                        Console.WriteLine("The Department with Dnumber : " + DNumber + " has been Updated with a new name");
                        Console.ReadLine();
                    }
                    else
                    {
                        Console.WriteLine("The Department with Dnumber : " + DNumber + " couldnt be updated with a new name");
                        Console.ReadLine();
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Cannot open connection: " + e.ToString());
                Console.ReadLine();
            }
        }

        private static void UpdateDepartmentManager()
        {
            try
            {
                Console.WriteLine("Please input the DNumber of the Department you want to change");
                var DNumber = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine("Please input the new MgrSSN of the department");
                int MgrSSN = Convert.ToInt32(Console.ReadLine());
                using (SqlCommand _cmd = new SqlCommand("EXECUTE dbo.usp_UpdateDepartmentManager " + DNumber + ", " + MgrSSN + "", Conn))
                {
                    SqlDataAdapter _dap = new SqlDataAdapter(_cmd);
                    Conn.Open();
                    var result = _cmd.ExecuteNonQuery();
                    Conn.Close();
                    if (result < 0)
                    {
                        Console.WriteLine("The Department with Dnumber : " + DNumber + " has been Updated with a new Department Manager");
                        Console.ReadLine();
                    }
                    else
                    {
                        Console.WriteLine("The Department with Dnumber : " + DNumber + " couldnt be updated with a new Department Manager");
                        Console.ReadLine();
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Cannot open connection: " + e.ToString());
                Console.ReadLine();
            }
        }

        private static void DeleteDepartment()
        {
            try
            {
                Console.WriteLine("Please input the Dnumber of the Department you want to Delete");
                int DNumber = Convert.ToInt32(Console.ReadLine());
                using (SqlCommand _cmd = new SqlCommand("EXECUTE dbo.usp_DeleteDepartment " + DNumber + "", Conn))
                {
                    SqlDataAdapter _dap = new SqlDataAdapter(_cmd);
                    Conn.Open();
                    var result = _cmd.ExecuteNonQuery();
                    Conn.Close();
                    if (result < 0)
                    {
                        Console.WriteLine("The Department with Dnumber : " + DNumber + " has been deleted");
                        Console.ReadLine();
                    }
                    else {
                        Console.WriteLine("The Department with Dnumber : " + DNumber + " couldnt be deleted");
                        Console.ReadLine();
                    }
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Cannot open connection: " + e.ToString());
                Console.ReadLine();
            }
        }

        private static void GetDepartment() {
            try
            {
                Console.WriteLine("Please input the Dnumber of the Department");
                int DNumber = Convert.ToInt32(Console.ReadLine());
                DataTable Department = new DataTable("Department");
                using (SqlCommand _cmd = new SqlCommand("EXECUTE dbo.usp_GetDepartment "+DNumber+"", Conn))
                {
                    SqlDataAdapter _dap = new SqlDataAdapter(_cmd);
                    Conn.Open();
                    _dap.Fill(Department);
                    Conn.Close();
                }
                foreach (DataRow dataRow in Department.Rows)
                {
                    Console.WriteLine("ROW");
                    foreach (DataColumn column in Department.Columns)
                    {
                        Console.Write(column.ColumnName);
                        Console.Write(": ");
                        Console.WriteLine(dataRow[column]);
                    }
                }
                Console.ReadLine();
            }
            catch (Exception e)
            {
                Console.WriteLine("Cannot open connection: " + e.ToString());
                Console.ReadLine();
            }
        }
        private static void GetAllDepartments()
        {
            DataTable Department = new DataTable("Department");
            using (SqlCommand _cmd = new SqlCommand("EXECUTE dbo.usp_GetAllDepartments", Conn))
            {
                SqlDataAdapter _dap = new SqlDataAdapter(_cmd);
                Conn.Open();
                _dap.Fill(Department);
                Conn.Close();
            }
            foreach (DataRow dataRow in Department.Rows)
            {
                Console.WriteLine("ROW");
                foreach (DataColumn column in Department.Columns)
                {
                    Console.Write(column.ColumnName);
                    Console.Write(": ");
                    Console.WriteLine(dataRow[column]);
                }
            }
            Console.ReadLine();
        }
    }
}
