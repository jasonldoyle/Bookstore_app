// Importing MySQL module for database connection
const mysql = require('mysql');

// Creates a connection object with database configuration
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'G00472910'
});

// Connect to MySQL database and handle errors
connection.connect((err) => {
  if (err) {
    // Log connection error message
    console.error('MySQL connection error:', err.message);
  } else {
    // Log success message if connected
    console.log('Connected to MySQL database.');
  }
});

// Export the connection so it can be used in other files
module.exports = connection;