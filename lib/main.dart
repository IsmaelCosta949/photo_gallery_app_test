import 'package:flutter/material.dart';

final List<String> photoUrls = [
  'https://picsum.photos/id/1015/400/400',
  'https://picsum.photos/id/1016/400/400',
  'https://picsum.photos/id/1021/400/400',
  'https://picsum.photos/id/1025/400/400',
  'https://picsum.photos/id/1035/400/400',
  'https://picsum.photos/id/1043/400/400',
];

void main() {
  runApp(MyGalleryApp());
}

class MyGalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Galeria',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GalleryScreen(),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Galeria de Fotos'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                expandedIndex = null;
              });
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: photoUrls.length,
        itemBuilder: (context, index) {
          final isExpanded = expandedIndex == index;

          return Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                setState(() {
                  expandedIndex = isExpanded ? null : index;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 280),
                curve: Curves.easeInOut,
                width: isExpanded ? size.width : size.width / 2 - 16,
                height: isExpanded ? size.height : 200,
                decoration: BoxDecoration(
                  color: isExpanded ? Colors.indigo.shade100 : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(photoUrls[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                transform: isExpanded
                    ? Matrix4.identity()..scale(1.04)
                    : Matrix4.identity(),
              ),
            ),
          );
        },
      ),
    );
  }
}
