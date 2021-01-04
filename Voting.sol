pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

contract Voting {
    
    string[] candidates; //array of candidates
    address admin; //admin address
    mapping(uint256 => uint256) voteCount; // To keep track of votes for candidate (candidate id is used for noting which is index of candidates array)
    mapping(address => bool) voted; // use voted or not
    bool ended = false; // To check ended oor not
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
    
    constructor (string[] memory _candidates){
        candidate = _candidates;
        admin=msg.sender;
    }
    
    function vote(string memory _candidateName) notEnded public {
        // Todo : first verify voter previously voted
        // increase count of candidateid in voteCount;
        bool t=true;
        if(voted[msg.sender]==false){
            for(uint i=0;i<candidates.length;i++){
                if (keccak256(abi.encodePacked(_candidateName)) == keccak256(abi.encodePacked(candidates[i]))){
                    voteCount[i]++;
                    voted[msg.sender]=true;//marking him since he voted now
                    t=false;
                    break;//deafult values in a mapping for uint is 0 so need not worry about
                    //base case
                }
            }
        }
        else{
            revert("the person has already voted");
        }
        if(t==true){
            revert("the candidate does not exist in the list");
        }
    }
    
    function end() onlyAdmin notEnded public{
        // Todo : End the election
        ended=true;
    }

    function getResults() onlyAdmin public returns(string[] memory names, uint256[] memory votes) {
        // Todo : Return results as names array and votes count
        string[] memory _names;
        uint256[] memory _votes;
        for(uint i=0;i<candidates.length;i++){
            _names[i]=candidates[i];
            _votes[i]=voteCount[i];
        }
        return(_names,_votes);
    }
    
}
