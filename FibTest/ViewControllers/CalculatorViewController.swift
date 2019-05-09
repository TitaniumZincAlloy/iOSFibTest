import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, FibonacciCalculatorDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotalTime: UILabel!
    @IBOutlet weak var constraintTotalTimeBottom: NSLayoutConstraint!
    
    let fibCalculator: FibonacciCalculator = FibonacciCalculator()
    private var resultsList = [UInt]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupKeyboard()
        tableView.tableFooterView = UIView()
        fibCalculator.delegate = self
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RightDetail"
        let tableCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        tableCell.textLabel?.text = String(indexPath.row)
        tableCell.detailTextLabel?.text = String(resultsList[indexPath.row])
        
        return tableCell
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let numberSet = CharacterSet(charactersIn:"+0123456789 ")
        let characterSet = CharacterSet(charactersIn: string)
        return numberSet.isSuperset(of: characterSet)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        let nInt = Int(textField.text ?? "") ?? 0
        if nInt > 93 {
            self.displayNumberTooBigAlert()
        } else {
            fibCalculator.calculateFibonacciForN(nInt)
        }
        
        return true
    }
    
    // MARK: FibonacciCalculatorDelegate
    
    func finishedCalculation(resultsList: [UInt], timedResult: FibonacciTimeResult) {
        self.resultsList = resultsList
        self.tableView.reloadData()
        self.updateTime(timeInMillis: timedResult.timeElapsed)
        FibonacciResultHistory.instance.recordNewResult(timedResult)
    }
    
    // MARK: Setup Functions
    
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object: nil);

    }
    
    // MARK: Alerts
    
    private func displayNumberTooBigAlert() {
        let alertController = UIAlertController(title: "N is too big", message: "N cannot exceed 93 because of overflow errors", preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Keyboard Helpers
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.constraintTotalTimeBottom.constant = keyboardHeight
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        self.constraintTotalTimeBottom.constant = 0
        self.view.layoutIfNeeded()
    }
    
    // MARK: Helper
    
    private func updateTime(timeInMillis: UInt) {
        let totalTimeStr = "Total Time \(timeInMillis)ms"
        self.lblTotalTime.text = totalTimeStr;
    }
}

