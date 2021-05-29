
class Product{
  int indx;
  String nombre;
  double precioAnterior;
  double descuento;
  double precioActual;
  double valordescuento;
  String imgProducto;
  String imgTiend;
  String nombTiend;
  int like;

  Product(this.indx,this.nombre,this.precioAnterior,this.descuento,this.precioActual,this.valordescuento,this.imgProducto,this.imgTiend,this.nombTiend,this.like);
}

class Products{
  List<Product> listProducts;

  Products(){
    listProducts=List<Product>();
    Product p= new Product(1,"Camisa hombre",200000.00,10,180000.00,20000,"https://picsum.photos/250?image=1","https://picsum.photos/250?image=2","Jaime Moda",1);
    Product p1= new Product(2,"Pantalón hombre",200000.00,10,180000.00,20000,"https://picsum.photos/250?image=3","https://picsum.photos/250?image=4","Jaime Moda",0);
    Product p2= new Product(3,"Medias tobilleras",200000.00,10,180000.00,20000,"https://picsum.photos/250?image=5","https://picsum.photos/250?image=6","Jaime Moda",0);
    Product p3= new Product(4,"Zapatos",200000.00,10,180000.00,20000,"https://picsum.photos/250?image=7","https://picsum.photos/250?image=8","Jaime Moda",1);
    Product p4= new Product(5,"Blusas mujer",200000.00,10,180000.00,20000,"https://picsum.photos/250?image=9","https://picsum.photos/250?image=10","Jaime Moda",1);
    Product p5= new Product(6,"Ropa interior",200000.00,10,180000.00,20000,"https://picsum.photos/250?image=11","https://picsum.photos/250?image=12","Jaime Moda",0);

    listProducts.add(p);
    listProducts.add(p1);
    listProducts.add(p2);
    listProducts.add(p3);
    listProducts.add(p4);
    listProducts.add(p5);
  }
}