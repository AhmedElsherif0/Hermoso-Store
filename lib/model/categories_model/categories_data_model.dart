
import 'datum.dart';

class CategoriesDataModel {

  int? _currentPage;
  List<Datum>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  dynamic _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;

  CategoriesDataModel.fromJson(Map<String, dynamic> json){
    _currentPage = json["current_page"];
    _data= List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)));
    _firstPageUrl= json["first_page_url"];
    _from= json["from"];
    _lastPage= json["last_page"];
    _lastPageUrl= json["last_page_url"];
    _nextPageUrl= json["next_page_url"];
    _path= json["path"];
    _perPage= json["per_page"];
    _prevPageUrl= json["prev_page_url"];
    _to= json["to"];
    _total= json["total"];
  }

  Map<String, dynamic> toJson() => {
    "current_page" : _currentPage,
    "data": List<dynamic>.from(_data!.map((x) => x.toJson())),
    "first_page_url": _firstPageUrl,
    "from": _from,
    "last_page": _lastPage,
    "last_page_url": _lastPageUrl,
    "next_page_url": _nextPageUrl,
    "path": _path,
    "per_page": _perPage,
    "prev_page_url": _prevPageUrl,
    "to": _to,
    "total": _total,
  };
}


