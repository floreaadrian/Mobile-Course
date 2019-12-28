import 'package:flutter_test/flutter_test.dart';
import 'package:lab1_flutter/passanger.dart';
import 'package:lab1_flutter/repos/in_memory_repository.dart';

void main() {
  addTest();
  deleteTest();
}

void addTest() async {
  InMemoryRepository inMemoryRepository = new InMemoryRepository();
  Passanger passanger = new Passanger(
    email: "ok.com",
    name: "name",
    seatPosition: "ok",
    airplaneName: "ce",
    serverId: "43dfsddsfsdf",
  );
  group('Add', () {
    test('should be initiated with one element', () async {
      final justInitial = await inMemoryRepository.getAll();
      expect(justInitial.length, 1);
    });
    test('should add one element', () async {
      await inMemoryRepository.add(passanger);
      final afterAdd = await inMemoryRepository.getAll();
      expect(afterAdd.length, 2);
    });
  });
}

void deleteTest() async {
  InMemoryRepository inMemoryRepository = new InMemoryRepository();
  Passanger passanger = new Passanger(
    email: "ok.com",
    name: "name",
    seatPosition: "ok",
    airplaneName: "ce",
    serverId: "43dfsddsfsdf",
  );
  Passanger newOne;
  group('Delete', () {
    test('should be initiated with one element', () async {
      final justInitial = await inMemoryRepository.getAll();
      expect(justInitial.length, 1);
    });
    test('should fail to delete the element', () async {
      newOne = await inMemoryRepository.add(passanger);
      await inMemoryRepository.deletePassanger(passanger);
      final afterFaildDelete = await inMemoryRepository.getAll();
      expect(afterFaildDelete.length, 2);
    });
    test("should delete a passanger to the repository", () async {
      await inMemoryRepository.deletePassanger(newOne);
      final afterDelete = await inMemoryRepository.getAll();
      expect(afterDelete.length, 1);
    });
  });
}
