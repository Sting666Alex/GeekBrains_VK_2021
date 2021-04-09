//
//  ViewController.swift
//  VK_Belov
//
//  Created by Алексей Белов on 17.02.2021.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginTestField: UITextField!
    @IBOutlet weak var passwordTestField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // >> Это на уроке - добавление не в storyboard
        //let tap = UITapGestureRecognizer(target: self, action: #selector(scrollTapped))
        //scrollView.addGestureRecognizer(tap)
        // << Это на уроке - добавление не в storyboard
        
        //addTapGestureToHideKeyboard() // Это из форумов
        
        showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.hideLoading()
        }
        
    }
    
        //func addTapGestureToHideKeyboard() {
        //       let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        //       view.addGestureRecognizer(tapGesture)
        //}
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
                                self,
                                selector: #selector(keyboardWillShow),
                                name: UIResponder.keyboardWillShowNotification,
                                object: nil
                                )
        
        NotificationCenter.default.addObserver(
                                self,
                                selector: #selector(keyboardWillHide),
                                name: UIResponder.keyboardWillHideNotification,
                                object: nil
                                )
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print(self, #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //print(self, #function)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //print(self, #function)
    }
    
    // MARK: - Keyboard
    @objc func keyboardWillShow(notification: Notification){
       // print(#function)
        let key = UIResponder.keyboardFrameEndUserInfoKey
        guard let kbSize = notification.userInfo?[key] as? CGRect else {return}
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
    }
    
    @objc func keyboardWillHide(notification: Notification){
        //print(#function)
        scrollView.contentInset = .zero
    }
    
    // MARK: - Action
    
    @IBAction func scrollTapped(_ sender: UITapGestureRecognizer) {
        //print(#function)
        view.endEditing(true) // close keyboard
    }
    
    @IBAction func signinTapped(_ sender: UIButton){
        
//        if !checkingThePasswordName() {
//            return
//        } else {
//
//        }
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let TabBarView = storyboard.instantiateViewController(identifier: "TabBar")
//        present(TabBarView, animated: true, completion: nil)
    }
    
    @IBAction func tfLogin(_ sender: Any) {
    }
    
    @IBAction func tfPass(_ sender: Any) {
    }
    
    func checkingThePasswordName()-> Bool{
        return true // loginTestField.text == "Admin" && passwordTestField.text == "123"
    }
    
    
//    @IBAction func buttomLogin(_ sender: Any) {
//        print(self, #function)
//    }
    
    @IBAction func buttomRegistraited(_ sender: Any) {
        //print(self, #function)
    }
    
    
    // MARK: - Segues
    @IBAction func unwindToLogin(_ sender: UIStoryboardSegue){
       // print(self, #function)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "TabBar" else { return true }
         
        let isValid = checkingThePasswordName()
        if !isValid {
            showLoginErrorAlert(message: "Invalid login or password")
        }
        return isValid
    }
}
