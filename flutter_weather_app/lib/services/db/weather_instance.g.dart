// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_instance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherInstanceAdapter extends TypeAdapter<WeatherInstance> {
  @override
  final int typeId = 1;

  @override
  WeatherInstance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherInstance(
      city: fields[0] as String,
      temp: fields[1] as double,
      weatherName: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherInstance obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.temp)
      ..writeByte(2)
      ..write(obj.weatherName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherInstanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
