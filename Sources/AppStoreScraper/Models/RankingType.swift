public enum RankingType: String {
    case topFree, topFreeIpad, topFreeMac
    case topPaid, topPaidIpad, topPaidMac
    case topGrossing, topGrossingIpad
    case new, newFree, newPaid

    public var name: String {
        switch self {
        case .topFree: return "Top Free Apps"
        case .topFreeIpad: return "Top Free iPad Apps"
        case .topFreeMac: return "Top Free Mac Apps"
        case .topPaid: return "Top Paid Apps"
        case .topPaidIpad: return "Top Paid iPad Apps"
        case .topPaidMac: return "Top Paid Mac Apps"
        case .topGrossing: return "Top Grossing Apps"
        case .topGrossingIpad: return "Top Grossing iPad Apps"
        case .new: return "New Apps"
        case .newFree: return "New Free Apps"
        case .newPaid: return "New Paid Apps"
        }
    }
}
