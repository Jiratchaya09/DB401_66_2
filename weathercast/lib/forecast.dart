import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'location.dart';
import 'weather.dart';

Future<Weather> forecast() async {
  const url = 'https://data.tmd.go.th/nwpapi/v1/forecast/location/hourly/at';
  const token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImQzNTRmNmNkMjExZjJiNDYxZGZhNTIyODVmMjFmODZhOTQ2YTRlNzRiOWYxZDc0MThlYTFmODM5MWViZWYxMzBmZmJkYzJlOThmNzJmMDZlIn0.eyJhdWQiOiIyIiwianRpIjoiZDM1NGY2Y2QyMTFmMmI0NjFkZmE1MjI4NWYyMWY4NmE5NDZhNGU3NGI5ZjFkNzQxOGVhMWY4MzkxZWJlZjEzMGZmYmRjMmU5OGY3MmYwNmUiLCJpYXQiOjE3MDc4ODIyNjQsIm5iZiI6MTcwNzg4MjI2NCwiZXhwIjoxNzM5NTA0NjY0LCJzdWIiOiIzMDA2Iiwic2NvcGVzIjpbXX0.qGRixQJ-jBfeA_DsKGfAltV1wptB83TiFoEpuIphhcVNhzfKFRdQeO9scD-QN5-LR9dxE_burGzR_jDOQLlNzoZq5R3Bmpk_tzU-EsmVK-IjHjxWTjN3KzPEKioilEA7qi01CEtPD4euc8A-oQMPPxUCVg1dPEE9cmi7iUV82gC3RtVcbmXYR0Tb21DKgNO3PA4L-cVMA08KUvM6eJsQTHQxGaktSi2hO0xprG3g5Lw84I7PbRQ4BpJWORZ_a1Pjp91Un3QY92_Kq2BWigUFXLac_Y1s2GcYLlPg_BZ-aWX4b9VS5ZcNDF5Jw32GLtmLfMPCHXLOPMQlpc5Mbry4Cd2Tx1UvJRJuKgaJa90d2Ke597RKR4xExxic0S-mgtHXcsnTfidkgVbYX-Tj-BXhVw4aAZ91D4KQBdp6Qz1niUzuMKmTEYs7JJnTJWq-Ltpg647BhLVFRRdnRl1qtv-HTsdwJzUtk_5YXQqZ9ZIKPgk4upivyQbh8IwPTaejKAW2EMT0wtofCXpgulOnezmrPvN0Wgdn5jCgiVIGhi50p1SJb3MiMuiUdwaSELCUG_A8CgYwVnTZFErwbIaTd0RB0eIITvGXy79IIzsS0qUj4mg-uNgjNrFqmicJisJmtpvp6c9gM7277VuW5-eXlv5lq3ZU9iG5EH76MGwe-3Lzzvg';

  try {
    Position location = await getCurrentLocation();
    http.Response response = await http.get(
        Uri.parse(
            '$url?lat=${location.latitude}&lon=${location.longitude}&fields=tc,cond'),
        headers: {
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        });
    return Weather(address: response.body, temperature: 0, cond: 0);
  } catch (e) {
    return Future.error(e);
  }
}
