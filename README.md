# WooCommerce API Dart plugin

[Official WooSignal WooCommerce package](https://woosignal.com)

Build apps for WooCommerce easier with our new package.
Our API provides many requests types e.g. getProducts, getOrders and many more.
Free to get started, see the simple examples below.

For help getting started with WooSignal, view our
[online documentation](https://woosignal.com/docs/api/1.0/overview), which offers a more detail guide.

### Getting Started #
In your flutter project add the dependency:

``` dart 
dependencies:
  ...
  woosignal: ^3.8.0
```

### Usage example #
Import `woosignal.dart`
``` dart
import 'package:woosignal/woosignal.dart';
```

### Example using WooSignal API for WooCommerce

``` dart
import 'package:woosignal/woosignal.dart';

...

// EXAMPLE GET PRODUCTS
_getProducts() async {

        // Step 1 - Initialize WooSignal
        await WooSignal.instance.init(appKey: "your app key");

        // Step 2 - Call an API
        List<Product> products = await WooSignal.instance.getProducts();

        print(products[0].name); // prints a product name
  });
}
```

### Available API Requests

#### WooCommerce - Products
- Get Products
- Retrieve a Product by id
- Update a Product by id
- Delete a Product by id 
- Create a Product 
- Batch update Products

[See Products API](https://woosignal.com/docs/api/1.0/products#list-all-products)


#### WooCommerce - Product Variations
- Get Product Variations
- Retrieve a Product Variation by id

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
- Retrieve a Shipping Zone by id

[See Tax Classes API](https://woosignal.com/docs/api/1.0/tax-classes)


#### WooCommerce - Shipping Zone Locations
- Get Shipping Zone Locations
- Retrieve a Shipping Zone Location by id

[See Shipping Zone Locations API](https://woosignal.com/docs/api/1.0/shipping-zone-locations)


#### WooCommerce - Shipping Methods
- Get Shipping Methods

[See Shipping Methods API](https://woosignal.com/docs/api/1.0/shipping-methods)


#### WooCommerce - Orders
- Get Orders
- Retrieve a Order by id
- Create an Order
- Update an Order
- Batch update Orders

[See Order API](https://woosignal.com/docs/api/1.0/orders)


#### WooCommerce - Customers
- Get Customers
- Create a Customer
- Delete a Customer
- Update a Customer
- Batch update Customers

[See Customers API](https://woosignal.com/docs/api/1.0/customers)

#### WooCommerce - API Orders Notes
- List all Orders Notes
- Retrieve a Orders Notes by id
- Delete a Orders Notes by id
- Create a Orders Notes

[See Orders Notes API](https://woosignal.com/docs/api/1.0/order-notes)

#### WooCommerce - Refunds
- Get refunds from an order id
- Retrieve a retrieve and view a specific refund from an order
- Delete a delete an order refund.
- Create a new refund for an order

[See Refunds API](https://woosignal.com/docs/api/1.0/order-refund)

#### WooCommerce - Coupons
- Get all coupons.
- Retrieve and view a specific coupon by ID
- Update a coupon.
- Delete a coupon.
- Batch update Coupons.

[See Coupons API](https://woosignal.com/docs/api/1.0/coupons)

#### WooCommerce - Reports
- Get Reports
- Retrieve a report of Sales
- Retrieve a report of Top Sellers
- Retrieve a report of the Total Coupons
- Retrieve a report of the Total Customers
- Retrieve a report of the Total Orders
- Retrieve a report of the Total Products
- Retrieve a report of the Total Reviews

[See Reports API](https://woosignal.com/docs/api/1.0/reports)

#### WooCommerce - Data
- Retrieve a list of available data endpoints.
- Get continents.
- Retrieve continent data.
- Get countries.
- Retrieve country data.
- Get currencies.
- Retrieve currency data.
- Retrieve current currency data.

[See Data API](https://woosignal.com/docs/api/1.0/data)

#### WooCommerce - System Status
- Get System Status Items

[See System Status API](https://woosignal.com/docs/api/1.0/system-status)

#### WooCommerce - Payment gateways
- Retrieve a Payment Gateway by id
- Get all the Payment Gateways
- Update a Payment Gateway

[See Payment gateways API](https://woosignal.com/docs/api/1.0/payment-gateways)

#### WooCommerce - Setting options
- Retrieve a specific Setting Option
- Get all the Setting Options
- Update a Setting Option by id
- Batch update Setting Options

[See Setting options API](https://woosignal.com/docs/api/1.0/setting-options)


Disclaimer: This plugin is not affiliated with or supported by Automattic, Inc. All logos and trademarks are the property of their respective owners.
