

import Foundation
import SwiftUI

struct Todo: Hashable, Codable {
    var id: String
    var title: String
    var description: String
    var image: URL?
    var isImportant: Bool
}
