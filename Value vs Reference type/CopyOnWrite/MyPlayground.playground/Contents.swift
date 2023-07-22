import Foundation

func print(address o: UnsafeRawPointer ) {
    print(String(format: "%p", Int(bitPattern: o)))
}
print("address in standart collections")
var array1: [Int] = [0, 1, 2, 3]
var array2 = array1

//Print with just assign
print(address: array1)
print(address: array2)
//Let's mutate array2 to see what's
array2.append(4)

print(address: array2)


//print("address in function")
//func someFunc(array: [Int]) -> [Int] {
//    print(address: array)
//    var newArray = array
//    print(address: newArray)
//    newArray.append(3)
//    print(address: newArray)
//    return newArray
//}
//
//var array3: [Int] = [1,2]
//print(address: array3)
//array3 = someFunc(array: array3)
//print(address: array3)
//
//
////print("address in custom struct")
//struct Food {
//    var price: Int
//}

//var cucumber = Food(price: 5)
//var bread = cucumber
//print(address: &cucumber)
//print(address: &bread)
//bread.price = 2
//print(address: &bread)


//print("address in custom struct in function")
//func increasePrice(for food: Food) -> Food {
//    var newFood = food
//    print(address: &newFood)
//    newFood.price = 6
//    print(address: &newFood)
//    return newFood
//}
//
//var tomato = Food(price: 2)
//print(address: &tomato)
//tomato = increasePrice(for: tomato)
//print(tomato.price)
//print(address: &tomato)


final class Ref<T> {
  var val: T
    
  init(v: T) {
    val = v
  }
}

struct Box<T> {
  var ref: Ref<T>
    
  init(x: T) {
      ref = Ref(v: x)
  }

  var value: T {
    get {
      ref.val
    }
    set {
      if (!isKnownUniquelyReferenced(&ref)) {
          ref = Ref(v: newValue)
      } else {
          ref.val = newValue
      }
    }
  }
}


// у нас есть адрес в памяти у структуры
//

print("address in custom COW implementation")
struct Test {
  var x: Int
}

let val = Test(x: 5)
// Ну и используем наш Box
var box = Box(x: val)
var box2 = box

print(address: &box.value)
print(address: &box2.value)

box2.value = Test(x: 10)
print(address: &box2.value)
print(box.value.x)
print(box2.value.x)

//Returns a Boolean value indicating whether the given object is known to have a single strong reference.
