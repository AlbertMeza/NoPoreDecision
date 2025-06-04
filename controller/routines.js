const db = require('../dbConfig');

/**
 * getRoutineByUserID - Returns routine for a specific user ID as HTML
 */
const getRoutineByUserID = (req, res) => {
    const userID = req.query.userID;

    const query = `
        SELECT 
            Users.Name, Routines.*
        FROM Routines
        JOIN Users ON Routines.UserID = Users.UserID
        WHERE Routines.UserID = ?
    `;

    db.query(query, [userID], (err, results) => {
        if (err) {
            console.error("Error fetching routine data:", err);
            return res.status(500).send('Error fetching routine');
        }

        let html = `
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/minty/bootstrap.min.css">
        <div class="container mt-5">
            <h3>User Routine Lookup</h3>
        `;

        if (results.length === 0) {
            html += `<p>No routine found for UserID: ${userID}</p>`;
        } else {
            const routine = results[0];
            html += `
            <p><strong>Name:</strong> ${routine.Name}</p>
            <table class="table table-bordered mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>Cleanser</th>
                        <th>Toner</th>
                        <th>Serum</th>
                        <th>Moisturizer</th>
                        <th>Sunscreen</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${routine.Cleanser}</td>
                        <td>${routine.Toner}</td>
                        <td>${routine.Serum}</td>
                        <td>${routine.Moisturizer}</td>
                        <td>${routine.Sunscreen}</td>
                    </tr>
                </tbody>
            </table>
            `;
        }

        html += `
            <a href="/routineSearch.html" class="btn btn-primary mt-3">Back to Search</a>
        </div>
        `;

        res.send(html);
    });
};

module.exports = { getRoutineByUserID };
