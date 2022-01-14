//
//  RegistrationControllet.swift
//  fefuactivity
//

//

import UIKit


class RegistrationControllet: UIViewController {

    @IBOutlet weak var genderTextField: Fefu_text_field_type_1!
    @IBOutlet weak var nicknameTextField: Fefu_text_field_type_1!
    @IBOutlet weak var loginTextField: Fefu_text_field_type_1!
    @IBOutlet weak var buttonShowPassword: UIButton!
    @IBOutlet weak var buttonShowRepeatPassword: UIButton!
    @IBOutlet weak var passwordTextField: Fefu_text_field_type_1!
    @IBOutlet weak var repeatPasswordTextField: Fefu_text_field_type_1!
    @IBAction func showPasswordField(_ sender: Any) {
    }
    @IBAction func showRepeatPasswordField(_ sender: Any) {
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        let genders = ["мужской": 1, "женский": 2]
        
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let passwordConfirm = repeatPasswordTextField.text ?? ""
        let name = nicknameTextField.text ?? ""
        let gender = genders[genderTextField.text ?? ""]
        if passwordConfirm != password {
            let alert = UIAlertController(title: "Ошибка", message: "Пароли не совпадают", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ясно", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
                
        let body = UserRegBody(login: login, password: password, name: name, gender: gender ?? 0)
                
        do {
            let reqBody = try ConnectToBackend.encoder.encode(body)
            let queue = DispatchQueue.global(qos: .utility)
            ConnectToBackend.register(reqBody) { user in
                queue.async {
                    UserDefaults.standard.set(user.token, forKey: "token")
                }
                DispatchQueue.main.async {
                    let ptr = self.storyboard?.instantiateViewController(identifier: "mainController")
                    ptr?.modalPresentationStyle = .fullScreen
                    self.present(ptr! , animated: false)
                }
                    } onError: { err in
                        DispatchQueue.main.async {
                            print(err)
                        }
                }
            } catch {
                print(error)
            }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    func commonInit(){
        // в этом моменте так и просятся питоновские замыкания, но когда я попытался выяснить как делать подобные вещи на свифте, понял что это затянется на долго, поэтому пока оставил такой вот стремный варик с двумя почти одинаковыми функциями longTap и longTap2. Потом почитаю и постараюсь поправить Еще я хотел попробовать вместо 2х одинаковых функций передавать textField в качестве параметра, но там возникают заморочки
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        let longGesture2 = UILongPressGestureRecognizer(target: self, action: #selector(longTap2(_:)))
        buttonShowPassword.addGestureRecognizer(longGesture)
        buttonShowRepeatPassword.addGestureRecognizer(longGesture2)
    }
    
    @objc func longTap(_ sender: UIGestureRecognizer){
        if sender.state == .ended {
            self.passwordTextField.isSecureTextEntry = true
        }
        else if sender.state == .began {
            self.passwordTextField.isSecureTextEntry = false
        }
    }
    @objc func longTap2(_ sender: UIGestureRecognizer){

        if sender.state == .ended {
            self.repeatPasswordTextField.isSecureTextEntry = true;
            
        }
        else if sender.state == .began {
            self.repeatPasswordTextField.isSecureTextEntry = false;
        }
    }
}


