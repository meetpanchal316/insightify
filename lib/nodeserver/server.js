const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const User = require('../nodeserver/userdatamodel');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const app = express();
const port = 5000;

app.use(bodyParser.json());

// Connect to MongoDB 
mongoose.connect('mongodb+srv://panchalmeet316:meetrocks@cluster0.vb8df.mongodb.net/INSIGHTIFY?retryWrites=true&w=majority&appName=Cluster0').then(() => {
  console.log('Connected to MongoDB');
}).catch((err) => {
  console.error('Error connecting to MongoDB:', err.message);
});


// Define an API endpoint for user registration
app.get('/users', async (req, res) => {
  try {
    const users = await User.find();
    res.json(users);
  } catch (error) {
    res.status(500).send('Error retrieving users');
  }
});

app.post('/register', async (req, res) => {
  const { username, password, email } = req.body;
  console.log('Received data:', username, email, password);

  // Basic validation (you can expand this as needed)
  if (username == "" || email == "" || password == "") {
    return res.status(406).send('All fields are required');
  }
  const hashedPassword = await bcrypt.hash(password, 10);

  try {
    // Check if username or email already exists
    {
      const existingUserByUsername = await User.findOne({ username });
      if (existingUserByUsername) {
        return res.status(400).send('Username already exists');
      }
      const existingUserByEmail = await User.findOne({ email });
      if (existingUserByEmail) {
        return res.status(400).send('Email is already registered');
      }
    }
    // Create a new user instance
    const newUser = new User({ username, password: hashedPassword, email });
    // Save the user to the database
    await newUser.save();

    console.log("User registered successfully!!");
    res.status(201).send('User registered successfully');
  } catch (error) {
    console.error('Server error:', error.message);
    res.status(500).send('An unexpected error occurred. Please try again later.');
  }
});

// Define an API endpoint for user login
app.post('/login', async (req, res) => {
  const { username, password } = req.body;

  try {
    // Find the user by username
    const user = await User.findOne({ username });
    if (username == "" || password == "") {
      return res.status(406).send('All fields are required');
    }
    if (!user) {
      return res.status(401).send('BRO GET REGISTERED FIRST!');
    }

    // Compare the provided password with the stored password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    const token = jwt.sign({ userId: user._id }, 'your_secret_key');
    if (isPasswordValid && user) {
      const token = jwt.sign({ userId: user._id }, 'your_secret_key');
      console.log('Login successful. Token generated:', token);
      res.status(200).json({ token });
    }
    else{
      return res.status(401).send('wrong password bro!!');
    }
  } catch (error) {
    console.error('Server error:', error.message);
    res.status(500).send('An unexpected error occurred. Please try again later.');
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://192.168.0.106:${port}`);
});

process.on('SIGINT', () => {
  server.close(() => {
    console.log('Server closed gracefully');
    process.exit(0);
  });
});