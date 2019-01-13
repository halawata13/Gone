import Foundation

class MuteService {
    private static let udSitesKey = "udSites"

    ///
    /// ミュートするホスト名を保存する
    ///
    static func setMute(host: String) {
        var hosts = (UserDefaults.standard.array(forKey: MuteService.udSitesKey) as? [String]) ?? [String]()

        if !hosts.contains(host) {
            hosts.append(host)
            UserDefaults.standard.set(hosts, forKey: MuteService.udSitesKey)
        }
    }

    ///
    /// ミュートするホスト名を保存する
    ///
    static func setMutes(hosts: [String]) {
        UserDefaults.standard.set(hosts, forKey: MuteService.udSitesKey)
    }

    ///
    /// ミュートするホスト名を取得する
    ///
    static func getMutes() -> [String]? {
        return UserDefaults.standard.array(forKey: MuteService.udSitesKey) as? [String]
    }

    ///
    /// ミュートするホスト名に基づいてフィルタする
    ///
    static func filter(articles: [Article]) -> [Article] {
        guard let mutes = MuteService.getMutes() else {
            return articles
        }

        return articles.filter {
            return !mutes.contains($0.host)
        }
    }
}
