# WooCommerce API Dart plugin

[Official WooSignal WooCommerce package](https://woosignal.com)

Build apps for WooCommerce easier with our new package.
Our API provides many requests types e.g. getProducts, getOrders, getCustomers and many more.
Free to get started, see the simple examples below.

For help getting started with WooSignal, view our
[online documentation](https://woosignal.com/docs/api/1.0/overview), which offers a more detail guide.

### Getting Started #
In your flutter project add the dependency:

``` dart 
dependencies:
  ...
  woosignal: ^1.4.0
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
- Update a Product by id
- Delete a Product by id 
- Create a Product 
- Create, Delete and  Update Product Multiple Time.
<!--  -->

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


#### WooCommerce - Shipping Methods
- Get Shipping Methods

[See Shipping Methods API](https://woosignal.com/docs/api/1.0/shipping-methods)


#### WooCommerce - Orders
- Get Orders
- Retrive a Order by id
- Create an Order
- Update an Order
- Create, Delete and  Update Order Multiple Time.

[See Order API](https://woosignal.com/docs/api/1.0/orders)


#### WooCommerce - Customers
- Get Customers
- Create a Customer
- Delete a Customer
- Update a Customer
- Create, Delete and  Update Product Multiple Time.

[See Customers API](https://woosignal.com/docs/api/1.0/customers)

#### WooCommerce - API Orders Notes
- List all Orders Notes
- Retrive a Orders Notes by id
- Delete a Orders Notes by id
- Create a Orders Notes

[See Orders Notes API](https://woosignal.com/docs/api/1.0/order-notes)

#### WooCommerce - Refunds
<!-- The refunds API allows you to create, view, and delete individual refunds. -->
- List all all the refunds from an order.
- Retrive a retrieve and view a specific refund from an order
- Delete a delete an order refund.
- Create a new refund for an order.

[See Refunds API](https://woosignal.com/docs/api/1.0/order-refund)

#### WooCommerce - Coupons
<!-- The coupons API allows you to create, view, update, and delete individual, or a batch, of coupon codes. -->
- List all the coupons that have been created.
- Retrive and view a specific coupon by ID
- This API lets you make changes  or update to a coupon.
- Delete a delete a coupon.
- Create, Delete and  Update Coupons Multiple Time.

[See Coupons API](https://woosignal.com/docs/api/1.0/coupons)

#### WooCommerce - Reports
<!-- The reports API allows you to view all types of reports available. -->

<!-- Retrieve and view a simple list of available reports. -->
- List all the Reports that have been created.
<!-- Retrieve sales report -->
- API lets you retrieve and view a sales report.
<!-- Retrieve top sellers report -->
- API lets you retrieve and view a list of top sellers report.
<!-- Retrieve coupons totals -->
- API lets you retrieve and view coupons totals report.
<!-- Retrieve customers totals -->
- API lets you retrieve and view customers totals report.
<!-- Retrieve orders totals -->
- API lets you retrieve and view orders totals report.
<!-- Retrieve products totals -->
- API lets you retrieve and view products totals report
<!-- Retrieve reviews totals -->
- API lets you retrieve and view reviews totals report.

[See Reports API](https://woosignal.com/docs/api/1.0/reports)

#### WooCommerce - Data
<!-- The data API allows you to view all types of data available. -->
<!-- List all data -->
- Retrieve and view a simple list of available data endpoints.
<!-- List all continents -->
- API helps you to view all the continents..
<!-- Retrieve continent data -->
- API lets you retrieve and view a continent data.
<!-- List all countries -->
- API helps you to view all the countries..
<!-- Retrieve country data -->
- API lets you retrieve and view a country data.
<!-- List all currencies -->
- API helps you to view all the currencies.
<!-- Retrieve currency data -->
- API lets you retrieve and view a currency data.
<!-- Retrieve current currency -->
- API lets you retrieve and view store's current currency data.

[See Data API](https://woosignal.com/docs/api/1.0/data)

#### WooCommerce - System Status
<!-- The system status API allows you to view all system status items. -->
<!-- List all system status items -->
- API helps you to view all the system status items.

[See System Status API](https://woosignal.com/docs/api/1.0/system-status)

#### WooCommerce - Payment gateways
<!--The payment gateways API allows you to view, and update individual payment gateways. 
  Results are not paginated - all gateways will be returned -->
<!-- Retrieve an payment gateway -->
- API lets you retrieve and view a specific payment gateway.
<!-- List all payment gateways -->
- API helps you to view all the payment gateways.
<!-- Update a payment gateway -->
- API lets you make changes to a payment gateway.

[See Payment gateways API](https://woosignal.com/docs/api/1.0/payment-gateways)

#### WooCommerce - Setting options
<!--The payment gateways API allows you to view, and update individual payment gateways. 
  Results are not paginated - all gateways will be returned -->
<!-- Retrieve a setting option -->
- API lets you retrieve and view a specific setting option.
<!-- List all setting options -->
- API helps you to view all the setting options.
<!-- Update a setting option -->
- API lets you make changes to a setting option.
<!-- Batch update setting options -->
- Create, Delete and  Update Setting options Multiple Time.

[See Setting options API](https://woosignal.com/docs/api/1.0/setting-options)


Disclaimer: This plugin is not affiliated with or supported by Automattic, Inc. All logos and trademarks are the property of their respective owners.