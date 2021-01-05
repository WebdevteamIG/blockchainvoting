const web3 = require("web3");
require("dotenv");
const solc = require('solc');
const fs = require('fs');

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
    let source = fs.readFileSync('Voting.sol', 'utf8');
    let compiledContract = solc.compile(source, 1);
    let abi = compiledContract.contracts['Voting'].interface;
    console.log('Abi: ', abi);
    let bytecode = compiledContract.contracts['Voting'].bytecode;
    let gasEstimate = initializedWeb3.eth.estimateGas({data: bytecode});
    let contract = initializedWeb3.eth.contract(JSON.parse(abi));
    contract.new({from:publickey, data:bytecode, value:30000000000000000000, gas:gasEstimate}, function(err, myContract){
    if(!err) {
        if(!myContract.address) {
            console.log("Hash: ", myContract.transactionHash);
        } else {
            deployedContractAddress=myContract.address;
            console.log("Address: ", myContract.address);
        }
    }
    else {
        console.log(err);
    }
    });
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
