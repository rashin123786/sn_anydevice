import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sn_advice/core/services/api_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
        title: const Text(
          "All product",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: ApiServices().getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];

                      int autherReputation = data.authorReputation.toInt();
                      DateTime currentDateTime = DateTime.now();
                      DateTime givenDateTime = DateTime.parse(data.created);
                      int hoursDifference =
                          currentDateTime.difference(givenDateTime).inHours - 5;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, right: 4),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 15,
                                        backgroundImage: data
                                                .jsonMetadata.image.isNotEmpty
                                            ? index == 4
                                                ? const NetworkImage(
                                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png')
                                                : NetworkImage(
                                                    data.jsonMetadata.image[0],
                                                  )
                                            : const NetworkImage(
                                                'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png')),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text:
                                              '${'${data.author} ($autherReputation)'} ',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                          children: [
                                            TextSpan(
                                              text: data.category == 'hive'
                                                  ? hoursDifference < 24
                                                      ? 'in # ${data.category} . $hoursDifference'
                                                      : 'in # ${data.category} . Yesterday'
                                                  : hoursDifference < 24
                                                      ? 'in ${data.category} . $hoursDifference hours ago'
                                                      : 'in # ${data.category} . Yesterday',
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    120, 129, 135, 1),
                                              ),
                                            )
                                          ]),
                                    )
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 85,
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                      child: data.jsonMetadata.image.isNotEmpty
                                          ? index == 4
                                              ? const Icon(
                                                  Icons.error,
                                                  color: Colors.red,
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: data
                                                      .jsonMetadata.image[0],
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.center,
                                                )
                                          : const Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: ListTile(
                                      contentPadding:
                                          const EdgeInsets.only(left: 4, right: 4),
                                      title: Text(
                                        data.permlink,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Text(
                                            index == 1 || index == 2
                                                ? 'No Body'
                                                : data.body,
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Divider(
                                            thickness: 0.2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              const Icon(
                                                Icons.arrow_circle_up_outlined,
                                                color: Colors.red,
                                                size: 18,
                                              ),
                                              const Icon(
                                                Icons.arrow_circle_down_rounded,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              Text("\$${data.payout}"),
                                              const Icon(
                                                Icons.arrow_drop_down,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const Icon(
                                                Icons.keyboard_arrow_up,
                                                size: 18,
                                              ),
                                              Text("${data.stats.totalVotes}"),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const Icon(
                                                Icons.comment,
                                                size: 18,
                                              ),
                                              Text("${data.children}"),
                                              const SizedBox(
                                                width: 4,
                                              ),
                                              const Icon(
                                                Icons.directions,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Text("${snapshot.error}");
              }
            },
          )
        ],
      ),
    );
  }
}
