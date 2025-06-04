// Step 1: Import Required Libraries
const express = require('express');
const app = express();
const db = require('./dbConfig');

// Step 2: Import Controllers
const userController = require('./controllers/users');
const { getProgressLogsByUserID } = require('./controllers/progressLogs');
const { getSkinProfileByUserID } = require('./controllers/skinProfiles');

// Step 3: Middleware Setup
app.use(express.json());
app.use(express.static('public'));

// Step 4: Define Routes
app.get('/users', userController.getUserByName);
app.get('/allusers', userController.getAllUsers);
app.get('/progresslogs', getProgressLogsByUserID);
app.get('/skinprofile', getSkinProfileByUserID);

// Step 5: Unified Details Page for User Routine + Skin Profile
app.get('/userdetails', (req, res) => {
    const userID = req.query.userID;

    const skinQuery = `
        SELECT Name, Skin_Concerns, Sensitivities, Goals
        FROM Users
        JOIN SkinProfile ON Users.UserID = SkinProfile.UserID
        WHERE Users.UserID = ?
    `;

    const routineQuery = `
        SELECT Cleanser, Toner, Serum, Moisturizer, Sunscreen
        FROM Routines
        WHERE UserID = ?
    `;

    db.query(skinQuery, [userID], (err, skinResults) => {
        if (err) return res.status(500).send("Error fetching skin profile");
        if (skinResults.length === 0) return res.send("No profile found for this user.");

        const skin = skinResults[0];

        db.query(routineQuery, [userID], (err, routineResults) => {
            if (err) return res.status(500).send("Error fetching routine");
            const routine = routineResults[0];

            let html = `
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.0/dist/minty/bootstrap.min.css">
            <div class="container mt-5">
                <h2>${skin.Name}'s Skin Profile & Routine</h2>

                <h4 class="mt-4">Skin Profile</h4>
                <table class="table table-bordered">
                    <tr><th>Concerns</th><td>${skin.Skin_Concerns}</td></tr>
                    <tr><th>Sensitivities</th><td>${skin.Sensitivities}</td></tr>
                    <tr><th>Goals</th><td>${skin.Goals}</td></tr>
                </table>
            `;

            if (routine) {
                html += `
                <h4 class="mt-4">Current Routine</h4>
                <table class="table table-bordered">
                    <tr><th>Cleanser</th><td>${routine.Cleanser}</td></tr>
                    <tr><th>Toner</th><td>${routine.Toner}</td></tr>
                    <tr><th>Serum</th><td>${routine.Serum}</td></tr>
                    <tr><th>Moisturizer</th><td>${routine.Moisturizer}</td></tr>
                    <tr><th>Sunscreen</th><td>${routine.Sunscreen}</td></tr>
                </table>
                `;
            } else {
                html += `<p><em>No routine found for this user.</em></p>`;
            }

            html += `<a href="/userSearch.html" class="btn btn-primary mt-4">Back to Search</a></div>`;
            res.send(html);
        });
    });
});

// Step 6: Start the Server
const PORT = process.env.PORT || 5002;
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
