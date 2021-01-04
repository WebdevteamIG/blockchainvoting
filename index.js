const web3 = require("web3");
require("dotenv");

// You can convert functions to async await based on requirements but do not change the structure

let deployedContractAddress = null;
let publickey = process.env.publickey;
let privatekey = process.env.privatekey;
let infuraid = process.env.infuraid;
let initializedWeb3 = null;

function connectWeb3(){
    // Todo : Connect web3 to rinkeby network and assign intitialised web3 to the variable
    try{
        initializedWeb3=new web3('https://rinkeby.infura.io/v3/'+infuraid);
        console.log('connected');
    }
    catch(err){
        console.error(err);
    }
}

function deployContract(){
    //Todo : Deploy the contract
}

function callAddCandidate(candidateName){
    // Todo : calling the addCandidate function in contract
}

function callVote(candidateName){
    //Todo : calling the vote function in contract with senders address
}

function callEnd(){
    //Todo : call end function in contract
}
