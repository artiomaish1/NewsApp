import UIKit

protocol NewsViewDownloadable{
    func configure(article: Article)
}

class NewsView: UITableViewCell, NewsViewDownloadable {
    private let newsImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let notFoundLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let newsDescription: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.backgroundColor = .white
        contentView.addSubview(newsImage)
        contentView.addSubview(newsTitle)
        contentView.addSubview(newsDescription)
        
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsImage.heightAnchor.constraint(equalToConstant: 40),
            newsImage.widthAnchor.constraint(equalToConstant: 40),
            
            newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            newsTitle.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 16),
            newsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            newsDescription.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 8),
            newsDescription.leadingAnchor.constraint(equalTo: newsImage.trailingAnchor, constant: 16),
            newsDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newsDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    func setupTableView() {
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.register(NewsView.self, forCellReuseIdentifier: "NewsView")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configure(article: Article) {
        newsTitle.text = article.title
        newsDescription.text = article.description
        if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
            ImageGetter().downloadImage(url: url) { [weak self] image in
                self?.newsImage.image = image
            }
        } else {
            newsImage.image = nil
        }
    }
}

