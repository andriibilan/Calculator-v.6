//
//  OutputViewController.swift
//  Calculator v.5
//
//  Created by andriibilan on 10/11/17.
//  Copyright © 2017 andriibilan. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController {
    @IBOutlet weak var historyView: UIView!
    @IBOutlet weak var resultView: UIView!
    
    @IBAction func deleteHistory(_ sender: UIButton) {
        history?.deleteAllHistory()
        scaleAnimate(button: sender)
        cleanAll()
        UserDefaults.standard.set(false, forKey: "clean")
    }
    var outputInterface: OutputInterface?
    var history: HistoryProtocol?
    
    func hideHistoryOutput(changeLabel: Bool) {
        if changeLabel == true {
            historyView.isHidden = false
            resultView.isHidden = true
        } else {
            historyView.isHidden = true
            resultView.isHidden = false
        }
    }
    
    func displayResults(value: String) {
        outputInterface?.cleanLabel()
        outputInterface?.displayResult(value, operatorPressed: false)
    }
    
    func display(value: String, operatorPressed: Bool) {
        outputInterface?.displayResult(value, operatorPressed: operatorPressed)
    }
    
    func currentTexTinDisplay() -> String {
        return (outputInterface?.viewInDisplay())!        
    }
    
    func cleanAll() {
        outputInterface?.cleanLabel()
    }
    
    func clearLast(value: String) {
        outputInterface?.clearDisplay(value)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyView.isHidden = true
    }
    
    func getHistoryArray(equation: String, result: String) {
        history?.getHistoryArray(equation: equation, result: result)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    func scaleAnimate(button: UIButton) {
        button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowUserInteraction, animations: { [button] in
            button.transform = CGAffineTransform.identity
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "outputResult" {
            outputInterface = segue.destination as? OutputResultViewController
        }
        if segue.identifier == "outputHistory" {
            history = segue.destination as? OutputHistoryViewController
        }
    }
    
}
