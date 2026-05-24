# 🛍️ FashionHub

A full-stack mobile e-commerce application for a Sri Lankan clothing store, built with Flutter and Node.js.

## ✨ Features

- 👗 Product browsing by category (Men, Women, Kids)
- 🔍 Product detail page with sizes and colors
- 🛒 Shopping cart with quantity management
- 💗 Wishlist
- 🔐 User authentication (Register & Login with JWT)
- 💳 Online payments via PayHere (Sri Lankan payment gateway, LKR support)
- 📦 Order tracking
- 👤 User profile management

## 🛠️ Tech Stack

### Mobile (Frontend)
- Flutter 3.44.0
- Dart 3.12.0
- Riverpod (state management)
- Dio (HTTP client)
- Go Router (navigation)

### Backend
- Node.js + Express.js
- PostgreSQL
- JWT Authentication
- PayHere Payment Gateway

### Deployment
- Backend → Railway
- Storage → Supabase

## 🎨 Design

Brand colors inspired by elegant fashion aesthetics:

| Color | Hex | Usage |
|---|---|---|
| Blush Pink | `#F7C6D9` | Backgrounds, cards |
| Soft Rose | `#E8A9C1` | Accents, secondary |
| Muted Pink | `#D98CA6` | Primary buttons, nav |
| Deep Charcoal | `#2C2C2C` | Text |

## 🚀 Getting Started

### Prerequisites
- Flutter 3.44.0+
- Dart 3.12.0+
- Node.js 18+
- PostgreSQL 15+

### Run the Flutter App

```bash
# Clone the repo
git clone https://github.com/YourUsername/fashionhub.git

# Enter project
cd fashionhub

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Run the Backend (Day 4+)

```bash
cd server
npm install
npm run dev
```

## 📁 Project Structure
