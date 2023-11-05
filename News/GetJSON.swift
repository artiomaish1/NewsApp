import Foundation
import UIKit


protocol ResponseInteractive {
    func getResponse(completion: @escaping (Response?) -> Void)
}

protocol ImageDownloadable {
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void)
}

struct Article: Codable {
    let title: String?
    let description: String?
    let urlToImage: String?
    
}

struct Response: Codable {
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    let code: String?
    let message: String?
}

class BitcoinNewsReader: ResponseInteractive {
    
    private let newsURL = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=a6f788672a2940e9aca923ca6de8798a")
    
    func getResponse(completion: @escaping (Response?) -> Void) {
        if let unwrappedURL = newsURL {
            let request = URLRequest(url: unwrappedURL)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
}

class ImageGetter {
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
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
