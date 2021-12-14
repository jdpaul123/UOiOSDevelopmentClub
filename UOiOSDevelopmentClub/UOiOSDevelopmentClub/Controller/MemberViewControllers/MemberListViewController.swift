//
//  MemberListViewController.swift
//  UOiOSDevelopmentClub
//
//  Created by Jonathan Paul on 8/7/21.
//

import UIKit
import CoreData

class MemberListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    /*
     Controlls the list view of executive members and advisors for the club.
     */
    
    // MARK: Properties
    // refresh control guidence from: https://cocoacasts.com/how-to-add-pull-to-refresh-to-a-table-view-or-collection-view
    private let refreshControl = UIRefreshControl()
    let viewControllerFactory: ViewControllerFactory
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var addMemberButton: UIBarButtonItem!
    
    var resultsController: NSFetchedResultsController<Member>? = nil
    let dataRepository: DataRepository
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init?(_ coder: NSCoder, dataRepository: DataRepository, viewControllerFactory: ViewControllerFactory) {
        self.dataRepository = dataRepository
        self.viewControllerFactory = viewControllerFactory
        
        super.init(coder: coder)
    }

    // MARK: IBSequeAction
    @IBSegueAction private func createMemberDetailViewController(_ coder: NSCoder) -> MemberDetailViewController? {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow, let member = resultsController?.object(at: selectedIndexPath) else {
            print("IBSequeAction failed for Member List View Controller")
            return nil
        }
        tableView.deselectRow(at: selectedIndexPath, animated: true)
        
        return viewControllerFactory.memberDetailViewController(coder, member: member)
    }
    
    @IBSegueAction private func createMemberAddDetailViewController(_ coder: NSCoder) -> MemberAddViewController? {
        return viewControllerFactory.memberAddViewController(coder)
    }
    
    // MARK: UITableViewDataSource Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return resultsController?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    // MARK: UITableViewDelegate Function
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MemberListCell
        let member = resultsController!.object(at: indexPath)
        
        cell.setCellData(member: member)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO makes the cells as tall as the picture. Not automatic so maybe could use some updating
        return 166
    }
    
    func setupTableView() {
        tableView.refreshControl = refreshControl
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsController = dataRepository.memberResultsController(delegate: self)

        // Gets rid of extra horizontal lines after the last cell in the table view
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.accessibilityIdentifier = "members-tableview"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if Injector.shared.isSignedInAsAdmin == false {
            addMemberButton.makeDisabledAndInvisable()
        }
        else {
            addMemberButton.makeEnabledAndVisable(red: 37/255, green: 150/255, blue: 190/255)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
