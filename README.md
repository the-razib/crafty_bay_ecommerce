# CraftyBay E-Commerce

A modern, feature‑rich e‑commerce mobile app built with Flutter, offering an intuitive shopping experience with easy navigation and a wide range of features.

![CraftyBay App Preview](all.png)

## Overview

CraftyBay is a complete e-commerce solution that brings the convenience of online shopping to your fingertips. With a clean, user-friendly interface and robust backend integration, it offers everything users need for a smooth shopping journey - from browsing products to secure checkout.

## Key Features

### 🛍️ **Shopping Experience**
- **Product Catalog**: Browse through various categories with detailed product listings
- **Search & Filter**: Find products quickly with advanced search and filtering options
- **Product Details**: Comprehensive product information with multiple images, descriptions, and specifications
- **Product Reviews**: Rate and review products, helping other shoppers make informed decisions
- **Wishlist**: Save favorite items for later purchase
- **Shopping Cart**: Add, remove, and manage items with quantity controls

### 🔐 **Authentication & User Management**
- **Secure Sign Up/Sign In**: Email-based authentication with OTP verification
- **Profile Management**: Complete user profiles with personal information
- **Email Verification**: Two-step verification process for account security
- **User Dashboard**: Personalized experience with order history and preferences

### 📱 **User Interface & Experience**
- **Modern Design**: Clean, intuitive interface following Material Design principles
- **Responsive Layout**: Optimized for various screen sizes and orientations
- **Smooth Navigation**: Bottom navigation with seamless transitions between sections
- **Loading States**: Shimmer effects and progress indicators for better user feedback
- **Dark/Light Theme**: Customizable themes for user preference

### 🛒 **Shopping Cart & Checkout**
- **Real-time Cart Updates**: Instant cart synchronization across the app
- **Quantity Management**: Easy increment/decrement controls for cart items
- **Price Calculation**: Automatic total calculation with tax and shipping
- **Cart Persistence**: Cart items saved across app sessions

### 📊 **Product Management**
- **Category Organization**: Well-structured product categories for easy browsing
- **Product Variants**: Support for different colors, sizes, and specifications
- **Trending Products**: Showcase popular and trending items
- **New Arrivals**: Highlight latest product additions
- **Special Offers**: Featured deals and promotional products

## Technical Architecture

### 🏗️ **Clean Architecture**
The project follows a modular, feature-based architecture:

```
lib/
├── app/                    # App configuration & theme
├── features/               # Feature-based modules
│   ├── auth/              # Authentication functionality
│   ├── cart/              # Shopping cart management
│   ├── category/          # Product categorization
│   ├── common/            # Shared components & controllers
│   ├── home/              # Home screen & widgets
│   ├── products/          # Product management
│   ├── review/            # Review system
│   └── wishlist/          # Wishlist functionality
└── service/               # Network & external services
```

### 🔧 **Technology Stack**
- **State Management**: GetX for reactive state management
- **Network**: HTTP client for API communication
- **Local Storage**: SharedPreferences for data persistence
- **UI Components**: Custom widgets with Material Design
- **Image Handling**: SVG support with flutter_svg
- **Authentication**: JWT token-based authentication
- **Validation**: Email validation and form validation



### Configuration

The app connects to a backend API hosted at `https://ecom-rs8e.onrender.com/api`. All endpoints are configured in `lib/app/urls.dart`.

## API Integration

CraftyBay integrates with a comprehensive REST API providing:
- User authentication and management
- Product catalog and search
- Shopping cart operations
- Order processing
- Review and rating system
- Wishlist management



## Development Roadmap

### Upcoming Features
- [ ] Order tracking and history
- [ ] Payment gateway integration
- [ ] Push notifications
- [ ] Social login (Google, Facebook)
- [ ] Advanced search filters
- [ ] Product recommendations
- [ ] Multi-language support
- [ ] Offline mode capabilities

## Screenshots & Demo

The attached image (`all.png`) showcases the complete user interface of CraftyBay, demonstrating the polished design and comprehensive functionality across all major screens.

## License

This project is developed for educational and portfolio purposes. Feel free to explore, learn, and adapt the code for your own projects.

## Contact

**Developer**: Md Razib  
**Repository**: [CraftyBay E-Commerce](https://github.com/the-razib/crafty_bay_ecommerce)

---

*Built with ❤️ using Flutter*
