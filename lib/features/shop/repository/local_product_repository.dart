import '../domain/product.dart';
import 'product_repository.dart';

/// Bundled catalog. Prices must be re-validated server-side once a
/// products API exists (see CLAUDE.md: never trust client-submitted
/// prices) — this local list is a UI-only stand-in.
class LocalProductRepository implements ProductRepository {
  @override
  List<Product> list() => _products;

  static const _products = <Product>[
    Product(
      id: '1',
      name: 'Mango Tree Sapling',
      category: 'Plants',
      price: 450,
      rating: 4.9,
      stock: 25,
      description:
          'Healthy mango sapling suitable for home gardens and orchards.',
      imageUrl: 'https://tse1.mm.bing.net/th/id/OIP.aKKuxXGe4WgCMzqtlKydwQHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Product(
      id: '2',
      name: 'Guava Plant',
      category: 'Plants',
      price: 280,
      rating: 4.8,
      stock: 20,
      description:
          'High-yield guava plant that grows well in most home gardens.',
      imageUrl: 'https://tse1.mm.bing.net/th/id/OIP.6KLpPBiWRiD7WrGOsU_abgHaJ4?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Product(
      id: '3',
      name: 'Clay Flower Pot',
      category: 'Pots',
      price: 120,
      rating: 4.7,
      stock: 40,
      description:
          'Traditional terracotta pot ideal for indoor and outdoor plants.',
      imageUrl: 'https://tse1.explicit.bing.net/th/id/OIP.xrpSKcFpbdd7xU5cEwQMhAHaGV?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Product(
      id: '4',
      name: 'Vermicompost Organic Fertilizer',
      category: 'Fertilizers',
      price: 180,
      rating: 4.9,
      stock: 60,
      unit: '1 kg',
      description:
          'Organic vermicompost that improves soil fertility and plant growth.',
      imageUrl: 'https://tse1.mm.bing.net/th/id/OIP.KE5ma4NIt2pDZuzlyq9k5QHaE7?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Product(
      id: '5',
      name: 'Garden Watering Can',
      category: 'Tools',
      price: 250,
      rating: 4.8,
      stock: 18,
      description:
          'Durable watering can for everyday gardening and plant care.',
      imageUrl: 'https://i5.walmartimages.com/seo/Wzzjkit-Watering-Can-Indoor-Plants-Long-Spout-Watering-Can-Outdoor-Flower-Patterns-Indoor-Watering-Can-Handle-Plastic-Plant-Watering-Can-Garden-Plant_8b273477-c2d8-4206-a62f-7fda0970bea1.033b96f50e8577101a2e19aef847748f.jpeg',
    ),
    Product(
      id: '6',
      name: 'Premium Rice Seeds',
      category: 'Seeds',
      price: 90,
      rating: 4.9,
      stock: 120,
      unit: '500 g',
      description: 'High-quality rice seeds suitable for home cultivation.',
      imageUrl: 'https://tse1.mm.bing.net/th/id/OIP.08MlnJZ9eldrFpuqLb3dyAHaHa?r=0&w=500&h=500&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Product(
      id: '7',
      name: 'Jackfruit Sapling',
      category: 'Plants',
      price: 380,
      rating: 4.8,
      stock: 15,
      description: 'Healthy jackfruit sapling with excellent fruit production.',
      imageUrl: 'https://tse3.mm.bing.net/th/id/OIP.iiJe4qvpuxYEw8wZUifv6wAAAA?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
    Product(
      id: '8',
      name: 'Hand Garden Trowel',
      category: 'Tools',
      price: 150,
      rating: 4.6,
      stock: 35,
      description: 'Strong steel trowel for digging, transplanting, and gardening tasks.',
      imageUrl: 'https://tse3.mm.bing.net/th/id/OIP.aJ5M5laNeU4wfYrk-mVYtQHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
  ];
}
