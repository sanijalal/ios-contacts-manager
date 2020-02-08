enum EntryFieldType: String, Equatable {
    case firstName = "First Name"
    case lastName = "Last Name"
    case email = "Email"
    case phoneNumber = "Phone Number"
}

struct EntryField {
    let type: EntryFieldType
    let isRequired: Bool
    var value: String?
}
