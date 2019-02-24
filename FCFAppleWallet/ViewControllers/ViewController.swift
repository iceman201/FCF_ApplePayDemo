//
//  ViewController.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 11/12/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController {

    weak var payButton: UIImageView?
    weak var payLabel: UILabel?
    var paymentNetwork: [PKPaymentNetwork]!
    let paymentRequest = PKPaymentRequest()
    let passLib = PKPassLibrary()

    override func loadView() {
        super.loadView()
        let watermark = UIImageView(image: #imageLiteral(resourceName: "pay_tag"), highlightedImage: nil)
        self.view.addSubview(watermark)
        watermark.translatesAutoresizingMaskIntoConstraints = false
        watermark.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -kDefaultPadding * 4).isActive = true
        watermark.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -kDefaultPadding * 3).isActive = true
        watermark.heightAnchor.constraint(equalToConstant: 80).isActive = true
        watermark.widthAnchor.constraint(equalTo: watermark.heightAnchor, multiplier: 1/1).isActive = true

        let logo = UIImageView(image: #imageLiteral(resourceName: "FILogo"))
        self.view.addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.trailingAnchor.constraint(equalTo: watermark.leadingAnchor, constant: 0).isActive = true
        logo.centerYAnchor.constraint(equalTo: watermark.centerYAnchor, constant: 10).isActive = true
        logo.heightAnchor.constraint(equalTo: watermark.heightAnchor, multiplier: 1/1).isActive = true
        logo.widthAnchor.constraint(equalTo: logo.heightAnchor, multiplier: 1).isActive = true

        let centerContainer = UIView()
        self.view.addSubview(centerContainer)
        centerContainer.translatesAutoresizingMaskIntoConstraints = false
        centerContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        centerContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        let height = centerContainer.heightAnchor.constraint(equalToConstant: 150)
        let width = centerContainer.widthAnchor.constraint(equalToConstant: 300)
        width.priority = UILayoutPriority.defaultLow
        width.isActive = true
        height.priority = UILayoutPriority.defaultLow
        height.isActive = true

        let pay = UIImageView(image: #imageLiteral(resourceName: "wallet"), highlightedImage: nil)
        let tapPay = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapOnPay))
        tapPay.numberOfTapsRequired = 1
        tapPay.numberOfTouchesRequired = 1
        centerContainer.addSubview(pay)
        pay.isUserInteractionEnabled = true
        pay.addGestureRecognizer(tapPay)
        pay.translatesAutoresizingMaskIntoConstraints = false
        pay.centerXAnchor.constraint(equalTo: centerContainer.centerXAnchor, constant: 0).isActive = true
        pay.topAnchor.constraint(equalTo: centerContainer.topAnchor, constant: 0).isActive = true
        pay.heightAnchor.constraint(equalToConstant: 80).isActive = true
        pay.widthAnchor.constraint(equalToConstant: 80).isActive = true
        payButton = pay

        let tipMessage = UILabel()
        tipMessage.numberOfLines = 0
        tipMessage.textAlignment = .center
        tipMessage.text = "Tap here to add your credit card to your Apple Wallet."
        tipMessage.sizeToFit()
        centerContainer.addSubview(tipMessage)
        tipMessage.translatesAutoresizingMaskIntoConstraints = false
        tipMessage.topAnchor.constraint(equalTo: pay.bottomAnchor, constant: kDefaultPadding * 4).isActive = true
        tipMessage.centerXAnchor.constraint(equalTo: pay.centerXAnchor, constant: 0).isActive = true
        tipMessage.widthAnchor.constraint(equalTo: pay.widthAnchor, multiplier: 2/1).isActive = true
        tipMessage.bottomAnchor.constraint(equalTo: centerContainer.bottomAnchor, constant: 0).isActive = true
        payLabel = tipMessage
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        paymentNetwork = [.amex, .chinaUnionPay, .discover, .masterCard, .visa]
    }

    @objc func tapOnPay() {
        self.initProvisioning(PKPaymentNetwork.visa)
//        if PKPaymentAuthorizationController.canMakePayments(usingNetworks: self.paymentNetwork) {
//            guard let merchant = self.getValueFromPlist(identifier: "MerchantIdentifier") else { return }
//            paymentRequest.currencyCode = "USD"
//            paymentRequest.countryCode = "US"
//            paymentRequest.merchantIdentifier = merchant
//            paymentRequest.supportedNetworks = paymentNetwork
//            paymentRequest.merchantCapabilities = [.capability3DS, .capabilityCredit]
//            paymentRequest.requiredShippingContactFields = [.name, .emailAddress, .postalAddress]
//        }
    }



    func isWalletAvailable() -> Bool {
        return PKAddPaymentPassViewController.canAddPaymentPass()
    }

    func canAddCardToWallet(primaryAccountId: String) -> Bool {
        return passLib .canAddPaymentPass(withPrimaryAccountIdentifier: primaryAccountId)
    }
}

extension ViewController: PKAddPaymentPassViewControllerDelegate {
    func initProvisioning(_ paymentType: PKPaymentNetwork) {
        let passDetails = PKAddPaymentPassRequestConfiguration(encryptionScheme: PKEncryptionScheme.RSA_V2)
        passDetails?.cardholderName = ""
        passDetails?.primaryAccountSuffix = ""
        passDetails?.localizedDescription = ""
        passDetails?.primaryAccountIdentifier = ""
        passDetails?.paymentNetwork = paymentType

        let passViewController = PKAddPaymentPassViewController(requestConfiguration: passDetails!, delegate: self as PKAddPaymentPassViewControllerDelegate)
        self.present(passViewController!, animated: true, completion: nil)
    }

    func addPaymentPassViewController(_ controller: PKAddPaymentPassViewController, generateRequestWithCertificateChain certificates: [Data], nonce: Data, nonceSignature: Data, completionHandler handler: @escaping (PKAddPaymentPassRequest) -> Void) {
        /* Information we need to send to DCIS */
        let _ = certificates
        let _ = nonce
        let _ = nonceSignature

        /* Service Call to DCIS */

        /* Create Payment pass request*/
        let passRequest = PKAddPaymentPassRequest()
        passRequest.encryptedPassData = Data()
        passRequest.activationData = Data()
        passRequest.ephemeralPublicKey = Data()


    }

    func addPaymentPassViewController(_ controller: PKAddPaymentPassViewController, didFinishAdding pass: PKPaymentPass?, error: Error?) {
        if let err = error {
            debugPrint(err)
        }
        dismiss(animated: true) {

        }
    }
}

