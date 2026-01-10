import 'package:equatable/equatable.dart';

class TaskResponse extends Equatable {
  final TaskData data;

  const TaskResponse({required this.data});

  factory TaskResponse.fromJson(Map<String, dynamic> json) {
    return TaskResponse(data: TaskData.fromJson(json['data']));
  }

  @override
  List<Object?> get props => [data];
}

class TaskData extends Equatable {
  final List<TaskModel> tasks;

  const TaskData({required this.tasks});

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      tasks: (json['tasks'] as List).map((e) => TaskModel.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [tasks];
}

class TaskModel extends Equatable {
  final String taskId;
  final String title;
  final String address;
  final int priority;
  final String status;
  final int etaMin;
  final double distanceKm;
  final int packagesCount;
  final TaskLocation location;

  const TaskModel({
    required this.taskId,
    required this.title,
    required this.address,
    required this.priority,
    required this.status,
    required this.etaMin,
    required this.distanceKm,
    required this.packagesCount,
    required this.location,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['task_id'],
      title: json['title'],
      address: json['address'],
      priority: json['priority'],
      status: json['status'],
      etaMin: json['eta_min'],
      distanceKm: (json['distance_km'] as num).toDouble(),
      packagesCount: json['packages_count'],
      location: TaskLocation.fromJson(json['location']),
    );
  }

  @override
  List<Object?> get props => [
    taskId,
    title,
    address,
    priority,
    status,
    etaMin,
    distanceKm,
    packagesCount,
    location,
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
