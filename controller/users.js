// Controllers/users.js
const db = require('../dbConfig');

/**
 * getUserByName (Simplified) - Fetches basic user data to test database connection.
 */
const getUserByName = (req, res) => {
    const userName = req.query.userName;

    const query = `
        SELECT
            UserID, Name, Email
        FROM Users
        WHERE Name LIKE ?
    `;

    db.query(query, [`%${userName}%`], (err, userResults) => {
        if (err) {
            console.error("Error fetching user data (simplified):", err);
            return res.status(500).send('Error fetching user data (simplified)');
        }

        let html = `
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/minty/bootstrap.min.css">
        <div class="container mt-5">
            <h3>User Search Results for "${userName}"</h3>
        `;

        if (userResults.length === 0) {
            html += `<p>No users found with that name.</p>`;
        } else {
            html += `
            <table class="table table-bordered table-striped mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
            `;

            userResults.forEach(user => {
                html += `
                <tr>
                    <td>${user.Name}</td>
                    <td>${user.Email}</td>
                </tr>
                `;
            });

            html += `
                </tbody>
            </table>
            `;
        }

        html += `
            <a href="/userSearch.html" class="btn btn-primary mt-3">Back to Search</a>
        </div>
        `;

        res.send(html);
    });
};


/**
 * getAllUsers function fetches and displays all users in the database
 * with their basic information in a tabular format.
 */
const getAllUsers = (req, res) => {
    const query = 'SELECT UserID, Name, Email, Join_Date FROM Users ORDER BY Join_Date DESC';

    db.query(query, (err, results) => {
        if (err) {
            console.error("Error fetching all users:", err);
            return res.status(500).send('Error fetching users data');
        }

        // Generate HTML response
        let html = `
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/minty/bootstrap.min.css">
        <div class="container mt-5">
            <h3>All No Pore Decisions Users</h3>
        `;

        if (results.length === 0) {
            html += `<p>No users found in database.</p>`;
        } else {
            html += `
            <table class="table table-bordered table-striped mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Join Date</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody>
            `;

            results.forEach(users => {
                html += `
                <tr>
                    <td>${users.Name}</td>
                    <td>${users.Email}</td>
                    <td>${new Date(users.Join_Date).toLocaleDateString()}</td>
                    <td>
                        <a href="/userdetails?userID=${users.UserID}" class="btn btn-sm btn-info">
                            View 
                        </a>
                    </td>
                </tr>
                `;
            });

            html += `
                </tbody>
            </table>
            `;
        }

        html += `
            <a href="/userSearch.html" class="btn btn-primary mt-3">Back to Search</a>
        </div>
        `;

        res.send(html);
    });
};

/**
 * Module exports the functions to be used in the routes
 */
module.exports = {
    getUserByName,
    getAllUsers
};
