# WooCommerce API Dart plugin

[Official WooSignal WooCommerce package](https://woosignal.com)

Build apps for WooCommerce easier with our new package.
Our API provides many requests types e.g. getProducts, getOrders, getCustomers and many more.
Free to get started, see the simple examples below

For help getting started with WooSignal, view our
[online documentation](https://woosignal.com/docs/api/1.0/overview), which offers a more detail guide.

### Getting Started #
In your flutter project add the dependency:

``` dart 
dependencies:
  ...
  woosignal: ^1.0.8
```

### Usage example #
Import woosignal.dart
``` dart
import 'package:woosignal/woosignal.dart';
```

### Example using WooSignal API for WooCommerce

``` dart
import 'package:woosignal/woosignal.dart';

...

// EXAMPLE GET PRODUCTS
_getProducts() async {

        // CONFIG FOR WOOSIGNAL
        var wsConfig = {
          "appKey":"your app key",
          "debugMode":true
        };

        // CREATING AN INSTANCE
        WooSignal.getInstance(config: wsConfig).then( (wcStore) {

         wcStore.getProducts().then( (products) {
              print(products[0].name);
        });

  });
}
```

### Available API Requests

#### WooCommerce - Products
- Get Products
- Retrive a Product by id

[See Products API](https://woosignal.com/docs/api/1.0/products#list-all-products)


#### WooCommerce - Product Variations
- Get Product Variations
- Retrive a Product Variation by id

[See Product Variations API](https://woosignal.com/docs/api/1.0/products-variations)


#### WooCommerce - Product Attributes
- Get Product Attributes

[See Product Attributes API](https://woosignal.com/docs/api/1.0/products-attributes)


#### WooCommerce - Products Attribute Terms
- Get Products Attribute Terms

[See Products Attribute Terms API](https://woosignal.com/docs/api/1.0/products-attribute-terms)

#### WooCommerce - Product Categories
- Get Product Categories

[See Product Categories API](https://woosignal.com/docs/api/1.0/product-categories)


#### WooCommerce - Products Shipping Classes
- Get Products Shipping Classes

[See Products Shipping Classes API](https://woosignal.com/docs/api/1.0/product-shipping-classes)


#### WooCommerce - Product Reviews
- Get Product Reviews

[See Product Reviews API](https://woosignal.com/docs/api/1.0/product-reviews)


#### WooCommerce - Tax Rates
- Get Tax Rates

[See Tax Rates API](https://woosignal.com/docs/api/1.0/tax-rates)


#### WooCommerce - Tax Classes
- Get Tax Classes

[See Tax Classes API](https://woosignal.com/docs/api/1.0/tax-classes)


#### WooCommerce - Shipping Zones
- Get Shipping Zones
- Retrive a Shipping Zone by id

[See Tax Classes API](https://woosignal.com/docs/api/1.0/tax-classes)


#### WooCommerce - Shipping Zone Locations
- Get Shipping Zone Locations
- Retrive a Shipping Zone Location by id

[See Shipping Zone Locations API](https://woosignal.com/docs/api/1.0/shipping-zone-locations)


#### WooCommerce - Shipping Zone Methods
- Get Shipping Zone Methods
- Retrive a Shipping Zone Method by id

[See Shipping Zone Methods API](https://woosignal.com/docs/api/1.0/shipping-zone-methods)


#### WooCommerce - Shipping Methods
- Get Shipping Methods

[See Shipping Methods API](https://woosignal.com/docs/api/1.0/shipping-methods)


#### WooCommerce - Orders
- Get Orders
- Retrive a Order by id
- Create an Order

[See Order API](https://woosignal.com/docs/api/1.0/orders)


#### WooCommerce - Customers
- Get Customers

[See Customers API](https://woosignal.com/docs/api/1.0/customers)

Disclaimer: This plugin is not affiliated with or supported by Automattic, Inc. All logos and trademarks are the property of their respective owners.
