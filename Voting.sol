pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

contract Voting {
    
    string[] candidates; //array of candidates
    address admin; //admin address
    mapping(uint256 => uint256) voteCount; // To keep track of votes for candidate (candidate id is used for noting which is index of candidates array)
    mapping(address => bool) voted; // use voted or not
    mapping(address => bool) elligbleVoters; // List of elligble voters
    bool ended = false; // To check ended oor not
    uint endtime;
    modifier onlyAdmin{
        // Todo : Only adming modifier
        require(msg.sender == admin);
        _;
    }
    
    modifier notEnded{
        //Todo : Verify ended or not
        require(ended == false && block.timestamp < endtime);
        _;
    }
    
    constructor (uint duarationHours, string[] memory _candidates){
        candidates = _candidates;
        admin=msg.sender;
        endtime =  block.timestamp + (duarationHours * 1 hours);
    }
    
    function register() notEnded public{
        elligbleVoters[msg.sender] = true;
    }
    
    function vote(string memory _candidateName) notEnded public {
        // Todo : first verify voter previously voted
        // increase count of candidateid in voteCount;
        require(elligbleVoters[msg.sender] == true,"You are not ellgible to vote.");
        bool t=true;
        require(voted[msg.sender] == false, "You have already voted.");
            for(uint i=0;i<candidates.length;i++){
                if (keccak256(abi.encodePacked(_candidateName)) == keccak256(abi.encodePacked(candidates[i]))){
                    voteCount[i]++;
                    voted[msg.sender]=true;//marking him since he voted now
                    t=false;
                    break;//deafult values in a mapping for uint is 0 so need not worry about
                    //base case
                }
            }
        require(t== false,"The candidate doesn't exist in the list.");        
       require(elligbleVoters[msg.sender] == true, "You are not ellgible to vote.");
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
        string[] memory _names = new string[](candidates.length);
        uint256[] memory _votes = new uint256[](candidates.length);
        for(uint i=0;i<candidates.length;i++){
            _names[i]=candidates[i];
            _votes[i]=voteCount[i];
        }
        return(_names,_votes);
    }
    
}
