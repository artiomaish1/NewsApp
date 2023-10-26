import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let dataModel = ["Cat", "Dog", "Fish", "Monkey","Cat", "Dog", "Fish", "Monkey","Cat", "Dog", "Fish", "Monkey","Cat", "Dog", "Fish", "Monkey","Cat", "Dog", "Fish", "Monkey","Cat", "Dog", "Fish", "Monkey","Cat", "Dog", "Fish", "Monkey","Cat", "Dog", "Fish", "Monkey"]

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = dataModel[indexPath.row]

        return cell
    }


    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "News"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.backgroundColor = .white

        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self

        self.view.addSubview(tableView)

    }

}

