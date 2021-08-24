//
//  TeamViewController.swift
//  364Scores
//
//  Created by Yohai Reshef on 24/08/2021.
//

import UIKit
import Combine

class TeamViewController: UIViewController {
    
    // MARK: - Properties | Components
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties | Variables
    
    private var interactor: FootballDataInteracting!
    private var subscriptions: Set<AnyCancellable> = []
    
    //TODO: Find a better solution!
    var teamId: Int! {
        didSet {
            if let id = teamId {
                print("Team id is: \(id)")
                fetchTeamData(id: String(id))
            }
        }
    }
    private var team: Team! {
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("Reloaded table view!")
            }
        }
    }
    private let upcomingFixtures = 10
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    static func create(interactor: FootballDataInteracting) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TeamVC") as? TeamViewController
        vc?.interactor = interactor
        
        return vc
    }
    
    private func fetchTeamData(id: String){
        interactor.getTeam(id: id).sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                print("An error has occured: \(error)")
            }
        } receiveValue: { [weak self] response in
            //TODO: Implement
            self?.team = response
            if let name = self?.team.name {
            }
            if let squad = self?.team.squad {
                print(squad)
            }
        }.store(in: &subscriptions)
    }
}



extension TeamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TeamsSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = TeamsSections(rawValue: section) else { return 0 }
        
        switch section {
        case .Logo:
            return 1
        case .Squad:
            if let team = team {
                if let squad = team.squad {
                    return squad.count
                }
            }
        case .Fixtures:
            return upcomingFixtures
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell") else {
            return UITableViewCell()
        }
        guard let section = TeamsSections(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        guard let team = team else {
            return UITableViewCell()
        }
        
        switch section {
        case .Logo:
            print("I got a team!")
            if let url = team.crestUrl {
                print(url)
                if let imageview = cell.imageView {
                }
            }
        case .Squad:
            cell.textLabel?.text = team.squad?[indexPath.row].name ?? ""
        case .Fixtures:
            cell.textLabel?.text = "Games ho"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Add relevant functionality
        print("Well hello there!")
    }
    
    
}

