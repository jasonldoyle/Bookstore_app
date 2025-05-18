// app.js – Node + MySQL + Express + EJS Bookstore

const express = require('express');
const app = express();
const path = require('path');
const bodyParser = require('body-parser');
const session = require('express-session');
const db = require('./db/connection');

// Session middleware, before routes
app.use(session({
  secret: 'securekey123',  // You would change in production
  resave: false,
  saveUninitialized: false
}));

// Make the session available in views
app.use((req, res, next) => {
  res.locals.session = req.session;
  next();
});

// View the engine setup
app.set('view engine', 'ejs');

// middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));

// ===== Routes =====

// Home Page, Featured Sections
app.get('/', (req, res) => {
  const featuredQuery = 'SELECT * FROM books WHERE id IN (1,2,3,4,5,6,7,8,9) ORDER BY FIELD(id,1,2,3,4,5,6,7,8,9)';
  const newReleasesQuery = 'SELECT * FROM books WHERE id IN (10,11,12,13,14,15,16,17,18)';
  const trendingQuery = 'SELECT * FROM books WHERE id IN (19,20,21,22,23,24,25,26,27)';

  db.query(featuredQuery, (err, featuredBooks) => {
    if (err) return res.status(500).send('Database error (featured)');
    db.query(newReleasesQuery, (err, newBooks) => {
      if (err) return res.status(500).send('Database error (new releases)');
      db.query(trendingQuery, (err, trendingBooks) => {
        if (err) return res.status(500).send('Database error (trending)');
        res.render('home', { featuredBooks, newBooks, trendingBooks });
      });
    });
  });
});

// Product Catalog
app.get('/products', (req, res) => {
  const { search, minPrice, maxPrice, category } = req.query;
  let query = 'SELECT * FROM books WHERE 1=1';
  const params = [];

  if (search) {
    query += ' AND (title LIKE ? OR author LIKE ?)';
    params.push(`%${search}%`, `%${search}%`);
  }
  if (minPrice) {
    query += ' AND price >= ?';
    params.push(minPrice);
  }
  if (maxPrice) {
    query += ' AND price <= ?';
    params.push(maxPrice);
  }
  if (category && category !== 'all') {
    query += ' AND category = ?';
    params.push(category);
  }

  db.query(query, params, (err, results) => {
    if (err) return res.send('Error retrieving books');
    res.render('products', {
      books: results,
      filters: {
        search: search || '',
        minPrice: minPrice || '',
        maxPrice: maxPrice || '',
        category: category || 'all'
      }
    });
  });
});

// About and contact
app.get('/about', (req, res) => res.render('about'));
app.get('/contact', (req, res) => res.render('contact'));

app.post('/contact', (req, res) => {
  const { name, email, message } = req.body;

  if (!name || !email || !message) {
    return res.json({ message: '⚠️ Please fill in all fields.' });
  }

  if (!email.includes('@')) {
    return res.json({ message: '⚠️ Please enter a valid email address.' });
  }

  return res.json({ message: `Thank you, ${name}! Your message has been received.` });
});

// Login
app.get('/login', (req, res) => res.render('login', { error: null }));

app.post('/login', (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.render('login', { error: 'Please fill in all fields.' });
  }

  const query = 'SELECT * FROM users WHERE email = ? AND password = ?';
  db.query(query, [email, password], (err, results) => {
    if (err) return res.send('Database error.');
    if (results.length === 0) {
      return res.render('login', { error: 'Invalid email or password.' });
    }

    req.session.user = results[0];
    res.redirect('/cart');
  });
});

// Logout
app.get('/logout', (req, res) => {
  req.session.destroy(() => res.redirect('/login'));
});

// Cart
app.get('/cart', (req, res) => {
  const cart = req.session.cart || [];

  if (cart.length === 0) {
    return res.render('cart', { cartItems: [], total: 0 });
  }

  const ids = cart.map(item => item.bookId);
  const placeholders = ids.map(() => '?').join(',');
  const query = `SELECT * FROM books WHERE id IN (${placeholders})`;

  db.query(query, ids, (err, results) => {
    if (err) return res.send('Error loading cart.');

    const cartItems = results.map(book => {
      const item = cart.find(i => i.bookId == book.id);
      return {
        ...book,
        quantity: item.quantity,
        total: (book.price * item.quantity).toFixed(2)
      };
    });

    const total = cartItems.reduce((sum, item) => sum + parseFloat(item.total), 0).toFixed(2);
    res.render('cart', { cartItems, total });
  });
});

app.post('/cart/add', (req, res) => {
  const { bookId, quantity } = req.body;
  if (!req.session.cart) req.session.cart = [];

  const cart = req.session.cart;
  const existing = cart.find(item => item.bookId == bookId);

  if (existing) {
    existing.quantity += parseInt(quantity);
  } else {
    cart.push({ bookId, quantity: parseInt(quantity) });
  }

  if (req.headers['x-requested-with'] === 'XMLHttpRequest') {
    return res.json({ success: true, message: 'Item added to cart!' });
  }

  res.redirect('/cart');
});

app.get('/cart/clear', (req, res) => {
  req.session.cart = [];
  res.redirect('/cart');
});

// Purchase sum
app.post('/purchase', (req, res) => {
  if (!req.session.user) return res.redirect('/login');

  const { bookId, quantity } = req.body;

  if (!bookId || !quantity || quantity <= 0) {
    return res.send('⚠️ Invalid purchase details.');
  }

  const query = 'SELECT * FROM books WHERE id = ?';
  db.query(query, [bookId], (err, results) => {
    if (err || results.length === 0) {
      return res.send('⚠️ Error finding book.');
    }

    const book = results[0];
    const totalCost = (book.price * quantity).toFixed(2);

    res.render('summary', {
      book,
      quantity,
      totalCost,
      user: req.session.user
    });
  });
});

// Start Server
app.listen(3000, () => {
  console.log('Server running at http://localhost:3000');
});