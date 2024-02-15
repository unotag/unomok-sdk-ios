//
//  ViewController.swift
//  UnomokSample
//
//  Created by Bindu R S on 14/11/23.
//

import UIKit
import Unomok

class UMHomeViewController: MokBaseViewController {
    
    @IBOutlet weak var userIdTextField: UMTextField!
    @IBOutlet weak var eventNameTextField: UMTextField!
    @IBOutlet weak var eventParamTextField: UMTextField!
    @IBOutlet weak var fcmTokenLabel: UILabel!
    @IBOutlet weak var apnsTokenLabel: UILabel!
    @IBOutlet weak var activityIndicatorBGView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var updateButton: UIButton!
    
    static var newTarget = UIView(frame: CGRect.zero)
    var contentArray = [MokContent]()
    
    
    enum OnboardingType : String {
        case image = "image"
        case html = "html"
        case video = "video"
    }
    
    //MARK: - View Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Custom Methods
    
    private func setupView() {
        setupUserIdTextField()
    }
    
    private func showLoading() {
        DispatchQueue.main.async { [self] in
            activityIndicatorBGView.isHidden = false
            activityIndicatorView.startAnimating()
        }
    }
    
    private func hideLoading() {
        DispatchQueue.main.async { [self] in
            activityIndicatorView.stopAnimating()
            activityIndicatorBGView.isHidden = true
        }
    }
    
    private func setupUserIdTextField() {
        userIdTextField.text = "MOASDK_1001"
        userIdTextField.becomeFirstResponder()
    }
    
    private func updateFcmToken(userId: String, fcmToken: String) {
        showLoading()
        let params = [
            "fcm_registration_token": fcmToken
        ]
        MokSDK.updateUser(userID: userId, withParameters: params) { [self] (successMessage, error) in
            hideLoading()
        }
    }
    
    private func updateApns(userId: String, deviceToken: String) {
        showLoading()
        let params = [
            "device_token": deviceToken
        ]
        MokSDK.updateUser(userID: userId, withParameters: params) { [self] (successMessage, error) in
            hideLoading()
        }
    }
    
    private func convertApnsTokenToString(apnsToken: Data) -> String {
        let tokenString = apnsToken.map { String(format: "%02x", $0) }.joined()
        print("token String: \(tokenString)")
        return tokenString
    }
    
    
    private func updateUser(id: String) {
        
        showLoading()
        let params = [
            "name": id+"_iOS_SDK"
        ]
        MokSDK.updateUser(userID: id, withParameters: params) { [self] (successMessage, error) in
            updateButton.configuration?.showsActivityIndicator = false
            hideLoading()
        }
    }
    
    private func logMokEvent(userId: String, eventName: String, params: [String: Any]) {
        showLoading()
        MokSDK.logEvent(
            userID: userId,
            eventName: eventName,
            parameters: params) { [self] (successMessage, error) in
                hideLoading()
            }
    }
    
    
    //MARK: - Segment Action
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
    }
    
    //MARK: - Button Actions
    
    @IBAction func updateUserIdTapped(_ sender: UIButton) {
        if userIdTextField.textCount == 0 {
            showAlert(
                self,
                title: kAlertTitle,
                message: kUserIdShouldNotEmpty)
        } else {
            sender.configuration?.showsActivityIndicator = true
            updateUser(id: userIdTextField.text ?? "")
        }
    }
    
    @IBAction func logEventTapped(_ sender: UIButton) {
        
        if let id = userIdTextField.text, let eventName = eventNameTextField.text, let eventParamString = eventParamTextField.text {
            
            let params = eventParamString.escapeQuotesExceptFirstAndLast()
                .convertToDictionary()
            logMokEvent(
                userId: id,
                eventName: eventName,
                params: params)
        } else {
            showAlert(
                self,
                title: kAlertTitle,
                message: kEventDetailsShoulNotBeEmplty)
        }
    }
    
    @IBAction func fetchFCMTapped(_ sender: UIButton) {
        
        MokSDK.registerDeviceTokenForRemoteNotification(deviceToken: nil) { [self] token, successMessage, error in
            if let token {
                print("FCM token : \(token)")
                fcmTokenLabel.text = token
            }
            if let error {
                print("FCM token Error: \(error)")
                fcmTokenLabel.text = "(error)"
            }
        }
    }
    
    @IBAction func updateFCMTapped(_ sender: UIButton) {
        if let userId = userIdTextField.text, userId.count != 0 {
            let fcmToken = fcmTokenLabel.text?.count == 0 ? "N/A" : fcmTokenLabel.text ?? "N/A"
            updateFcmToken(userId: userId, fcmToken: fcmToken)
        } else {
            showAlert(
                self,
                title: kAlertTitle,
                message: kUserIdShouldNotEmpty)
        }
    }
    
    @IBAction func fetchApnsTapped(_ sender: UIButton) {
        showLoading()
        MokSDK.registerDeviceTokenForRemoteNotification(deviceToken: nil) { [self] token, successMessage, error in
            if successMessage != nil {
                if let apnsToken {
                    apnsTokenLabel.text = convertApnsTokenToString(apnsToken: apnsToken)
                } else {
                    apnsTokenLabel.text = "invalid token"
                }
            }
            if let error {
                print("FCM token Error: \(error)")
                fcmTokenLabel.text = "(error)"
            }
            hideLoading()
        }
    }
    
    @IBAction func updateApnsTapped(_ sender: UIButton) {
        if let userId = userIdTextField.text, userId.count != 0, let apnsToken {
            let token = convertApnsTokenToString(apnsToken: apnsToken)
            updateApns(userId: userId, deviceToken: token)
        } else {
            showAlert(
                self,
                title: kAlertTitle,
                message: kUserIdShouldNotEmpty)
        }
    }
    
    @IBAction func showAllInappPopupsTapped(_ sender: UIButton) {
        MokSDK.loadAllPendingPopups()
    }
    
    @IBAction func deleteAllInappPopupsTapped(_ sender: UIButton) {
        MokSDK.removeAllInappData()
    }
    
    @IBAction func fetchAllInappPopupsTapped(_ sender: UIButton) {
        if let userId = userIdTextField.text, userId.count != 0 {
            showLoading()
            MokSDK.fetchInappNotifications(userID: userId) { [self] inAppMessage, error in
                
                if let error {
                    print(error.localizedDescription)
                }
                hideLoading()
            }
        } else {
            showAlert(
                self,
                title: kAlertTitle,
                message: kUserIdShouldNotEmpty)
        }
        
    }
    @IBAction func fetchOnboardingScreenDataTapped(_ sender: UIButton) {
        showLoading()
        MokSDK.fetchAllOnboardingScreenContents {  [self] onboardingResponseArray, error in
            hideLoading()
        }
    }
    
    @IBAction func showOnboardingScreenTapped(_ sender: UIButton) {
        MokSDK.showOnboardingScreen()
    }
    
    @IBAction func fetchCarousalDataTapped(_ sender: UIButton) {
        showLoading()
        MokSDK.fetchAllCarouselContents { [self] carousalArray, error in
            print("Carousal data count: \(carousalArray.count)")
            
            if let error {
                print(error.localizedDescription)
            }
            hideLoading()
        }
    }
    
    @IBAction func showCarousalViewTapped(_ sender: UIButton) {
        showLoading()
        MokSDK.showCarouselViews { [self] in
            hideLoading()
        }
    }
    
    @IBAction func deleteAllCarousalViewTapped(_ sender: UIButton) {
        showLoading()
        MokSDK.removeAllCarouselData { [self] in
            hideLoading()
        }
    }
    @IBAction func nextTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "details", sender: self)
    }
}

extension UMHomeViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UIViewController {
    /**
     Hides the navigation bar.
     
     This method hides the navigation bar by setting its visibility to `true` without animation.
     */
    func hideNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    /**
     Shows the navigation bar.
     
     This method shows the navigation bar by setting its visibility to `false` with animation.
     */
    func showNavigation() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func findView(withAccessibilityLabel label: String, in view: UIView) -> UIView? {
        
        for subview in view.subviews {
            if subview.accessibilityLabel == label {
                return subview
            }
            if let foundSubview = findView(withAccessibilityLabel: label, in: subview) {
                return foundSubview
            }
        }
        
        return nil
    }
    
    func storyboardName() -> String? {
        // Check if the view controller has a nib name (usually corresponds to the storyboard name)
        if let nibName = self.nibName, nibName != NSStringFromClass(type(of: self)) {
            return nibName
        }
        
        // If the nib name is not available, try to infer the storyboard name from the restoration identifier
        if let restorationIdentifier = self.restorationIdentifier {
            let components = restorationIdentifier.components(separatedBy: ".")
            if components.count > 1 {
                return components[0]
            }
        }
        
        return nil
    }
}


