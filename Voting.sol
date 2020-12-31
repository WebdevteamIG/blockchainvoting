pragma solidity^0.7.0;

contract Voting {
    
    string[] candidates; //array of candidates
    address admin; //admin address
    mapping(uint256 => uint256) voteCount; // To keep track of votes for candidate (candidate id is used for noting which is index of candidates array)
    mapping(address => bool) voted; // use voted or not
    bool ended = false; // To check ended oor not
    
    modifier onlyAdmin{
        // Todo : Only adming modifier
        _;
    }
    
    modifier notEnded{
        //Todo : Verify ended or not
        _;
    }
    
    constructor (){
        // Todo : Assign admin address to contract creaters address
    }
    
    function addCandidate() onlyAdmin notEnded public {
        // Todo : Write code to add new Candidate
    }
    
    function vote() notEnded public {
        // Todo : first verify voter previously voted
        // increase count of candidateid in voteCount;
        
    }
    
    function end() onlyAdmin notEnded public{
        // Todo : End the election
    }
    
}