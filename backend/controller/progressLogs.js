// TCSS 445 | Project | Controllers | progressLogs.js
const db = require('../dbConfig');

const getProgressLogsByUserID = (req, res) => {
  const userId = req.query.userId;

  const query = `
    SELECT u.Name, p.Entry_Date, p.Notes, p.Metrics
    FROM Users u
    JOIN Progress_Logs p ON u.UserID = p.UserID
    WHERE u.UserID = ?
    ORDER BY p.Entry_Date
  `;

  db.query(query, [userId], (err, results) => {
    if (err) return res.status(500).json({ error: 'Database error' });
    if (results.length === 0) return res.status(404).json({ message: 'No logs found' });
    res.json(results);
  });
};

module.exports = {
  getProgressLogsByUserID,
};
