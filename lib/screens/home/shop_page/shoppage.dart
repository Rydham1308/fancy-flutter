import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../API/productlist.dart';
import '../../../API/remote_service.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _current = 0;

  List<Products>? productData;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    productData = await RemoteService().getData();
    if (productData != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Visibility(
            visible: isLoaded,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.zero,
                      child: CarouselSlider(
                        items: [
                          getCarouselPage('orange', 'Winter', '30', false),
                          getCarouselPage('pink', 'Wedding', '15', true),
                          getCarouselPage('yellow', 'Summer', '50', false),
                          getCarouselPage('blue', 'Modern', '25', true),
                        ],
                        //Slider Container properties
                        options: CarouselOptions(
                            height: 400.0,
                            autoPlay: true,
                            aspectRatio: 5 / 4,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1111),
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 355, left: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              AnimatedSmoothIndicator(
                                activeIndex: _current,
                                count: 4,
                                effect: const ScaleEffect(
                                  activeStrokeWidth: 5,
                                  scale: 5,
                                  spacing: 20,
                                  dotColor: Colors.white,
                                  paintStyle: PaintingStyle.fill,
                                  activePaintStyle: PaintingStyle.stroke,
                                  activeDotColor: Colors.white60,
                                  dotHeight: 5,
                                  dotWidth: 5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Text(
                        'Designer Collection',
                        style: TextStyle(
                          fontFamily: 'Raleway-Bold',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40, top: 10, bottom: 10),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Show all',
                          style: TextStyle(
                            fontFamily: 'Raleway-Bold',
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productData?.length,
                  padding: const EdgeInsets.all(5),
                  itemBuilder: (context, index) {
                    return Text(productData![index].brandname);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Text(
                        'Designer Collection',
                        style: TextStyle(
                          fontFamily: 'Raleway-Bold',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40, top: 10, bottom: 10),
                      child: GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Show all',
                          style: TextStyle(
                            fontFamily: 'Raleway-Bold',
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  // itemCount: productData?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Colors.black12,
                      elevation: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //images
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CarouselSlider(
                                  items: [
                                    Image.network(
                                      productData![index].image3,
                                      fit: BoxFit.fill,
                                    ),
                                    Image.network(
                                      productData![index].image2,
                                      fit: BoxFit.cover,
                                    ),
                                    Image.network(
                                      productData![index].image1,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                  //Slider Container properties
                                  options: CarouselOptions(
                                    height: 500,
                                    autoPlay: true,
                                    aspectRatio: 16 / 9,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 1111),
                                    viewportFraction: 1,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: GestureDetector(
                                  onTap: () {
                                    // setState(() {
                                    //   if (apidata![index].favorite == true ) {
                                    //     searchList[index].FavouriteUser = 2;
                                    //   } else if (searchList[
                                    //   index]
                                    //       .FavouriteUser ==
                                    //       2) {
                                    //     searchList[
                                    //     index]
                                    //         .FavouriteUser = 1;
                                    //   }
                                    //   db.updateFavouriteUser(
                                    //       searchList[
                                    //       index]
                                    //           .UserID,
                                    //       searchList[
                                    //       index]
                                    //           .FavouriteUser);
                                    // });
                                  },
                                  child: Icon(
                                    productData![index].favorite == true
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: Colors.pink,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //brand name
                          Container(
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              productData![index].brandname,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Details
                          Container(
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              productData![index].detail,
                              style: const TextStyle(
                                  fontSize: 17, color: Colors.black),
                            ),
                          ),

                          // price
                          Container(
                            margin: const EdgeInsets.all(10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Price : ₹ ${productData![index].price}',
                              style: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 17),
                            ),
                          ),

                          // gender & size
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text('Gender : ${productData![index].gender}',
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 15)),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Size : ${productData![index].size}',
                                  style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCarouselPage(
      String img, String ctype, String discount, bool isOddPage) {
    return Stack(
      children: [
        if (isOddPage)
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/$img.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(right: 25),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$ctype Collection',
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontSize: 20),
                  ),
                  const Divider(color: Colors.white, thickness: 3, indent: 250),
                  Text(
                    '$discount% OFF',
                    style: const TextStyle(
                        color: Colors.white54,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 69),
                  ),
                  const Text(
                    'For Selected Shopping Styles',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/$img.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 25),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$ctype Collection',
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontSize: 20),
                  ),
                  const Divider(
                    color: Colors.white,
                    thickness: 3,
                    endIndent: 280,
                  ),
                  Text(
                    '$discount% OFF',
                    style: const TextStyle(
                        color: Colors.white54,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 69),
                  ),
                  const Text(
                    'For Selected Shopping Styles',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.only(right: 20, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      animationDuration: const Duration(milliseconds: 1000),
                      backgroundColor: Colors.grey.shade900,
                      elevation: 20,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: const Size(69, 35),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Shop Now',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
