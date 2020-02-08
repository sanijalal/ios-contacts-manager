enum EntryGroupType: String, Equatable {
    case mainInfo = "Main Information"
    case subInfo = "Sub Information"
}

struct EntryGroup {
    let type: EntryGroupType
    var fields: [EntryField]
}
