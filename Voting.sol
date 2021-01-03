pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

contract Voting {
    
    string[] candidates; //array of candidates
    address admin; //admin address
    mapping(uint256 => uint256) voteCount; // To keep track of votes for candidate (candidate id is used for noting which is index of candidates array)
    mapping(address => bool) voted; // use voted or not
    bool ended = false; // To check ended oor not
    bool t=true;
    modifier onlyAdmin{
        // Todo : Only adming modifier
        require(msg.sender == admin);
        _;
    }
    
    modifier notEnded{
        //Todo : Verify ended or not
        require(ended == false);
        _;
    }
    
    constructor (){
        // Todo : Assign admin address to contract creaters address
        admin=msg.sender;
    }
    
    function addCandidate(string memory _candidateName) onlyAdmin notEnded public {
        // Todo : Write code to add new Candidate
    }
    
    function vote(string memory _candidateName) notEnded public {
        // Todo : first verify voter previously voted
        // increase count of candidateid in voteCount;
        t=true;
        for(uint i=0;i< candidates.length;i++)
        {
            if (keccak256(abi.encodePacked(_candidateName)) == keccak256(abi.encodePacked(candidates[i]))) 
            {
                t=false;break;
            }
        }
        if(t==true)
            {candidates.push(_candidateName);}
    }
    
    function end() onlyAdmin notEnded public{
        // Todo : End the election
        ended=true;
    }

    function getResults() onlyAdmin public returns(string[] memory names, uint256[] memory votes) {
        // Todo : Return results as names array and votes count
    }
    
}