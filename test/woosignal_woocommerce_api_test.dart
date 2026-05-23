import 'package:flutter_test/flutter_test.dart';
import 'package:woosignal/models/response/product.dart';
import 'package:woosignal/models/response/order.dart';
import 'package:woosignal/models/response/customer.dart' hide Billing, Shipping;
import 'package:woosignal/models/response/coupon.dart';
import 'package:woosignal/models/response/refund.dart';
import 'package:woosignal/models/response/product_category.dart';
import 'package:woosignal/models/response/product_review.dart';
import 'package:woosignal/models/response/tax_rate.dart';
import 'package:woosignal/models/response/shipping_zone.dart';

import 'fixtures/test_data.dart';

void main() {
  group('Model Tests', () {
    group('Product', () {
      test('fromJson creates Product with correct values', () {
        final product = Product.fromJson(sampleProductJson);

        expect(product.id, 123);
        expect(product.name, 'Test Product');
        expect(product.slug, 'test-product');
        expect(product.type, 'simple');
        expect(product.status, 'publish');
        expect(product.sku, 'TEST-SKU-001');
        expect(product.price, '29.99');
        expect(product.regularPrice, '39.99');
        expect(product.salePrice, '29.99');
        expect(product.onSale, true);
        expect(product.stockStatus, 'instock');
        expect(product.stockQuantity, 100);
        expect(product.manageStock, true);
        expect(product.featured, false);
        expect(product.virtual, false);
        expect(product.downloadable, false);
      });

      test('fromJson parses dimensions correctly', () {
        final product = Product.fromJson(sampleProductJson);

        expect(product.dimensions.length, '10');
        expect(product.dimensions.width, '5');
        expect(product.dimensions.height, '2');
      });

      test('fromJson parses categories correctly', () {
        final product = Product.fromJson(sampleProductJson);

        expect(product.categories.length, 1);
        expect(product.categories.first.id, 1);
        expect(product.categories.first.name, 'Uncategorized');
        expect(product.categories.first.slug, 'uncategorized');
      });

      test('fromJson parses images correctly', () {
        final product = Product.fromJson(sampleProductJson);

        expect(product.images.length, 1);
        expect(product.images.first.id, 456);
        expect(product.images.first.src, 'https://example.com/image.jpg');
      });

      test('toJson produces correct output', () {
        final product = Product.fromJson(sampleProductJson);
        final json = product.toJson();

        expect(json['id'], 123);
        expect(json['name'], 'Test Product');
        expect(json['sku'], 'TEST-SKU-001');
        expect(json['price'], '29.99');
        expect(json['on_sale'], true);
      });

      test('fromJson handles related IDs', () {
        final product = Product.fromJson(sampleProductJson);

        expect(product.relatedIds, [124, 125, 126]);
        expect(product.upsellIds, [127]);
        expect(product.crossSellIds, [128]);
      });
    });

    group('Order', () {
      test('fromJson creates Order with correct values', () {
        final order = Order.fromJson(sampleOrderJson);

        expect(order.id, 789);
        expect(order.number, '789');
        expect(order.status, 'processing');
        expect(order.currency, 'USD');
        expect(order.total, '37.49');
        expect(order.totalTax, '2.50');
        expect(order.customerId, 1);
        expect(order.paymentMethod, 'stripe');
      });

      test('fromJson parses billing correctly', () {
        final order = Order.fromJson(sampleOrderJson);

        expect(order.billing, isNotNull);
        expect(order.billing!.firstName, 'John');
        expect(order.billing!.lastName, 'Doe');
        expect(order.billing!.email, 'john@example.com');
        expect(order.billing!.city, 'New York');
        expect(order.billing!.state, 'NY');
        expect(order.billing!.country, 'US');
      });

      test('fromJson parses shipping correctly', () {
        final order = Order.fromJson(sampleOrderJson);

        expect(order.shipping, isNotNull);
        expect(order.shipping!.firstName, 'John');
        expect(order.shipping!.lastName, 'Doe');
        expect(order.shipping!.address1, '123 Main St');
        expect(order.shipping!.postcode, '10001');
      });

      test('fromJson parses line items correctly', () {
        final order = Order.fromJson(sampleOrderJson);

        expect(order.lineItems, isNotNull);
        expect(order.lineItems!.length, 1);
        expect(order.lineItems!.first.name, 'Test Product');
        expect(order.lineItems!.first.productId, 123);
        expect(order.lineItems!.first.quantity, 1);
        expect(order.lineItems!.first.total, '29.99');
      });

      test('fromJson parses shipping lines correctly', () {
        final order = Order.fromJson(sampleOrderJson);

        expect(order.shippingLines, isNotNull);
        expect(order.shippingLines!.length, 1);
        expect(order.shippingLines!.first.methodTitle, 'Flat Rate');
        expect(order.shippingLines!.first.total, '5.00');
      });

      test('toJson produces correct output', () {
        final order = Order.fromJson(sampleOrderJson);
        final json = order.toJson();

        expect(json['id'], 789);
        expect(json['status'], 'processing');
        expect(json['total'], '37.49');
        expect(json['billing']['first_name'], 'John');
      });
    });

    group('Customer', () {
      test('fromJson creates Customer with correct values', () {
        final customer = Customer.fromJson(sampleCustomerJson);

        expect(customer.id, 1);
        expect(customer.email, 'john@example.com');
        expect(customer.firstName, 'John');
        expect(customer.lastName, 'Doe');
        expect(customer.username, 'johndoe');
        expect(customer.role, 'customer');
        expect(customer.isPayingCustomer, true);
      });

      test('fromJson parses billing correctly', () {
        final customer = Customer.fromJson(sampleCustomerJson);

        expect(customer.billing, isNotNull);
        expect(customer.billing!.firstName, 'John');
        expect(customer.billing!.email, 'john@example.com');
        expect(customer.billing!.phone, '555-1234');
      });

      test('fromJson parses shipping correctly', () {
        final customer = Customer.fromJson(sampleCustomerJson);

        expect(customer.shipping, isNotNull);
        expect(customer.shipping!.city, 'New York');
        expect(customer.shipping!.state, 'NY');
      });

      test('toJson produces correct output', () {
        final customer = Customer.fromJson(sampleCustomerJson);
        final json = customer.toJson();

        expect(json['id'], 1);
        expect(json['email'], 'john@example.com');
        expect(json['first_name'], 'John');
        expect(json['is_paying_customer'], true);
      });
    });

    group('Coupon', () {
      test('fromJson creates Coupon with correct values', () {
        final coupon = Coupon.fromJson(sampleCouponJson);

        expect(coupon.id, 100);
        expect(coupon.code, 'SAVE10');
        expect(coupon.amount, '10.00');
        expect(coupon.discountType, 'percent');
        expect(coupon.description, '10% off your order');
        expect(coupon.usageCount, 5);
        expect(coupon.usageLimit, 100);
        expect(coupon.usageLimitPerUser, 1);
        expect(coupon.individualUse, false);
        expect(coupon.freeShipping, false);
        expect(coupon.excludeSaleItems, false);
      });

      test('toJson produces correct output', () {
        final coupon = Coupon.fromJson(sampleCouponJson);
        final json = coupon.toJson();

        expect(json['id'], 100);
        expect(json['code'], 'SAVE10');
        expect(json['discount_type'], 'percent');
        expect(json['amount'], '10.00');
      });
    });

    group('Refund', () {
      test('fromJson creates Refund with correct values', () {
        final refund = Refund.fromJson(sampleRefundJson);

        expect(refund.id, 200);
        expect(refund.amount, '29.99');
        expect(refund.reason, 'Customer requested refund');
        expect(refund.refundedBy, 1);
      });

      test('toJson produces correct output', () {
        final refund = Refund.fromJson(sampleRefundJson);
        final json = refund.toJson();

        expect(json['id'], 200);
        expect(json['amount'], '29.99');
        expect(json['reason'], 'Customer requested refund');
      });
    });

    group('ProductCategory', () {
      test('fromJson creates ProductCategory with correct values', () {
        final category = ProductCategory.fromJson(sampleCategoryJson);

        expect(category.id, 1);
        expect(category.name, 'Clothing');
        expect(category.slug, 'clothing');
        expect(category.parent, 0);
        expect(category.description, 'All clothing items');
        expect(category.count, 25);
      });

      test('toJson produces correct output', () {
        final category = ProductCategory.fromJson(sampleCategoryJson);
        final json = category.toJson();

        expect(json['id'], 1);
        expect(json['name'], 'Clothing');
        expect(json['slug'], 'clothing');
      });
    });

    group('ProductReview', () {
      test('fromJson creates ProductReview with correct values', () {
        final review = ProductReview.fromJson(sampleReviewJson);

        expect(review.id, 50);
        expect(review.productId, 123);
        expect(review.status, 'approved');
        expect(review.reviewer, 'Jane Smith');
        expect(review.reviewerEmail, 'jane@example.com');
        expect(review.review, 'Great product! Highly recommended.');
        expect(review.rating, 5);
        expect(review.verified, true);
      });

      test('toJson produces correct output', () {
        final review = ProductReview.fromJson(sampleReviewJson);
        final json = review.toJson();

        expect(json['id'], 50);
        expect(json['rating'], 5);
        expect(json['reviewer'], 'Jane Smith');
      });
    });

    group('TaxRate', () {
      test('fromJson creates TaxRate with correct values', () {
        final taxRate = TaxRate.fromJson(sampleTaxRateJson);

        expect(taxRate.id, 1);
        expect(taxRate.country, 'US');
        expect(taxRate.state, 'NY');
        expect(taxRate.rate, '8.875');
        expect(taxRate.name, 'NY Tax');
        expect(taxRate.shipping, true);
        expect(taxRate.compound, false);
      });

      test('toJson produces correct output', () {
        final taxRate = TaxRate.fromJson(sampleTaxRateJson);
        final json = taxRate.toJson();

        expect(json['id'], 1);
        expect(json['country'], 'US');
        expect(json['rate'], '8.875');
      });
    });

    group('ShippingZone', () {
      test('fromJson creates ShippingZone with correct values', () {
        final zone = ShippingZone.fromJson(sampleShippingZoneJson);

        expect(zone.id, 1);
        expect(zone.name, 'United States');
        expect(zone.order, 0);
      });

      test('toJson produces correct output', () {
        final zone = ShippingZone.fromJson(sampleShippingZoneJson);
        final json = zone.toJson();

        expect(json['id'], 1);
        expect(json['name'], 'United States');
      });
    });
  });

  group('Nested Model Tests', () {
    group('Order Billing', () {
      test('Billing fromJson and toJson roundtrip', () {
        final billing = Billing.fromJson(
            sampleOrderJson['billing'] as Map<String, dynamic>);
        final json = billing.toJson();

        expect(json['first_name'], 'John');
        expect(json['last_name'], 'Doe');
        expect(json['address_1'], '123 Main St');
        expect(json['city'], 'New York');
        expect(json['state'], 'NY');
        expect(json['postcode'], '10001');
        expect(json['country'], 'US');
        expect(json['email'], 'john@example.com');
        expect(json['phone'], '555-1234');
      });
    });

    group('Order Shipping', () {
      test('Shipping fromJson and toJson roundtrip', () {
        final shipping = Shipping.fromJson(
            sampleOrderJson['shipping'] as Map<String, dynamic>);
        final json = shipping.toJson();

        expect(json['first_name'], 'John');
        expect(json['last_name'], 'Doe');
        expect(json['address_1'], '123 Main St');
        expect(json['city'], 'New York');
      });
    });

    group('Product Category', () {
      test('Category fromJson and toJson roundtrip', () {
        final categoryData = (sampleProductJson['categories'] as List).first
            as Map<String, dynamic>;
        final category = Category.fromJson(categoryData);
        final json = category.toJson();

        expect(json['id'], 1);
        expect(json['name'], 'Uncategorized');
        expect(json['slug'], 'uncategorized');
      });
    });

    group('Line Items', () {
      test('LineItems fromJson and toJson roundtrip', () {
        final lineItemData = (sampleOrderJson['line_items'] as List).first
            as Map<String, dynamic>;
        final lineItem = LineItems.fromJson(lineItemData);
        final json = lineItem.toJson();

        expect(json['id'], 1);
        expect(json['name'], 'Test Product');
        expect(json['product_id'], 123);
        expect(json['quantity'], 1);
        expect(json['total'], '29.99');
        expect(json['sku'], 'TEST-SKU-001');
      });
    });

    group('Shipping Lines', () {
      test('ShippingLines fromJson and toJson roundtrip', () {
        final shippingLineData = (sampleOrderJson['shipping_lines'] as List)
            .first as Map<String, dynamic>;
        final shippingLine = ShippingLines.fromJson(shippingLineData);
        final json = shippingLine.toJson();

        expect(json['id'], 1);
        expect(json['method_title'], 'Flat Rate');
        expect(json['method_id'], 'flat_rate');
        expect(json['total'], '5.00');
      });
    });
  });

  group('Edge Case Tests', () {
    test('Product with empty lists', () {
      final productJson = Map<String, dynamic>.from(sampleProductJson);
      productJson['categories'] = <Map<String, dynamic>>[];
      productJson['tags'] = <Map<String, dynamic>>[];
      productJson['images'] = <Map<String, dynamic>>[];
      productJson['attributes'] = <Map<String, dynamic>>[];
      productJson['default_attributes'] = <Map<String, dynamic>>[];
      productJson['downloads'] = <Map<String, dynamic>>[];
      productJson['meta_data'] = <Map<String, dynamic>>[];
      productJson['related_ids'] = <int>[];
      productJson['upsell_ids'] = <int>[];
      productJson['cross_sell_ids'] = <int>[];
      productJson['variations'] = <int>[];
      productJson['grouped_products'] = <int>[];

      final product = Product.fromJson(productJson);

      expect(product.categories, isEmpty);
      expect(product.tags, isEmpty);
      expect(product.images, isEmpty);
      expect(product.attributes, isEmpty);
      expect(product.downloads, isEmpty);
    });

    test('Order with null optional fields', () {
      final orderJson = Map<String, dynamic>.from(sampleOrderJson);
      orderJson['date_completed'] = null;
      orderJson['date_completed_gmt'] = null;
      orderJson['transaction_id'] = '';

      final order = Order.fromJson(orderJson);

      expect(order.dateCompleted, isNull);
      expect(order.dateCompletedGmt, isNull);
      expect(order.transactionId, '');
    });

    test('Product with sale price as number', () {
      final productJson = Map<String, dynamic>.from(sampleProductJson);
      productJson['sale_price'] = 29.99;

      final product = Product.fromJson(productJson);

      expect(product.salePrice, '29.99');
    });

    test('Customer with empty meta_data', () {
      final customerJson = Map<String, dynamic>.from(sampleCustomerJson);
      customerJson['meta_data'] = <Map<String, dynamic>>[];

      final customer = Customer.fromJson(customerJson);

      expect(customer.metaData, isEmpty);
    });
  });
}
