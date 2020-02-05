# WooCommerce API Dart plugin

[Official WooSignal WooCommerce package](https://woosignal.com)

Build apps for WooCommerce easier with our new package.
Our API provides many requests types e.g. getProducts, getOrders, getCustomers and many more.
Free to get started, see the simple examples below

For help getting started with WooSignal, view our
[online documentation](https://woosignal.com/docs/api/1.0/overview), which offers a more detail guide.

## Usage
To use this plugin, add `woosignal` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

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

Disclaimer: This plugin is not affiliated with or supported by Automattic, Inc. All logos and trademarks are the property of their respective owners.