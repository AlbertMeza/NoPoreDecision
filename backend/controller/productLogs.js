// Step 1: Import Required Libraries
const db = require('../dbConfig');

// Step 2: Fetch all Product Logs
const getAllProductLogs = (req, res) => {
  const query = `
    SELECT ProgressID, UserID, ProductID, ProgressDate
    FROM ProgressLogs
  `;

  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching product logs:', err);
      res.status(500).send('Error fetching product logs');
    } else {
      res.json(results);
    }
  });
};

// Step 3: Get detailed information for a specific Product Log
const getProductLogDetails = (req, res) => {
  const { ProgressID } = req.query;

  if (!ProgressID) {
    return res.status(400).send('ProgressID is required');
  }

  const query = `
    SELECT 
      pl.ProgressID,
      u.Name AS UserName,
      pl.ProductID,
      p.Purpose,
      p.ExpDate,
      pl.ProgressDate,
      pl.Notes,
      pl.Rating
    FROM ProgressLogs pl
    JOIN Users u ON pl.UserID = u.UserID
    JOIN ProductLogs p ON pl.ProductID = p.ProductID
    WHERE pl.ProgressID = ?
  `;

  db.query(query, [ProgressID], (err, results) => {
    if (err) {
      console.error('Error fetching product log details:', err);
      res.status(500).send('Error retrieving product log details');
    } else {
      res.json(results);
    }
  });
};

// Step 4: Export the Controller Functions
module.exports = {
  getAllProductLogs,
  getProductLogDetails,
};
