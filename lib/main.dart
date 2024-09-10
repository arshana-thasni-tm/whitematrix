import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(ProductApp());
}

class ProductApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductGridPage(),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final double price;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}

// Global cart list to store added products
List<Product> cart = [];

class ProductGridPage extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Apple iPhone 13', imageUrl: 'https://www.dslr-zone.com/wp-content/uploads/2021/10/2-2-800x800.jpeg', price: 799.99),
    Product(name: 'Samsung Galaxy S21', imageUrl: 'https://i5.walmartimages.com/asr/4014d1d5-2430-46cf-a2b6-526ebf2ff569.7fff876a828d1392c131ee20a014544b.jpeg', price: 699.99),
    Product(name: 'Sony WH-1000XM4', imageUrl: 'https://baseus.io/cdn/shop/files/Baseus_Audio_1024x1024.jpg?v=1701293236', price: 349.99),
    Product(name: 'MacBook Pro', imageUrl: 'https://cdn.shopify.com/s/files/1/0259/1735/products/macbook_air_13_inch_black_gloss_skin_d60076ae-2667-4171-9c68-ca0f9fc51156_2048x.jpg?v=1591971113', price: 1299.99),
    Product(name: 'Dell XPS 13', imageUrl: 'https://th.bing.com/th/id/OIP.ME9tV5xriIN1ahoNJ8V9sgHaDt?w=1800&h=900&rs=1&pid=ImgDetMain', price: 999.99),
    Product(name: 'Apple Watch Series 6', imageUrl: 'https://www.bhphotovideo.com/images/images2500x2500/apple_mg133ll_a_watch_series_6_gps_1594549.jpg', price: 399.99),
    Product(name: 'Bose QuietComfort 35 II', imageUrl: 'https://th.bing.com/th/id/OIP.PiZhyGEuR4B98hTsIfrWVwHaHa?rs=1&pid=ImgDetMain', price: 299.99),
    Product(name: 'Sony PlayStation 5', imageUrl: 'https://cdn.wccftech.com/wp-content/uploads/2021/09/Sony-PlayStation-5-Pro-Console.jpg', price: 499.99),
    Product(name: 'Xbox Series X', imageUrl: 'https://th.bing.com/th/id/OIP.HsKkUcGGvfrFO4RrKtFfDQAAAA?rs=1&pid=ImgDetMain', price: 499.99),
    Product(name: 'Google Pixel 5', imageUrl: 'https://mobilecheck.pk/wp-content/uploads/2023/09/Google-Pixel-5-1.png', price: 649.99),
    Product(name: 'Nikon D3500', imageUrl: 'https://www.dzoom.org.es/wp-content/uploads/2018/10/nikon-d3500-caracter%C3%ADsticas-analisis-portada.jpg', price: 449.99),
    Product(name: 'Canon EOS Rebel T7', imageUrl: 'https://www.lifewire.com/thmb/Y2fEwZt0dg_am4nHzZvdg0Po9ys=/1000x1000/filters:no_upscale():max_bytes(150000):strip_icc()/02LW493499_HeroSquare-4c18cc3223364781800e0250736f1296.jpg', price: 549.99),
    Product(name: 'Apple AirPods Pro', imageUrl: 'https://thephonetailor.com/wp-content/uploads/IMG_8288-560x560.jpg', price: 249.99),
    Product(name: 'GoPro HERO9', imageUrl: 'https://www.cameralabs.com/wp-content/uploads/2020/09/gopro-hero-9-black-hero-1.jpg', price: 399.99),
    Product(name: 'Fitbit Charge 4', imageUrl: 'https://th.bing.com/th/id/OIP.YtBUhE2GgW3WQ2PoZhXv8QHaHS?rs=1&pid=ImgDetMain', price: 149.99),
    Product(name: 'Roku Streaming Stick+', imageUrl: 'https://www.homecinemachoice.com/images/styles/600_wide/public/roku_streaming_stick_4kmod.jpg', price: 49.99),
    Product(name: 'Amazon Echo Dot', imageUrl: 'https://www.notebookcheck.net/fileadmin/_processed_/a/2/csm_Echo_Dot_Black_Low_Angle_On_b5e8fcdbcc.jpg', price: 29.99),
    Product(name: 'Ring Video Doorbell', imageUrl: 'https://th.bing.com/th/id/R.51fa57faeaa40a4a5bf2b2dd38ec0dbc?rik=CnnfHR0IsKDGMg&riu=http%3a%2f%2fcdn.shopify.com%2fs%2ffiles%2f1%2f2418%2f9735%2fproducts%2frvdgen2_vb.png%3fv%3d1591775701&ehk=9XF8fOtTyZYzMlKxmFlLOMRZ%2fkC%2fF7poQVXRG8YSIuQ%3d&risl=&pid=ImgRaw&r=0', price: 99.99),
    Product(name: 'Nvidia Shield TV', imageUrl: 'https://www.nvidia.com/content/dam/en-zz/Solutions/SHIELD/specs/shield-tv-pro/nvidia-shield-tv-pro-og-image-1200x630.jpg', price: 199.99),
    Product(name: 'Nest Thermostat', imageUrl: 'https://www.tradeboilerparts.co.uk/Graphics/Std_Product_Images/nest-learning-thermostat-3rd-generation-stainless-steel-4409-p.jpg', price: 129.99),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Electronics',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white, size: 25),
            onPressed: () {
              // Navigate to the Cart Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 products per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(product: product);
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // Navigate to the ProductDetailPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Product Detail Page
class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
            ),
            SizedBox(height: 20),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 22, color: Colors.grey[700]),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add product to the global cart list
                    cart.add(product);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Buy Now action
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Proceed to buy ${product.name}')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text(
                    'Buy Now',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get totalCost {
    return cart.fold(0.0, (sum, item) => sum + item.price);
  }

  void _checkout() async {
    // Simulate payment and generate receipt
    final transactionId = DateTime.now().millisecondsSinceEpoch.toString();
    final date = DateTime.now().toString();

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Receipt', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Text('Transaction ID: $transactionId'),
              pw.Text('Date of Purchase: $date'),
              pw.SizedBox(height: 20),
              pw.Text('Products:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              ...cart.map((product) => pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(product.name),
                  pw.Text('x1'),
                  pw.Text('\$${product.price.toStringAsFixed(2)}'),
                ],
              )),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Total Price:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                  pw.Text('\$${totalCost.toStringAsFixed(2)}'),
                ],
              ),
            ],
          );
        },
      ),
    );

    // Print the PDF or save it to file
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    // Clear the cart
    setState(() {
      cart.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaction completed. Receipt generated.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: cart.isEmpty
          ? Center(
        child: Text(
          'Your Cart is Empty!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return ListTile(
                  leading: Image.network(
                    product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        cart.remove(product);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${product.name} removed from cart')),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Cost: \$${totalCost.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _checkout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'Proceed to Checkout',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
