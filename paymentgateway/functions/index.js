const functions = require('firebase-functions');
const admin = require('firebase-admin');
const express = require('express');
const cors = require('cors');
const axios = require('axios');

admin.initializeApp();

const app = express();

// Middleware
app.use(express.json()); // Parse JSON requests
app.use(cors()); // Allow cross-origin resource sharing

app.post('/postpaymentrequest', async (req, res) => {
  try {
    const ozowResponse = await axios.post('https://api.ozow.com/postpaymentrequest', req.body, {
      headers: {
        'Accept': 'application/json',
        'ApiKey': 'aUcwYW4cpx2xAOaMu8DEnJmQ9JUvJHVD',
        'Content-Type': 'application/json',
      },
    });

    res.status(200).json(ozowResponse.data);
  } catch (error) {
    console.error(error.message);
    res.header('Access-Control-Allow-Origin', '*'); // Add CORS header for error response
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.get('/googlein', async (req, res) => {
  try {
    const response = await axios.get('https://www.google.co.in/');
    res.header('Access-Control-Allow-Origin', '*');
    res.json(response.data);
  } catch (error) {
    console.error('Error:', error);
    res.header('Access-Control-Allow-Origin', '*'); // Add CORS header for error response
    res.status(500).send('Internal Server Error');
  }
});

// Define the Cloud Function
exports.yourCloudFunctionName = functions.https.onRequest(app);
