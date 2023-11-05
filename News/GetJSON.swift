import Foundation
import UIKit

struct NewsApiData {
    let title: String
    let description: String
    let imageUrl: String
}

struct Response: Codable {
    let title: [Item]
    let description: [Item]
    let content: [Item]
}

struct Item: Codable {
    let metadata: [Metadatum]
}

struct Metadatum: Codable {
    let key: String
    let value: String?
}

let newsURL = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-10-02&sortBy=publishedAt&apiKey=a6f788672a2940e9aca923ca6de8798a")

func getImage(){
    if let unwrappedURL = newsURL {
        var request = URLRequest(url: unwrappedURL)
        request.addValue("a6f788672a2940e9aca923ca6de8798a", forHTTPHeaderField: "TRN-Api-Key")
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(Response.self, from: data) as Response
                    print(json.title.count)
                } catch {
                    print(String(describing: error))
                }
            }
        }
        dataTask.resume()
    }
}



