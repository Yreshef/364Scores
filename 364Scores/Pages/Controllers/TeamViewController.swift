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
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy 'at' HH:mm"
        return formatter
    }()
    
    private let isoDateFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        return formatter
    }()
    
    // MARK: - Properties | Variables
    
    private var interactor: FootballDataInteracting!
    private var subscriptions: Set<AnyCancellable> = []
    
    private var teamId: Int!
    private var team: Team! {
        didSet{
            onDataChange()
        }
    }
    private var matches: [Match]! {
        didSet {
            onDataChange()
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
        tableView.register(UpcomingFixuresCell.self,
                           forCellReuseIdentifier: UpcomingFixuresCell.cellID)
        fetchTeamData(id: teamId)
        fetchMatchData()
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
        }.store(in: &subscriptions)
    }
    
    private func fetchMatchData() {
        interactor.getMatches(
            forTeamID: String(teamId),
            limit: upcomingFixtures).sink {
                completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("An error has occured: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.matches = response.matches
            }.store(in: &subscriptions)
    }
    
    private func onDataChange() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            print("Reloaded table view!")
        }
    }
    
}

// MARK: - TableView Implementation


extension TeamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TeamsSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = TeamsSections(rawValue: section) else { return nil }
        switch section {
        case .Logo:
            return nil
        case .Squad:
            return TeamsSections.Squad.description
        case .Fixtures:
            return TeamsSections.Fixtures.description
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = TeamsSections(rawValue: indexPath.section) else { return 0 }
        switch section {
        case .Logo:
            return 100
        case .Squad:
            return 56
        case .Fixtures:
            return 80
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
            return matches?.count ?? 0
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
        guard let matches = matches else {
            return UITableViewCell()
        }
        
        switch section {
        case .Logo:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SVGHeaderCell.cellID) as? SVGHeaderCell,
                  let logoURL = team.crestUrl else {
                assertionFailure("Failed to dequeue required SquadMemberCell")
                return UITableViewCell()
            }
            cell.setup(svgURL: logoURL)
            cell.selectionStyle = .none
            
            return cell
        case .Squad:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SquadMemberCell.cellID) as? SquadMemberCell,
                  let squad = team.squad,
                  squad.indices ~= indexPath.row else {
                assertionFailure("Failed to dequeue required SquadMemberCell")
                return UITableViewCell()
            }
            let player = squad[indexPath.row]
            cell.setup(playerName: player.name ?? "N/A")
            cell.selectionStyle = .none
            
            return cell
        case .Fixtures:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingFixuresCell.cellID) as? UpcomingFixuresCell,
                  matches.indices ~= indexPath.row,
                  let homeTeamName = matches[indexPath.row].homeTeam.name,
                  let awayTeamName = matches[indexPath.row].awayTeam.name,
                  let date = matches[indexPath.row].utcDate,
                  let competition = matches[indexPath.row].competition.name,
                  let formattedDate = isoDateFormatter.date(from: date)
                  else {
                assertionFailure("Failed to dequeue required UpcomingFixuresCell")
                return UITableViewCell()
            }
            let formattedString = dateFormatter.string(from: formattedDate)
            cell.setup(homeTeam: homeTeamName, awayTeam: awayTeamName,
                       date: formattedString, competition: competition)
            cell.selectionStyle = .none

            return cell
        }
    }
}

