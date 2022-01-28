extension String {
    var encoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""
    }
}
