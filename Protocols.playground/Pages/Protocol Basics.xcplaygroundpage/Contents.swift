import Foundation

//: # Protocols
//: Protocols are, as per Apple's definition in the _Swift Programming Language_ book:
//:
//: "... a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol."
//:
//: The below example shows a protocol that requires conforming types have a particular property defined.
protocol FullyNamed {
    // Anything in these curly braces become the requirements to fulfill the FullyNamed protocol's functionality
    // { get }, hidden within all variables, and it will be attached to a value
    // { set }, "Setting" the value
    // { get } is a minimum requirment
    var fullName: String { get }
}

//: "Adopting" the protocol means you are saying you'll fulfill the requirements set by the protocol
struct Person: FullyNamed {
    var fullName: String
}

struct Starship: FullyNamed {
    
    var name: String
    var prefix: String?
    
    // Computed Property
    var fullName: String {
            if let prefix = prefix {
                return prefix + " " + name
            } else {
                return name
            }
    }
}
let ben = Person(fullName: "Ben Gohlke")

let ncc1701 = Starship(name: "Enterprise", prefix: "USS")
let firefly = Starship(name: "Serenity", prefix: nil)

//print(ben.fullName)
//print(ncc1701.fullName)

var fullyNamedThings: [FullyNamed] = [ben, ncc1701]

for thing in fullyNamedThings {
    print(thing.fullName)
}

//: Protocols can also require that conforming types implement certain methods.
protocol GeneratesRandomNumbers {
    // This should return a random number
    func random() -> Int
}

class OneThroughTen: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...10)
    }
}

class OneThroughOneHundred: GeneratesRandomNumbers {
    
    func random() -> Int {
        return Int.random(in: 1...100)
    }
}

//: Using built-in Protocols
//: Compare the two ships and see if they are the same.
extension Starship: Equatable {
    static func ==(lhs: Starship, rhs: Starship) -> Bool {
        return lhs.fullName == rhs.fullName
    }
}

if ncc1701 == firefly {
    print("They are the same ship!")
}

//: ## Protocols as Types
class Dice {
    let sides: Int
    // Anything conforming to this protocol can be the numberGenerator
    let numberGenerator: GeneratesRandomNumbers
    
    init(sides: Int, numberGenerator: GeneratesRandomNumbers) {
        self.sides = sides
        self.numberGenerator = numberGenerator
    }
    
    func roll() -> Int {
        return (numberGenerator.random() % sides) + 1
    }
   
}

var d6 = Dice(sides: 6, numberGenerator: OneThroughTen())

for _ in 1...10 {
    print(d6.roll())
}

