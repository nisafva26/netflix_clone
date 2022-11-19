import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_app/controller/movie_list_controller.dart';
import 'package:netflix_app/view/new_hot/coming_soon.dart';
import 'package:netflix_app/view/new_hot/top_10.dart';
import 'package:provider/provider.dart';


class NewHotScreen extends StatefulWidget {
  const NewHotScreen({Key? key}) : super(key: key);

  @override
  State<NewHotScreen> createState() => _NewHotScreenState();
}

class _NewHotScreenState extends State<NewHotScreen> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
     
      Provider.of<MovieListController>(context, listen: false).getComingSoonMOvies();
      Provider.of<MovieListController>(context, listen: false).getTop10();

      // Add Your Code here.
    });
  }
  
  Widget build(BuildContext context) {
    
   return  Consumer<MovieListController>(
     builder: (context,controller,child) {
       return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: const Text(
                'New & Hot',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              actions: const [
                Icon(
                  Icons.cast,
                  
                  color: Colors.white,
                ),
                SizedBox(width:10),
               
                SizedBox(width: 10),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(30),
                
                child: SizedBox(
                  height: 35,
                  width: MediaQuery.of(context).size.width,
                  child: TabBar(
                    isScrollable: true,
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    unselectedLabelColor: Colors.white,
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    indicator: BoxDecoration(
                      color: Colors.white,
                      
                      borderRadius: BorderRadius.circular(30),
                    ),
                    tabs:  [
                       Tab(
                        child: Text(
                          '🍿 Coming Soon',
                          style: TextStyle(
                             fontFamily: GoogleFonts.montserrat().fontFamily,
                          ),
                        ),
                      ),
                      Tab(
                        child: Row(
                          children:  [
                            Container(height: 25,
                            width: 25,
                            color: Color.fromARGB(255, 233, 21, 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                              Text('Top',style: TextStyle(fontSize: 10,color: Colors.white),
                              
                              ),
                              Text('10',style: TextStyle(fontSize: 10,color: Colors.white),
                              
                              )
                            ]),
                            ),
                            SizedBox(width: 4.0,),
                            

                             Text(
                              "Top 10 Movies",
                              style: TextStyle(
                             fontFamily: GoogleFonts.montserrat().fontFamily,
                          ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: const TabBarView(
              children: [
               ComingSoon(),
               Top10()
              ],
            ),
          ),
        );
     }
   );
  }
}