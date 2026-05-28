const express = require('express');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 5000;

// ── Middleware ────────────────────────────────
app.use(cors());
app.use(express.json());

// ── Routes ────────────────────────────────────
app.use('/api/auth', require('./routes/auth'));
app.use('/api/products', require('./routes/products'));

// ── Health Check ──────────────────────────────
app.get('/', (req, res) => {
  res.json({ 
    success: true,
    message: '🛍️ FashionHub API is running!',
    version: '1.0.0'
  });
});

// ── Start Server ──────────────────────────────
app.listen(PORT, () => {
  console.log(`🚀 FashionHub server running on port ${PORT}`);
  console.log(`📍 http://localhost:${PORT}`);
});