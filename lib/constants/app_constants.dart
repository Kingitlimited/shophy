// lib/constants/app_constants.dart

class AppConstants {
  // App Information
  static const String appName = 'Shophy';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Your Modern Shopping Companion';
  
  // API & Backend
  static const String baseUrl = 'https://api.shophy.com/v1';
  static const int apiTimeout = 30000; // 30 seconds
  static const int paginationLimit = 20;
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String cartKey = 'cart_data';
  static const String themeKey = 'theme_mode';
  static const String localeKey = 'app_locale';
  
  // Animation Durations
  static const Duration animationDurationShort = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationLong = Duration(milliseconds: 500);
  
  // Debounce Timers (for search, buttons, etc.)
  static const Duration debounceDuration = Duration(milliseconds: 500);
  
  // Product Constants
  static const int maxProductQuantity = 99;
  static const int minProductQuantity = 1;
  static const double defaultTaxRate = 0.08; // 8%
  static const double defaultShippingCost = 5.99;
  
  // Currency
  static const String defaultCurrency = 'USD';
  static const String currencySymbol = '\$';
  
  // Validation Limits
  static const int minPasswordLength = 6;
  static const int maxProductTitleLength = 100;
  static const int maxProductDescriptionLength = 1000;
  
  // Date Formats
  static const String dateFormat = 'MMM dd, yyyy';
  static const String dateTimeFormat = 'MMM dd, yyyy • HH:mm';
  
  // Social Links
  static const String websiteUrl = 'https://shophy.com';
  static const String supportEmail = 'support@shophy.com';
  static const String privacyPolicyUrl = 'https://shophy.com/privacy';
  static const String termsOfServiceUrl = 'https://shophy.com/terms';
}

class ProductConstants {
  // Product Status
  static const String statusActive = 'active';
  static const String statusDraft = 'draft';
  static const String statusArchived = 'archived';
  
  // Product Types
  static const String typePhysical = 'physical';
  static const String typeDigital = 'digital';
  
  // Inventory Management
  static const int lowStockThreshold = 10;
  static const int outOfStockThreshold = 0;
  
  // Sorting Options
  static const String sortNewest = 'newest';
  static const String sortPriceLowHigh = 'price_low_high';
  static const String sortPriceHighLow = 'price_high_low';
  static const String sortNameAZ = 'name_a_z';
  static const String sortNameZA = 'name_z_a';
  static const String sortBestSelling = 'best_selling';
}

class CartConstants {
  // Cart Limits
  static const int maxCartItems = 50;
  static const int maxVariantQuantity = 10;
  
  // Cart Actions
  static const String actionAdd = 'add';
  static const String actionRemove = 'remove';
  static const String actionUpdate = 'update';
  static const String actionClear = 'clear';
}

class AuthConstants {
  // Authentication
  static const int otpTimeout = 300; // 5 minutes
  static const int maxLoginAttempts = 5;
  static const int sessionDuration = 7; // days
  
  // User Roles
  static const String roleCustomer = 'customer';
  static const String roleAdmin = 'admin';
  static const String roleVendor = 'vendor';
}