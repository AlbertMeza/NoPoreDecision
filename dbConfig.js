// TCSS 445 | Assign3 | dbConfig.js
// Database Configuration File
// Import the mysql2 library for database interaction
const mysql = require('mysql2');

// Load environment variables from .env file
require('dotenv').config();

// Configure database connection using environment variables
const db = mysql.createConnection({
host: process.env.DB_HOST, // Database host, e.g., 'localhost'
user: process.env.DB_USER, // Database user, e.g., 'root' or custom user
password: process.env.DB_PASS, // User password
database: process.env.DB_NAME, // Database name, e.g., 'company'
});

// Connect to the database and handle any possible db connection errors
db.connect((err) => {
if (err) {
console.error('Database connection failed:', err);
} else {
console.log('Connected to the database.');
}
});

// Export the database connection for use in other files
module.exports = db;