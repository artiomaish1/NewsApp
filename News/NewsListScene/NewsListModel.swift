import Foundation
import UIKit

protocol NewsListModel {
    var newsURL: URL? { get set }
    func getNews(completion: @escaping (Response?) -> ()) // () = Void, разницы нету, но так меньше символов :-)
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> ())
}

class BitcoinNewsModel: NewsListModel {

    var newsURL = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=a6f788672a2940e9aca923ca6de8798a")

    func getNews(completion: @escaping (Response?) -> ()) {
        if let unwrappedURL = newsURL {
            let request = URLRequest(url: unwrappedURL)
            let dataTask = URLSession.shared.dataTask(with: request) { data, _, _ in
                DispatchQueue.main.async {
                    if let data = data {
                        do {
                            let response = try JSONDecoder().decode(Response.self, from: data) as Response
                            completion(response)
                        } catch {
                            completion(nil)
                        }
                    } else {
                        completion(nil)
                    }
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
    }

    func downloadImage(url: URL, completion: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: URLRequest(url: url, timeoutInterval: 10.0)) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
}
