import Foundation
import UIKit

protocol NewsListPresenterProtocol {
    func viewDidLoad()
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void)
}

class NewsListPresenter: NewsListPresenterProtocol {
    private weak var view: NewsListViewProtocol?
    private let model: NewsListModel

    init(view: NewsListViewProtocol, model: NewsListModel) {
        self.view = view
        self.model = model
    }

    func viewDidLoad() {
        model.getNews { [weak self] response in
            self?.view?.displayNews(articles: response?.articles ?? [])
        }
    }

    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        model.downloadImage(url: url, completion: completion)
    }
}
