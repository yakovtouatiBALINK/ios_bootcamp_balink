import UIKit

func applyKTimes(_ k: Int, _ closure: () -> ()) {
    for _ in 1 ... k {
        closure()
    }
}

applyKTimes(5) {
    print("we heart swift")
}
