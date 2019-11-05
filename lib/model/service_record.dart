enum ServiceKind {
  Unknown,
  Printer,
  MusicCast,
  ChromeCast,
  Sasr,
}

class ServiceRecord {
  static final jsonID = 'id';
  static final jsonMac = 'mac';
  static final jsonKind = 'kind';
  static final jsonService = 'service';
  static final jsonAddress = 'address';

  String id = '';
  String service = '';
  ServiceKind kind = ServiceKind.Unknown;
  String mac = '';
  String address = '';

  ServiceRecord({
    this.id,
    this.kind,
    this.service,
    this.mac,
    this.address,
  }) {
    id ??= '';
    mac ??= '';
    kind ??= ServiceKind.Unknown;
    service ??= '';
    address ??= '';
  }

  ServiceRecord.fromMap(Map<String, dynamic> map)
      : this(
          id: map[jsonID],
          mac: map[jsonMac],
          kind: ServiceKind.values.firstWhere((it) => it.index == map[jsonKind], orElse: () => ServiceKind.Unknown),
          service: map[jsonService],
          address: map[jsonAddress],
        );

  Map<String, dynamic> toMap() {
    return {
      jsonID: id,
      jsonMac: mac,
      jsonKind: kind.index,
      jsonService: service,
      jsonAddress: address,
    };
  }
}
