import UIKit

class SummaryViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FibonacciResultHistory.instance.getHistory().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RightDetail"
        let tableCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let timeResult: FibonacciTimeResult = FibonacciResultHistory.instance.getHistory()[indexPath.row]
        
        tableCell.textLabel?.text = String(timeResult.n)
        tableCell.detailTextLabel?.text = "\(timeResult.timeElapsed)ms"
        
        return tableCell
    }
}
