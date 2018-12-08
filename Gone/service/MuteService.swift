import Foundation

class MuteService {
    private static let udSitesKey = "udSites"

    static func setMute(host: String) {
        var hosts = (UserDefaults.standard.array(forKey: MuteService.udSitesKey) as? [String]) ?? [String]()

        if !hosts.contains(host) {
            hosts.append(host)
            UserDefaults.standard.set(hosts, forKey: MuteService.udSitesKey)
        }
    }

    static func setMutes(hosts: [String]) {
        UserDefaults.standard.set(hosts, forKey: MuteService.udSitesKey)
    }

    static func getMutes() -> [String]? {
        return UserDefaults.standard.array(forKey: MuteService.udSitesKey) as? [String]
    }

    static func filter<T: Article>(articles: [T]) -> [T] {
        guard let mutes = MuteService.getMutes() else {
            return articles
        }

        return articles.filter {
            return !mutes.contains($0.host)
        }
    }
}
