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
    
    private var teamId: Int!
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
        tableView.register(SquadMemberCell.self,
                           forCellReuseIdentifier: SquadMemberCell.cellID)
        tableView.register(SVGHeaderCell.self,
                           forCellReuseIdentifier: SVGHeaderCell.cellID)
        fetchTeamData(id: teamId)
        
    }
    
    // MARK: - Methods
    
    static func create(interactor: FootballDataInteracting, teamID: Int) -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TeamVC") as? TeamViewController
        vc?.interactor = interactor
        vc?.teamId = teamID
        return vc
    }
    
    private func fetchTeamData(id: Int){
        
        interactor.getTeam(id: String(id)).sink { completion in
            switch completion {
            case .finished: break
            case .failure(let error):
                print("An error has occured: \(error)")
            }
        } receiveValue: { [weak self] response in
            self?.team = response
            if let name = self?.team.name {
                DispatchQueue.main.async {
                    self?.title = name
                }
            }
            if let squad = self?.team.squad {
                print(squad)
            }
        }.store(in: &subscriptions)
    }
}


// MARK: - TableView Implementation


extension TeamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TeamsSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = TeamsSections(rawValue: indexPath.section) else { return 0 }
        switch section {
        case .Logo:
            return 100
        case .Squad:
            return 56
        case .Fixtures:
            return 30
        }
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
        //TODO: AssertionFailure
        guard let section = TeamsSections(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        guard let team = team else {
            return UITableViewCell()
        }
        
        switch section {
        case .Logo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SVGHeaderCell.cellID) as? SVGHeaderCell,
                  let logoURL = team.crestUrl else {
                assertionFailure("Failed to dequeue required TeamSummaryCell")
                return UITableViewCell()
            }
            cell.setup(svgURL: logoURL)
            
            return cell
        case .Squad:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SquadMemberCell.cellID) as? SquadMemberCell,
                  let squad = team.squad,
                  squad.indices ~= indexPath.row else {
                assertionFailure("Failed to dequeue required TeamSummaryCell")
                return UITableViewCell()
            }
            let player = squad[indexPath.row]
            cell.setup(playerName: player.name ?? "N/A")
            
            return cell
        case .Fixtures:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: Add relevant functionality
        print("Well hello there!")
    }
    
    
}

