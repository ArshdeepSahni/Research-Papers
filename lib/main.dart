import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class apidata {
  String status;
  int totalHits;
  List<Data> data;
  apidata({this.status, this.totalHits, this.data});

  apidata.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalHits = json['totalHits'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalHits'] = this.totalHits;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String sIndex;
  String sType;
  String sId;
  double dScore;
  Source sSource;

  Data({this.sIndex, this.sType, this.sId, this.dScore, this.sSource});

  Data.fromJson(Map<String, dynamic> json) {
    sIndex = json['_index'];
    sType = json['_type'];
    sId = json['_id'];
    dScore = json['_score'];
    sSource =
        json['_source'] != null ? new Source.fromJson(json['_source']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_index'] = this.sIndex;
    data['_type'] = this.sType;
    data['_id'] = this.sId;
    data['_score'] = this.dScore;
    if (this.sSource != null) {
      data['_source'] = this.sSource.toJson();
    }
    return data;
  }
}

class Source {
  String id;
  List<String> authors;
  List<dynamic> citations;
  List<String> contributors;
  String datePublished;
  String deleted;
  String description;
  String fullText;
  String fullTextIdentifier;
  List<String> identifiers;
  // Null journals;
  Language language;
  // Null duplicateId;
  String publisher;
  String rawRecordXml;
  List<String> relations;
  List<Repositories> repositories;
  RepositoryDocument repositoryDocument;
  // Null similarities;
  List<String> subjects;
  String title;
  List<String> topics;
  List<dynamic> types;
  List<String> urls;
  int year;
  String doi;
  String oai;
  String downloadUrl;
  String pdfHashValue;
  // Null documentType;
  // Null documentTypeConfidence;
  // Null citationCount;
  // Null estimatedCitationCount;
  // Null acceptedDate;
  int depositedDate;
  int publishedDate;
  // Null issn;
  int attachmentCount;
  // Null repositoryPublicReleaseDate;
  // Null extendedMetadataAttributes;
  // Null crossrefDocument;
  // Null magDocument;
  // Null orcidAuthors;

  Source({
    this.id,
    this.authors,
    this.citations,
    this.contributors,
    this.datePublished,
    this.deleted,
    this.description,
    this.fullText,
    this.fullTextIdentifier,
    this.identifiers,
    // this.journals,
    this.language,
    // this.duplicateId,
    this.publisher,
    this.rawRecordXml,
    this.relations,
    this.repositories,
    this.repositoryDocument,
    // this.similarities,
    this.subjects,
    this.title,
    this.topics,
    this.types,
    this.urls,
    this.year,
    this.doi,
    this.oai,
    this.downloadUrl,
    this.pdfHashValue,
    // this.documentType,
    // this.documentTypeConfidence,
    // this.citationCount,
    // this.estimatedCitationCount,
    // this.acceptedDate,
    this.depositedDate,
    this.publishedDate,
    // this.issn,
    this.attachmentCount,
    // this.repositoryPublicReleaseDate,
    // this.extendedMetadataAttributes,
    // this.crossrefDocument,
    // this.magDocument,
    // this.orcidAuthors
  });

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    authors = json['authors'].cast<String>();
    // if (json['citations'] != null) {
    //   citations = new List<Null>();
    //   json['citations'].forEach((v) {
    //     citations.add(new Null.fromJson(v));
    //   });
    contributors = json['contributors'].cast<String>();
    datePublished = json['datePublished'];
    deleted = json['deleted'];
    description = json['description'];
    fullText = json['fullText'];
    fullTextIdentifier = json['fullTextIdentifier'];
    identifiers = json['identifiers'].cast<String>();
    // journals = json['journals'];
    language = json['language'] != null
        ? new Language.fromJson(json['language'])
        : null;
    // duplicateId = json['duplicateId'];
    publisher = json['publisher'];
    rawRecordXml = json['rawRecordXml'];
    relations = json['relations'].cast<String>();
    if (json['repositories'] != null) {
      repositories = new List<Repositories>();
      json['repositories'].forEach((v) {
        repositories.add(new Repositories.fromJson(v));
      });
    }
    repositoryDocument = json['repositoryDocument'] != null
        ? new RepositoryDocument.fromJson(json['repositoryDocument'])
        : null;
    // similarities = json['similarities'];
    subjects = json['subjects'].cast<String>();
    title = json['title'];
    topics = json['topics'].cast<String>();
    // if (json['types'] != null) {
    //   types = new List<Null>();
    //   json['types'].forEach((v) {
    //     types.add(new Null.fromJson(v));
    //   });
    // }
    urls = json['urls'].cast<String>();
    year = json['year'];
    doi = json['doi'];
    oai = json['oai'];
    downloadUrl = json['downloadUrl'];
    pdfHashValue = json['pdfHashValue'];
    // documentType = json['documentType'];
    // documentTypeConfidence = json['documentTypeConfidence'];
    // citationCount = json['citationCount'];
    // estimatedCitationCount = json['estimatedCitationCount'];
    // acceptedDate = json['acceptedDate'];
    depositedDate = json['depositedDate'];
    publishedDate = json['publishedDate'];
    // issn = json['issn'];
    attachmentCount = json['attachmentCount'];
    // repositoryPublicReleaseDate = json['repositoryPublicReleaseDate'];
    // extendedMetadataAttributes = json['extendedMetadataAttributes'];
    // crossrefDocument = json['crossrefDocument'];
    // magDocument = json['magDocument'];
    // orcidAuthors = json['orcidAuthors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['authors'] = this.authors;
    // if (this.citations != null) {
    //   data['citations'] = this.citations.map((v) => v.toJson()).toList();
    // }
    data['contributors'] = this.contributors;
    data['datePublished'] = this.datePublished;
    data['deleted'] = this.deleted;
    data['description'] = this.description;
    data['fullText'] = this.fullText;
    data['fullTextIdentifier'] = this.fullTextIdentifier;
    data['identifiers'] = this.identifiers;
    // data['journals'] = this.journals;
    if (this.language != null) {
      data['language'] = this.language.toJson();
    }
    // data['duplicateId'] = this.duplicateId;
    data['publisher'] = this.publisher;
    data['rawRecordXml'] = this.rawRecordXml;
    data['relations'] = this.relations;
    if (this.repositories != null) {
      data['repositories'] = this.repositories.map((v) => v.toJson()).toList();
    }
    if (this.repositoryDocument != null) {
      data['repositoryDocument'] = this.repositoryDocument.toJson();
    }
    // data['similarities'] = this.similarities;
    data['subjects'] = this.subjects;
    data['title'] = this.title;
    data['topics'] = this.topics;
    // if (this.types != null) {
    //   data['types'] = this.types.map((v) => v.toJson()).toList();
    // }
    data['urls'] = this.urls;
    data['year'] = this.year;
    data['doi'] = this.doi;
    data['oai'] = this.oai;
    data['downloadUrl'] = this.downloadUrl;
    data['pdfHashValue'] = this.pdfHashValue;
    // data['documentType'] = this.documentType;
    // data['documentTypeConfidence'] = this.documentTypeConfidence;
    // data['citationCount'] = this.citationCount;
    // data['estimatedCitationCount'] = this.estimatedCitationCount;
    // data['acceptedDate'] = this.acceptedDate;
    data['depositedDate'] = this.depositedDate;
    data['publishedDate'] = this.publishedDate;
    // data['issn'] = this.issn;
    data['attachmentCount'] = this.attachmentCount;
    // data['repositoryPublicReleaseDate'] = this.repositoryPublicReleaseDate;
    // data['extendedMetadataAttributes'] = this.extendedMetadataAttributes;
    // data['crossrefDocument'] = this.crossrefDocument;
    // data['magDocument'] = this.magDocument;
    // data['orcidAuthors'] = this.orcidAuthors;
    return data;
  }
}

class Language {
  String code;
  int id;
  String name;

  Language({this.code, this.id, this.name});

  Language.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Repositories {
  String id;
  int openDoarId;
  String name;
  // Null urlHomepage;
  // Null urlOaipmh;
  // Null uriJournals;
  String physicalName;
  // Null source;
  // Null software;
  // Null metadataFormat;
  // Null description;
  // Null journal;
  int roarId;
  int baseId;
  // Null pdfStatus;
  int nrUpdates;
  bool disabled;
  // Null lastUpdateTime;
  // Null repositoryLocation;

  Repositories({
    this.id,
    this.openDoarId,
    this.name,
    // this.urlHomepage,
    // this.urlOaipmh,
    // this.uriJournals,
    this.physicalName,
    // this.source,
    // this.software,
    // this.metadataFormat,
    // this.description,
    // this.journal,
    this.roarId,
    this.baseId,
    // this.pdfStatus,
    this.nrUpdates,
    this.disabled,
    // this.lastUpdateTime,
    // this.repositoryLocation
  });

  Repositories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    openDoarId = json['openDoarId'];
    name = json['name'];
    // urlHomepage = json['urlHomepage'];
    // urlOaipmh = json['urlOaipmh'];
    // uriJournals = json['uriJournals'];
    physicalName = json['physicalName'];
    // source = json['source'];
    // software = json['software'];
    // metadataFormat = json['metadataFormat'];
    // description = json['description'];
    // journal = json['journal'];
    roarId = json['roarId'];
    baseId = json['baseId'];
    // pdfStatus = json['pdfStatus'];
    nrUpdates = json['nrUpdates'];
    disabled = json['disabled'];
    // lastUpdateTime = json['lastUpdateTime'];
    // repositoryLocation = json['repositoryLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['openDoarId'] = this.openDoarId;
    data['name'] = this.name;
    // data['urlHomepage'] = this.urlHomepage;
    // data['urlOaipmh'] = this.urlOaipmh;
    // data['uriJournals'] = this.uriJournals;
    data['physicalName'] = this.physicalName;
    // data['source'] = this.source;
    // data['software'] = this.software;
    // data['metadataFormat'] = this.metadataFormat;
    // data['description'] = this.description;
    // data['journal'] = this.journal;
    data['roarId'] = this.roarId;
    data['baseId'] = this.baseId;
    // data['pdfStatus'] = this.pdfStatus;
    data['nrUpdates'] = this.nrUpdates;
    data['disabled'] = this.disabled;
    // data['lastUpdateTime'] = this.lastUpdateTime;
    // data['repositoryLocation'] = this.repositoryLocation;
    return data;
  }
}

class RepositoryDocument {
  int pdfStatus;
  int textStatus;
  int metadataAdded;
  int metadataUpdated;
  int timestamp;
  int depositedDate;
  int indexed;
  String deletedStatus;
  int pdfSize;
  bool tdmOnly;
  String pdfOrigin;

  RepositoryDocument(
      {this.pdfStatus,
      this.textStatus,
      this.metadataAdded,
      this.metadataUpdated,
      this.timestamp,
      this.depositedDate,
      this.indexed,
      this.deletedStatus,
      this.pdfSize,
      this.tdmOnly,
      this.pdfOrigin});

  RepositoryDocument.fromJson(Map<String, dynamic> json) {
    pdfStatus = json['pdfStatus'];
    textStatus = json['textStatus'];
    metadataAdded = json['metadataAdded'];
    metadataUpdated = json['metadataUpdated'];
    timestamp = json['timestamp'];
    depositedDate = json['depositedDate'];
    indexed = json['indexed'];
    deletedStatus = json['deletedStatus'];
    pdfSize = json['pdfSize'];
    tdmOnly = json['tdmOnly'];
    pdfOrigin = json['pdfOrigin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pdfStatus'] = this.pdfStatus;
    data['textStatus'] = this.textStatus;
    data['metadataAdded'] = this.metadataAdded;
    data['metadataUpdated'] = this.metadataUpdated;
    data['timestamp'] = this.timestamp;
    data['depositedDate'] = this.depositedDate;
    data['indexed'] = this.indexed;
    data['deletedStatus'] = this.deletedStatus;
    data['pdfSize'] = this.pdfSize;
    data['tdmOnly'] = this.tdmOnly;
    data['pdfOrigin'] = this.pdfOrigin;
    return data;
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var search = TextEditingController();
  String word = "";
  var data;
  apidata apidataobj;

  Future getHttp(String querry) async {
    print(querry);
    try {
      Response response = await Dio().get(
          "https://core.ac.uk:443/api-v2/search/${querry}?page=1&pageSize=10&apiKey=cjMRGW3khb04x2iuZD9HIvCLVANfodKl");
      var passeddata = json.decode(response.toString());
      log(response.toString());
      apidataobj = new apidata.fromJson(response.data);
      // print(apidataobj.data.length);
      // print(response.toString());
      word = "";
      search.text = "";
      return (response.data);
    } catch (e) {
      print(e);
    }
  }

  List<Widget> cards(data) {
    print(data.length);
    List<Widget> card = [];
    Color titlecolor = Colors.black;
    for (var i = 0; i < data.length; i++) {
      card.add(Container(
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[200],
          ),
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Center(
            child: ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(width: 3, color: Colors.green),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Text(
                        (i + 1).toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      apidataobj.data[i].sSource.title.toString(),
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 35 > 30
                              ? 20
                              : MediaQuery.of(context).size.width / 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreen[500]),
                    ),
                  ),
                ],
              ),
              subtitle: Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black12, width: 2)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Date:",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width /
                                              50 >
                                          25
                                      ? 25
                                      : MediaQuery.of(context).size.width / 40,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black38),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              apidataobj.data[i].sSource.datePublished
                                          .toString()
                                          .length >
                                      9
                                  ? apidataobj.data[i].sSource.datePublished
                                      .toString()
                                      .substring(0, 9)
                                  : apidataobj.data[i].sSource.datePublished
                                      .toString(),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width /
                                              50 >
                                          25
                                      ? 25
                                      : MediaQuery.of(context).size.width / 45,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black38),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: [
                            Text(
                              "Type:",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width /
                                              50 >
                                          25
                                      ? 25
                                      : MediaQuery.of(context).size.width / 40,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black38),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              apidataobj.data[i].sIndex
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width /
                                              50 >
                                          25
                                      ? 25
                                      : MediaQuery.of(context).size.width / 45,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black38),
                            ),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2, color: Colors.black12),
                        color: Colors.grey[200],
                      ),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Center(
                        child: ExpansionTile(
                            title: Text(
                              "AUTHOR(s):",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width /
                                              50 >
                                          25
                                      ? 25
                                      : MediaQuery.of(context).size.width / 40,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black38),
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Text(
                                apidataobj.data[i].sSource.authors
                                    .toString()
                                    .substring(
                                        1,
                                        apidataobj.data[i].sSource.authors
                                                .toString()
                                                .length -
                                            1),
                                style: TextStyle(
                                    wordSpacing: 10,
                                    fontSize:
                                        MediaQuery.of(context).size.width / 50 >
                                                25
                                            ? 25
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                45,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black38),
                                textAlign: TextAlign.center,
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              children: [
                Text(
                  apidataobj.data[i].sSource.fullText.toString() == "null"
                      ? "Full Text not available..."
                      : apidataobj.data[i].sSource.fullText.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ],
            ),
          )));
    }

    return card;
  }

  int a = 0;
  double butwidth = 100;
  ScrollController scrollbarcontroller;
  Icon butIcon = Icon(
    Icons.search,
    size: 20,
    color: Colors.white,
  );
  Color whitesearchcolor = Colors.white54;
  Color blacksearchcolor = Colors.black12;
  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);
    Future _onRefresh() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    Future _onLoading() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use loadFailed(),if no data return,use LoadNodata()
      setState(() {
        a = a + 1;
      });
      if (word != "") {
        setState(() {});
        print(
            "https://core.ac.uk:443/api-v2/search/${word}?page=1&pageSize=10&apiKey=cjMRGW3khb04x2iuZD9HIvCLVANfodKl");
      } else {}
      _refreshController.loadComplete();
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: Colors.black54,
                  image: DecorationImage(image: AssetImage('img/icon.png')))),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
              width: 50,
              height: 50,
              child: RaisedButton(
                color: Colors.black54,
                splashColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2000)),
                onPressed: () {
                  setState(() {
                    a = a + 1;
                  });
                  if (word != "") {
                    setState(() {});
                    print(
                        "https://core.ac.uk:443/api-v2/search/${word}?page=1&pageSize=10&apiKey=cjMRGW3khb04x2iuZD9HIvCLVANfodKl");
                  } else {}
                },
                child: Center(child: butIcon),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20.0),
            child: search.text == null
                ? Text("")
                : Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    // color: Colors.lightGreen,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 30,
                    width: search.text.length.toDouble() * 10,
                    child: Center(
                        child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Center(
                          child: Text(
                            search.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w100),
                          ),
                        ),
                      ],
                    )),
                  ),
          ),
          backgroundColor: Colors.green,
          title: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(20),
                // border: Border.all(width: 2, color: Colors.white70)),
              ),
              child: TextField(
                onChanged: (val) {
                  // val == ""
                  //     ? setState(() {
                  //         butIcon = Icon(
                  //           Icons.search,
                  //           size: 100 / 3,
                  //           color: Colors.white,
                  //         );
                  //       })
                  //     : setState(() {
                  //         butIcon = Icon(
                  //           Icons.check,
                  //           size: 100 / 3,
                  //           color: Colors.white,
                  //         );
                  //       });
                  word = val;
                },
                style: TextStyle(color: Colors.white70),
                cursorColor: Colors.white70,
                controller: search,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white30),
                    hintText: "Search for the topic here...",
                    border: InputBorder.none),
                // autocorrect: true,
                // autofocus: true,
                // enableSuggestions: true,
                // expands: true,
                // enableInteractiveSelection: true,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            a <= 0
                ? Expanded(
                    child: Center(
                      child: Text(
                        "Search Any Key Word\nResults Of Your Search Will Be Displayed Here",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : Expanded(
                    child: FutureBuilder(
                      future: getHttp(word),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                              constraints: BoxConstraints.expand(),
                              // height: MediaQuery.of(context).size.height - 58,
                              // width: MediaQuery.of(context).size.width,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: Scrollbar(
                            controller: scrollbarcontroller,
                            thickness: 10,
                            radius: Radius.circular(200),
                            child: SmartRefresher(
                              // reverse: true,
                              controller: _refreshController,
                              onRefresh: _onRefresh,
                              onLoading: _onLoading,
                              child: ListView(
                                children: cards(apidataobj.data),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ));
  }
}
