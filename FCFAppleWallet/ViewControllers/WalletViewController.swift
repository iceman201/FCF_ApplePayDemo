//
//  WalletViewController.swift
//  FCFAppleWallet
//
//  Created by Liguo Jiao on 5/03/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit
import PassKit

fileprivate enum WalletViewSectionType {
    case transaction
    case balance
    case statement
}

class WalletViewController: UIViewController {
    
    weak var contentTable: UITableView?
    weak var creditCardPicker: CreditCardPickerView?
    weak var creditCardBalanceView: CreditCardBalanceView?
    weak var payButton: UIImageView?
    weak var headerView: UIView?
    var paymentNetwork: [PKPaymentNetwork]!
    let paymentRequest = PKPaymentRequest()
    let passLib = PKPassLibrary()

    let kTransactionCell = "kTransactionCell"
    let kBalanceCell = "kBalanceCell"
    let kStatementCell = "kStatementCell"

    let backgroundColor: UIColor = UIColor(displayP3Red: 249.0/255.0, green: 247.0/255.0, blue: 235.0/255.0, alpha: 1)
    let cardInfo = CreditCard.generateCards()
    var currentCardIndex: Int? {
        didSet {
            if sectionType == .balance {
                DispatchQueue.main.async() {
                    self.contentTable?.reloadData()
                }
                
            }
        }
    }

    fileprivate var sectionType: WalletViewSectionType = .balance {
        didSet {
            DispatchQueue.main.async() {
                self.contentTable?.reloadData()
            }
        }
    }

    override func loadView() {
        super.loadView()
        self.view.backgroundColor = UIColor.fiservWhite.combineWith(opacity: .Solid)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = backgroundColor
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.fiservOrange]
        self.title = "Apple pay"

        let content = UITableView()
        content.separatorStyle = .none
        content.backgroundColor = backgroundColor
        content.register(TransactionRecordCell.self, forCellReuseIdentifier: kTransactionCell)
        content.register(BalanceDetailCell.self, forCellReuseIdentifier: kBalanceCell)
        content.register(StatementCell.self, forCellReuseIdentifier: kStatementCell)
        self.view.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        content.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        content.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        content.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.contentTable = content

        let headerView = UIView(frame: CGRect(origin: self.view.frame.origin, size: CGSize(width: self.view.frame.width, height: 333)))
        content.tableHeaderView = headerView
        content.tableHeaderView?.layoutIfNeeded()
        self.headerView = headerView

        let creditCardPicker = CreditCardPickerView()
        creditCardPicker.delegate = self
        headerView.addSubview(creditCardPicker)
        creditCardPicker.translatesAutoresizingMaskIntoConstraints = false
        creditCardPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding * 2).isActive = true
        creditCardPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding * 2).isActive = true
        creditCardPicker.topAnchor.constraint(equalTo: headerView.topAnchor, constant: padding * 2).isActive = true
        creditCardPicker.heightAnchor.constraint(equalTo: creditCardPicker.widthAnchor, multiplier: 2.0/1.0).isActive = true
        self.creditCardPicker = creditCardPicker

        let pay = UIImageView(image: #imageLiteral(resourceName: "AddToWallet"))
        let tapPay = UITapGestureRecognizer(target: self, action: #selector(MainViewController.tapOnPay))
        tapPay.numberOfTapsRequired = 1
        tapPay.numberOfTouchesRequired = 1
        pay.contentMode = .scaleAspectFill
        headerView.addSubview(pay)
        pay.isUserInteractionEnabled = true
        pay.addGestureRecognizer(tapPay)
        pay.translatesAutoresizingMaskIntoConstraints = false
        pay.heightAnchor.constraint(equalToConstant: 35).isActive = true
        pay.widthAnchor.constraint(equalToConstant: 120).isActive = true
        pay.topAnchor.constraint(equalTo: creditCardPicker.bottomAnchor, constant: padding * 2).isActive = true
        pay.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding * 2).isActive = true
        pay.layoutIfNeeded()
        pay.drawButtonShadow()
        self.payButton = pay

        let due = UIButton()
        due.setTitle("Next Payment Due", for: .normal)
        due.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        due.contentEdgeInsets = UIEdgeInsets(top: 0, left: padding * 1.5, bottom: 0, right: padding * 1.5)
        due.setTitleColor(.fiservOrange, for: .normal)
        due.backgroundColor = UIColor.fiservWhite.combineWith(opacity: .Solid)
        due.layer.borderWidth = 1
        due.layer.borderColor = UIColor.fiservOrange.cgColor
        due.layer.cornerRadius = defaultCornerRadius
        due.addTarget(self, action: #selector(WalletViewController.tapOnDuePayment), for: .touchUpInside)
        headerView.addSubview(due)
        due.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            due.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding * 2),
            due.topAnchor.constraint(equalTo: pay.bottomAnchor, constant: padding),
            due.heightAnchor.constraint(equalTo: pay.heightAnchor)
        ])
        due.layoutIfNeeded()
        due.drawButtonShadow()

        let creditCardBalance = CreditCardBalanceView()
        headerView.addSubview(creditCardBalance)
        creditCardBalance.translatesAutoresizingMaskIntoConstraints = false
        creditCardBalance.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding * 2).isActive = true
        creditCardBalance.topAnchor.constraint(equalTo: creditCardPicker.bottomAnchor, constant: padding * 2).isActive = true
        creditCardBalance.bottomAnchor.constraint(equalTo: due.bottomAnchor, constant: 0).isActive = true
        creditCardBalance.widthAnchor.constraint(equalTo: creditCardBalance.heightAnchor, multiplier: 2/1).isActive = true
        self.creditCardBalanceView = creditCardBalance
        
        let divider = headerView.addDivider(on: headerView, topOf: creditCardBalance, color: .fiservOrange)
        
        let payment = PaymentView()
        payment.sectionTitle?.text = "Send Money to"
        payment.paylist = ["aa", "ss", "fadsf"]
        headerView.addSubview(payment)
        payment.translatesAutoresizingMaskIntoConstraints = false
        payment.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: padding).isActive = true
        payment.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding * 2).isActive = true
        payment.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        payment.heightAnchor.constraint(equalToConstant: padding * 15).isActive = true
        
        let sectionSwitch = TransactionSegmentControl(frame: .zero, segmentColor: UIColor.fiservOrange.combineWith(opacity: .Secondary))
        sectionSwitch.segmentTitles = ["Details", "Transaction", "Statement"]
        headerView.addSubview(sectionSwitch)
        sectionSwitch.translatesAutoresizingMaskIntoConstraints = false
        sectionSwitch.topAnchor.constraint(equalTo: payment.bottomAnchor).isActive = true
        sectionSwitch.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding * 2).isActive = true
        sectionSwitch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -padding * 2).isActive = true
        sectionSwitch.heightAnchor.constraint(equalToConstant: padding * 5).isActive = true

        // Bottom Anchor has to be given otherwise it cant calculate headerview high automatically
        sectionSwitch.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        sectionSwitch.addTarget(self, action: #selector(WalletViewController.tapOnSegment), for: .valueChanged)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.contentTable?.delegate = self
        self.contentTable?.dataSource = self
        self.paymentNetwork = [.amex, .chinaUnionPay, .discover, .masterCard, .visa]

        setupCreditCard()
    }

    func setupCreditCard() {
        var allCards = [CreditCardView]()
        var allCardBalances = [Float]()
        var allCardLimits = [Float]()
        self.cardInfo.forEach { (card) in
            let newCard = CreditCardView()
            newCard.loadContent(cardName: card.name, cardNumber: card.number, cardDate: card.expiryDate, cardProvider: card.provider)
            allCards.append(newCard)
            allCardBalances.append(card.cardDetails.creditLimit - card.cardDetails.closeBalance)
            allCardLimits.append(card.cardDetails.creditLimit)
        }
        self.creditCardPicker?.cardBalances = allCardBalances
        self.creditCardPicker?.creditLimits = allCardLimits
        self.creditCardPicker?.cards = allCards
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let headerView = contentTable?.tableHeaderView else { return }
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        var headerFrame = headerView.frame

        if height != headerFrame.size.height {
            headerFrame.size.height = height
            headerView.frame = headerFrame
            contentTable?.tableHeaderView = headerView
            contentTable?.layoutIfNeeded()
        }
        headerView.translatesAutoresizingMaskIntoConstraints = true
    }

    @objc func tapOnSegment(_ sender: TransactionSegmentControl) {
        switch sender.selectedIndex {
        case 0:
            sectionType = .balance
        case 1:
            sectionType = .transaction
        case 2:
            sectionType = .statement
        default:
            break
        }
    }

    @objc func tapOnDuePayment() {
        // Link to Ben's Transaction FCF
    }

    @objc func tapOnPay() {
        var current: PKPaymentNetwork!

        guard let currentCard = self.creditCardPicker?.cards?[self.creditCardPicker?.pageControl?.currentPage ?? 0].cardProvider else { return }
        switch currentCard {
        case .visa:
            current = PKPaymentNetwork.visa
        case .mastercard:
            current = PKPaymentNetwork.masterCard
        case .americanExpress:
            current = PKPaymentNetwork.amex
        default:
            break
        }

        self.initProvisioning(current)
         // Trigger Adding Visa Credit Card info

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
        return passLib.canAddPaymentPass(withPrimaryAccountIdentifier: primaryAccountId)
    }
}

extension WalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.sectionType {
        case .balance:
            return 320
        case .statement:
            return 160
        case .transaction:
            return padding * 8
        }
    }
}

extension WalletViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.sectionType {
        case .balance:
            return 1
        case .statement:
            return 1
        case .transaction:
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch self.sectionType {
        case WalletViewSectionType.balance:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: kBalanceCell, for: indexPath) as? BalanceDetailCell else { return UITableViewCell() }
            let details = cardInfo[self.currentCardIndex ?? 0].cardDetails
            cell.loadCardDetails(period: details.period,
                                 closeBalance: details.closeBalance,
                                 minimumPaymentDue: details.minimumPayDue,
                                 dueBy: details.dueBy,
                                 ptcb: details.ptcb,
                                 type: details.type,
                                 creditLimit: details.creditLimit,
                                 purchaseInterestRate: details.purchaseRate,
                                 cashInterestRate: details.cashRate)
            return cell
        case WalletViewSectionType.statement:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: kStatementCell, for: indexPath) as? StatementCell else { return UITableViewCell() }
            return cell
        case WalletViewSectionType.transaction:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: kTransactionCell, for: indexPath) as? TransactionRecordCell else { return UITableViewCell() }
            cell.contentBackground.backgroundColor = UIColor.fiservOrange.combineWith(opacity: .Secondary)// this should goes to view class
            cell.backgroundColor = backgroundColor
            cell.balanceLabel.text = "-$\(Int.random(in: 1...99))"
            cell.dateLineLabel.text = "\(Int.random(in: 1...30)) Feb 2019"
            cell.topLineLabel.text = "Team Lunch"
            cell.subLineLabel.text = "Auckland, New Zealand"
            return cell
        }

    }
}

extension WalletViewController: PKAddPaymentPassViewControllerDelegate {
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

    func addPaymentPassViewController(_ controller: PKAddPaymentPassViewController,
                                      generateRequestWithCertificateChain certificates: [Data],
                                      nonce: Data,
                                      nonceSignature: Data,
                                      completionHandler handler: @escaping (PKAddPaymentPassRequest) -> Void) {
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
            let alert = UIAlertController(title: "Error", message: "\(error?.localizedDescription ?? "")", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            debugPrint(err)
        }
        if pass?.activationState == PKPaymentPassActivationState.activated {
            print("haha")
        }
        dismiss(animated: true) {
            //Store the card success
            if error == nil {

            }
            print("closed")
        }
    }
}

extension WalletViewController: CreditCardScrollingDelegate {
    func getCurrectSelectIndex(index: Int) {
        self.currentCardIndex = index
    }

    func getCardLimitPercentage(percentage: Float) {
        self.creditCardBalanceView?.startAnimation(with: percentage)
    }
    
    func getSelectCardBalance(balance: Float) {
        self.creditCardBalanceView?.balanceLabel?.counting(fromValue: 0, toValue: balance, withDuration: 1, animationType: .EaseIn, counterType: .Float)
    }
}
