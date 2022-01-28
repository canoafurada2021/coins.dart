import 'package:hive/hive.dart';
import '../models/models_coins.dart';

class MoedaHiveAdapter extends TypeAdapter<Moeda> {
  @override
  final typeId = 0;

@override
  Moeda read(BinaryReader reader) {
  return Moeda(
    iconss: reader.readString(),
    sigla: reader.readString(),
    nome: reader.readString(),
    preco:reader.readDouble(),
  );
}
@override
  void write(BinaryWriter writer, Moeda obj){
  writer.writeString(obj.iconss);
  writer.writeString(obj.nome);
  writer.writeString(obj.sigla);
  writer.writeDouble(obj.preco);
}
}