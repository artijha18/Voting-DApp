/ SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract VotingDApp {
    struct Candidate {
        string name;
        uint voteCount;
    }

    address public admin;
    bool public votingStarted;
    bool public votingEnded;
    mapping(address => bool) public hasVoted;
    Candidate[] public candidates;

    constructor(string[] memory candidateNames) {
        admin = msg.sender;
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate(candidateNames[i], 0));
        }
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this");
        _;
    }

    modifier duringVoting() {
        require(votingStarted && !votingEnded, "Voting is not active");
        _;
    }

    function startVoting() external onlyAdmin {
        require(!votingStarted, "Voting already started");
        votingStarted = true;
    }

    function endVoting() external onlyAdmin {
        require(votingStarted && !votingEnded, "Voting not active or already ended");
        votingEnded = true;
    }

    function vote(uint candidateIndex) external duringVoting {
        require(!hasVoted[msg.sender], "You have already voted");
        require(candidateIndex < candidates.length, "Invalid candidate");

        candidates[candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function getCandidates() external view returns (Candidate[] memory) {
        return candidates;
    }
}
