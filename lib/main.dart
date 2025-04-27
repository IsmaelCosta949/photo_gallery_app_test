import 'package:flutter/material.dart';

void main() {
  runApp(PhotoGalleryApp());
}

class PhotoGalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galeria de Fotos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PhotoGalleryScreen(),
    );
  }
}

class PhotoGalleryScreen extends StatefulWidget {
  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  int? expandedIndex;

  final List<String> photos = [
    'https://picsum.photos/id/1015/400/400',
    'https://picsum.photos/id/1016/400/400',
    'https://picsum.photos/id/1021/400/400',
    'https://picsum.photos/id/1025/400/400',
    'https://picsum.photos/id/1035/400/400',
    'https://picsum.photos/id/1043/400/400',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Galeria de Fotos'),
      ),
      body: Center(
        child: GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: photos.length,
          itemBuilder: (context, index) {
            final isExpanded = expandedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isExpanded) {
                    expandedIndex = null;
                  } else {
                    expandedIndex = index;
                  }
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: isExpanded ? size.width : null,
                height: isExpanded ? size.height : null,
                decoration: BoxDecoration(
                  color: isExpanded ? Colors.blue.shade100 : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(photos[index]),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
