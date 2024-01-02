const express = require('express');
const bodyParser = require('body-parser');
const pgp = require('pg-promise')();
const app = express();
const port = 3001; // Choose any available port

// Replace 'your_database_connection_string' with your PostgreSQL connection string
const db = pgp('postgres://mwichabe:Avator@2@localhost:5432/aquatic_advisor');

app.use(bodyParser.json());

// Define an endpoint to fetch water sources
app.get('/api/water-sources', async (req, res) => {
  try {
    const waterSources = await db.any('SELECT * FROM water_sources');
    res.json(waterSources);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});
app.get('/test-db-connection', async (req, res) => {
    try {
      const result = await db.one('SELECT 1');
      res.json({ message: 'Database connection successful', result });
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal Server Error' });
    }
  });
  

// Start the server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
