import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsView", for: indexPath) as? NewsView
        else { fatalError() }

        cell.configure(article: articles[indexPath.row])

        return cell
    }
}

class ViewController: UIViewController {

    var articles: [Article] = []
    var articleGetter = BitcoinNewsReader()
    var newsView = NewsView()

    override func loadView() {
        self.view = newsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "News"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .white

        self.newsView.tableView.dataSource = self
        self.newsView.setupTableView()

        articleGetter.getResponse { [weak self] response in
            self?.articles = response?.articles ?? []
            self?.newsView.tableView.reloadData()
        }
    }
}


