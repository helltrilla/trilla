import 'package:app/layers/view/shared/ui/coffee_card.dart';
import 'package:app/layers/view/shared/detail_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTabIndex = 0;

  String dropdownValue = 'Indonesian';
  List<String> list = ['Indonesian', 'English', 'Russian'];

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isSearching = false;

  final List<String> items = [
    'Americano',
    'Caffe Mocha',
    'Flat White',
    'Latte',
    'Cappuccino',
  ];
  String? selectedItem;

  List<String> searchItems = [
    'Americano',
    'Caffe Mocha',
    'Flat White',
    'Latte',
    'Cappuccino',
    'milk',
    'black',
    'foam',
  ];

  List<String> get filteredItems {
    if (_searchQuery.isEmpty) {
      return [];
    }
    return searchItems
        .where(
          (item) => item.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  List<Map<String, dynamic>> get filteredCoffee {
    if (selectedCategory == 'All') {
      return coffeeMenu;
    }
    return coffeeMenu
        .where((coffee) => coffee['category'] == selectedCategory)
        .toList();
  }

  String? selectedCategory = 'All';
  final List<Map<String, dynamic>> coffeeMenu = [
    {
      'name': 'Americano',
      'price': '3.53',
      'description': 'Black coffee',
      'imagePath': 'assets/photo/americano.png',
      'route': '/americano',
      'category': 'Americano',
    },
    {
      'name': 'Caffe Mocha',
      'price': '4.53',
      'description': 'Deep Foam',
      'imagePath': 'assets/photo/mocha.png',
      'route': '/mocha',
      'category': 'Caffe Mocha',
    },
    {
      'name': 'Flat White',
      'price': '3.53',
      'description': 'Espresso',
      'imagePath': 'assets/photo/flat_white.png',
      'route': '/flat-white',
      'category': 'Flat White',
    },
    {
      'name': 'Latte',
      'price': '4.23',
      'description': 'Smooth milk',
      'imagePath': 'assets/photo/latte.png',
      'route': '/latte',
      'category': 'Latte',
    },
    {
      'name': 'Cappuccino',
      'price': '4.13',
      'description': 'Creamy foam',
      'imagePath': 'assets/photo/cappuccino.png',
      'route': '/cappuccino',
      'category': 'Cappuccino',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: (index) {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 201, 79, 43),
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.bell),
            activeIcon: Icon(CupertinoIcons.bell_fill),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }

  Widget _getBody() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildHomeScreen();
      case 1:
        return _buildCartScreen();
      case 2:
        return _buildNotificationsScreen();
      default:
        return _buildHomeScreen();
    }
  }

  Widget _buildHomeScreen() {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Container(
                height: 230,
                width: double.infinity,
                color: const Color.fromARGB(255, 34, 34, 34),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 11,
                        top: 30,
                        right: 330,
                      ),
                      child: Text(
                        'Location',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 166, 170, 172),
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      padding: const EdgeInsets.only(right: 300),
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 153, 65, 65),
                      ),
                      underline: Container(height: 0),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        onTap: () {
                          setState(() {
                            _isSearching = true;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search Coffee',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: Icon(
                            CupertinoIcons.search,
                            color: Colors.grey[400],
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    CupertinoIcons.clear,
                                    color: Colors.grey[400],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                      _searchQuery = '';
                                    });
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.brown.shade700,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(width: double.infinity, color: Colors.white),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -60),
                        child: Container(
                          height: 100,
                          width: 320,
                          decoration: BoxDecoration(
                            color: Colors.brown[700],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/photo/promo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.only(top: 8, bottom: 8),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = 'All';
                                });
                              },
                              child: Container(
                                width: 80,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedCategory == 'All'
                                      ? const Color.fromARGB(255, 201, 79, 43)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: selectedCategory == 'All'
                                        ? const Color.fromARGB(255, 201, 79, 43)
                                        : Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'All Coffee',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: selectedCategory == 'All'
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            for (final item in items)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = item;
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: selectedCategory == item
                                        ? const Color.fromARGB(255, 201, 79, 43)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: selectedCategory == item
                                          ? const Color.fromARGB(
                                              255,
                                              201,
                                              79,
                                              43,
                                            )
                                          : Colors.grey[300]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: selectedCategory == item
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Popular Coffees',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                      ),
                      if (filteredCoffee.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(32),
                          child: Center(
                            child: Text(
                              'No coffees in this category',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        )
                      else
                        ...filteredCoffee
                            .map(
                              (coffee) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: CoffeeCard(
                                  name: coffee['name'],
                                  price: coffee['price'],
                                  description: coffee['description'],
                                  imagePath: coffee['imagePath'],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailItem(
                                          coffeeName: coffee['name'],
                                          coffeePrice: coffee['price'],
                                          coffeeDescription:
                                              coffee['description'],
                                          coffeeImagePath: coffee['imagePath'],
                                        ),
                                      ),
                                    );
                                  },
                                  onAddPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${coffee['name']} добавлен в корзину',
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_isSearching)
          Container(
            color: Colors.black.withValues(alpha: 0.5),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    color: const Color.fromARGB(255, 34, 34, 34),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isSearching = false;
                                _searchController.clear();
                                _searchQuery = '';
                              });
                            },
                          ),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(color: Colors.white),
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: 'Search Coffee',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                            ),
                          ),
                          if (_searchQuery.isNotEmpty)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.brown[300]),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: _searchQuery.isEmpty
                          ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Start typing to search',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : filteredItems.isEmpty
                          ? Center(
                              child: Text(
                                'No results for "$_searchQuery"',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index) {
                                final item = filteredItems[index];
                                // Находим полную информацию о кофе
                                final selectedCoffee = coffeeMenu.firstWhere(
                                  (coffee) => coffee['name'] == item,
                                  orElse: () => {
                                    'name': item,
                                    'price': '0.00',
                                    'description': '',
                                    'imagePath': '',
                                  },
                                );
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailItem(
                                          coffeeName: selectedCoffee['name'],
                                          coffeePrice: selectedCoffee['price'],
                                          coffeeDescription:
                                              selectedCoffee['description'],
                                          coffeeImagePath:
                                              selectedCoffee['imagePath'],
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      _isSearching = false;
                                      _searchController.clear();
                                      _searchQuery = '';
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.brown[700],
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.coffee,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey[400],
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCartScreen() {
    return const Center(
      child: Text('Cart Screen', style: TextStyle(fontSize: 24)),
    );
  }

  Widget _buildNotificationsScreen() {
    return const Center(
      child: Text('Notifications Screen', style: TextStyle(fontSize: 24)),
    );
  }
}
