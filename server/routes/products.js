const express = require('express');
const router = express.Router();
const pool = require('../db');

// ── GET ALL PRODUCTS ──────────────────────────
// GET /api/products
router.get('/', async (req, res) => {
  try {
    const { category, sort } = req.query;

    let query = 'SELECT * FROM products';
    const params = [];

    // Filter by category
    if (category && category !== 'All') {
      query += ' WHERE category = $1';
      params.push(category);
    }

    // Sort
    if (sort === 'price_asc') {
      query += ' ORDER BY price ASC';
    } else if (sort === 'price_desc') {
      query += ' ORDER BY price DESC';
    } else {
      query += ' ORDER BY created_at DESC';
    }

    const result = await pool.query(query, params);

    res.json({
      success: true,
      products: result.rows
    });

  } catch (error) {
    console.error('Get products error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
});

// ── GET SINGLE PRODUCT ────────────────────────
// GET /api/products/:id
router.get('/:id', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT * FROM products WHERE id = $1',
      [req.params.id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Product not found'
      });
    }

    res.json({
      success: true,
      product: result.rows[0]
    });

  } catch (error) {
    console.error('Get product error:', error);
    res.status(500).json({
      success: false,
      message: 'Server error'
    });
  }
});

module.exports = router;