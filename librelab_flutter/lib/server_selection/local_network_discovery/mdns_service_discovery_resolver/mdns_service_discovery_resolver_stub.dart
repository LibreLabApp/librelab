import 'package:mdns_discovery/mdns_discovery.dart';
import 'package:mdns_discovery/unsupported.dart';

Future<MdnsServiceDiscovery> resolveMdnsServiceDiscoveryImpl() async =>
    const MdnsServiceDiscoveryUnsupported();
