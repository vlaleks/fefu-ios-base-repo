//
//  LoginController.swift
//  fefuactivity
//

//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var loginTextField: Fefu_text_field_type_1!
    static private let encoder = JSONEncoder()
    @IBOutlet weak var passwordTextField: Fefu_text_field_type_1!
    @IBAction func loginButton(_ sender: Any) {
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let body = UserLoginBody(login: login, password: password)
        do {
            let reqBody = try LoginController.encoder.encode(body)
            let queue = DispatchQueue.global(qos: .utility)
            ConnectToBackend.login(reqBody) { user in
                queue.async {
                    UserDefaults.standard.set(user.token, forKey: "token")
                }
                DispatchQueue.main.async {
                    let ptr = self.storyboard?.instantiateViewController(identifier: "mainController")
                    ptr?.modalPresentationStyle = .fullScreen
                    self.present(ptr! , animated: false)
                }
            }onError: { groupErr in
                DispatchQueue.main.async {
                    for error in groupErr.errors{
                        for value in error.value{
                            if (value == "Неверный логин или пароль"){
                                let alert = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Ясно", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
                
        }

        } catch {
            print(error)
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
}
