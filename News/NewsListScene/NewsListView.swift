import UIKit

protocol NewsListViewProtocol: AnyObject {
    func displayNews(articles: [Article])
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell",
                                                       for: indexPath) as? NewsArticleTableViewCell else {
            fatalError("Unable to dequeue")
        }
        let article = articles[indexPath.row]
        cell.configure(with: article) { [weak self] urlToImage in
            if let urlToImage = urlToImage {
                self?.presenter?.downloadImage(url: urlToImage) { image in
                    DispatchQueue.main.async {
                        cell.newsImage.image = image
                    }
                }
            }
        }
        return cell
    }
}

class NewsListViewController: UIViewController, NewsListViewProtocol {
    var presenter: NewsListPresenterProtocol?

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var articles: [Article] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewsListPresenter(view: self, model: BitcoinNewsModel())
        presenter?.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.register(NewsArticleTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        tableView.dataSource = self
    }

    func displayNews(articles: [Article]) {
        self.articles = articles
    }
}
