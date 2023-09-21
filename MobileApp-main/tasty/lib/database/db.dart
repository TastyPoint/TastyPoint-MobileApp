import 'package:tasty/model/Product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{
  Future<Database> initializaDB() async{
    String path=await getDatabasesPath();
    return openDatabase(
      join(path,'dbproducts.db'),
      onCreate: (database,version) async{
        await database.execute(
          'CREATE TABLE products(id INTEGER PRIMARY KEY, title TEXT, subtitle TEXT, description TEXT, image TEXT, cantidad INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertarProducto(Product p) async {
    final db = await initializaDB();
    final existingProduct = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [p.id],
      limit: 1,
    );

    if (existingProduct.isNotEmpty) {
      final int? existingCantidad = existingProduct.first['cantidad'] as int?;
      final int newCantidad = (existingCantidad ?? 0) + 1;
      p.cantidad = newCantidad;
      await db.update('products', p.toMap(), where: 'id = ?', whereArgs: [p.id]);
    } else {
      p.cantidad = 1;
      await db.insert('products', p.toMap());
    }
  }






  Future<List<Product>> listAll() async{
    final db=await initializaDB();
    final List<Map<String, dynamic>> query=await db.query('products');
    return query.map((e) => Product.forMap(e)).toList();
  }

  Future<void> deleteProducto(int id) async {
    final db = await initializaDB();
    final existingProduct = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (existingProduct.isNotEmpty) {
      final int? existingCantidad = existingProduct.first['cantidad'] as int?;
      final int newCantidad = (existingCantidad ?? 0) - 1;
      if (newCantidad > 0) {
        await db.update('products', {'cantidad': newCantidad}, where: 'id = ?', whereArgs: [id]);
      } else {
        await db.delete('products', where: 'id = ?', whereArgs: [id]);
      }
    }
  }

  Future<void> deleteProductos(int id) async{
    final db=await initializaDB();
    await db.delete('products',where: 'id=?',whereArgs: [id]);
  }

  Future<void> updateProductQuantity(int id, int quantity) async {
    final db = await initializaDB();
    await db.update('products', {'quantity': quantity}, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllProducts() async {
    final db = await initializaDB();
    await db.delete('products');
  }
}