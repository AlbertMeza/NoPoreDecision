// TCSS 445 | Project | Controllers | skinProfiles.js
const db = require('../dbConfig');

const getSkinProfileByUserID = (req, res) => {
  const userId = req.query.userId;

  const query = `
    SELECT u.Name, s.Concerns, s.Sensitivities, s.Goal
    FROM Users u
           JOIN Skin_Profiles s ON u.UserID = s.UserID
    WHERE u.UserID = ?
  `;

  db.query(query, [userId], (err, results) => {
    if (err) return res.status(500).json({ error: 'Database error' });
    if (results.length === 0) return res.status(404).json({ message: 'No profile found' });
    res.json(results[0]);
  });
};

module.exports = {
  getSkinProfileByUserID,
};