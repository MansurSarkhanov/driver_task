import 'package:equatable/equatable.dart';

class TaskDetailResponse extends Equatable {
  final TaskDetailModel data;

  const TaskDetailResponse({required this.data});

  factory TaskDetailResponse.fromJson(Map<String, dynamic> json) {
    return TaskDetailResponse(data: TaskDetailModel.fromJson(json['data']));
  }

  @override
  List<Object?> get props => [data];
}

class TaskDetailModel extends Equatable {
  final String taskId;
  final String title;
  final String address;
  final TaskStatus status;
  final String etaMin;
  final double distanceKm;
  final String phoneNumber;
  final int bagsCount;
  final TaskLocation location;
  final TaskActions actions;
  final List<TaskPackage> packages;

  const TaskDetailModel({
    required this.taskId,
    required this.title,
    required this.address,
    required this.status,
    required this.etaMin,
    required this.distanceKm,
    required this.phoneNumber,
    required this.bagsCount,
    required this.location,
    required this.actions,
    required this.packages,
  });

  factory TaskDetailModel.fromJson(Map<String, dynamic> json) {
    return TaskDetailModel(
      taskId: json['task_id'],
      title: json['title'],
      address: json['address'],
      status: TaskStatusX.fromString(json['status']),
      etaMin: json['eta_min'],
      distanceKm: (json['distance_km'] as num).toDouble(),
      phoneNumber: json['phone_number'],
      bagsCount: json['bags_count'],
      location: TaskLocation.fromJson(json['location']),
      actions: TaskActions.fromJson(json['actions']),
      packages: (json['packages'] as List)
          .map((e) => TaskPackage.fromJson(e))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    taskId,
    title,
    address,
    status,
    etaMin,
    distanceKm,
    phoneNumber,
    bagsCount,
    location,
    actions,
    packages,
  ];
}

class TaskLocation extends Equatable {
  final double lat;
  final double lng;

  const TaskLocation({required this.lat, required this.lng});

  factory TaskLocation.fromJson(Map<String, dynamic> json) {
    return TaskLocation(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [lat, lng];
}

class TaskActions extends Equatable {
  final bool canScan;
  final bool canFail;
  final bool canStart;

  const TaskActions({
    required this.canScan,
    required this.canFail,
    required this.canStart,
  });

  factory TaskActions.fromJson(Map<String, dynamic> json) {
    return TaskActions(
      canScan: json['can_scan'],
      canFail: json['can_fail'],
      canStart: json['can_start'],
    );
  }

  @override
  List<Object?> get props => [canScan, canFail, canStart];
}

class TaskPackage extends Equatable {
  final String packageId;
  final String shipmentId;
  final String barcode;
  final PackageStatus status;

  const TaskPackage({
    required this.packageId,
    required this.shipmentId,
    required this.barcode,
    required this.status,
  });

  factory TaskPackage.fromJson(Map<String, dynamic> json) {
    return TaskPackage(
      packageId: json['package_id'],
      shipmentId: json['shipment_id'],
      barcode: json['barcode'],
      status: PackageStatusX.fromString(json['status']),
    );
  }

  @override
  List<Object?> get props => [packageId, shipmentId, barcode, status];
}

enum TaskStatus { pending, inProgress, completed, failed }

extension TaskStatusX on TaskStatus {
  static TaskStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return TaskStatus.pending;
      case 'in_progress':
        return TaskStatus.inProgress;
      case 'completed':
        return TaskStatus.completed;
      default:
        return TaskStatus.failed;
    }
  }
}

enum PackageStatus { pending, scanned, completed }

extension PackageStatusX on PackageStatus {
  static PackageStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return PackageStatus.pending;
      case 'scanned':
        return PackageStatus.scanned;
      default:
        return PackageStatus.completed;
    }
  }
}
