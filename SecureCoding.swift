
import Foundation

class User: NSObject, NSSecureCoding {
    static var supportsSecureCoding: Bool {
        return true
    }
    var name: String
    var age: Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(age, forKey: "age")
    }

    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as! String
        age = coder.decodeInteger(forKey: "age")
    }
}


let userEncoded = User(name: "Nikil", age: 30)
let fileURLEncoded = URL(fileURLWithPath: "user.data")
do {
    let dataEncoded = try NSKeyedArchiver.archivedData(withRootObject: userEncoded, requiringSecureCoding: true)
    try dataEncoded.write(to: fileURLEncoded)
    // You can now use the encoded data (dataEncoded) as needed
} catch {
    // An error was thrown while trying to encode the object. You can handle the error here
    print(error)
}

let fileURLDecoded = URL(fileURLWithPath: "user.data")
do {
    let dataDecoded = try Data(contentsOf: fileURLDecoded)
    let userDecoded = try NSKeyedUnarchiver.unarchivedObject(ofClass: User.self, from: dataDecoded)
    print(userDecoded?.name) // prints "Nikil"
    print(userDecoded?.age) // prints 30
} catch {
    print(error)
}
