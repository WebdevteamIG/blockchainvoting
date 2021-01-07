const web3 = require("web3");
require("dotenv").config();

const path = require('path');
const fs = require('fs');
const solc = require('solc');



// You can convert functions to async await based on requirements but do not change the structure


let publickey = process.env.publickey;
let privatekey = process.env.privatekey;
let infuraid = process.env.infuraid;
let initializedWeb3 = null;
let cdata = null;

function connectWeb3(){
    // Todo : Connect web3 to rinkeby network and assign intitialised web3 to the variable
    try{
        // initializedWeb3=new web3('https://rinkeby.infura.io/v3/'+infuraid);
        initializedWeb3=new web3();
        initializedWeb3.setProvider(new web3.providers.WebsocketProvider('ws://localhost:8545')); 
        console.log('connected');
    }
    catch(err){
        console.error(err);
    }
}

async function deployContract(){
    //Todo : Deploy the contract
    
    const helloPath = path.resolve(__dirname, 'Voting.sol');
    const source = fs.readFileSync(helloPath, 'UTF-8');

    var input = {
        language: 'Solidity',
        sources: {
            'Voting.sol' : {
                content: source
            }
        },
        settings: {
            outputSelection: {
                '*': {
                    '*': [ '*' ]
                }
            }
        }
    }; 
    var compiledcode = JSON.parse(solc.compile(JSON.stringify(input))).contracts["Voting.sol"].Voting;
    var abi = compiledcode.abi;
    // console.log(abi);
    var data = compiledcode.evm.bytecode.object;
    // console.log(data);
    var candidates = ["cand1", "cand2", "cand3"];
    var duration = 10000;
    var contract = new initializedWeb3.eth.Contract(abi);

    cdata = contract.deploy({
        data: "0x" + data,
        arguments: [duration,candidates],
    });

    var options = {
        from: publickey,
        data: cdata._deployData,
    };
    console.log(publickey);
    var nonce = await initializedWeb3.eth.getTransactionCount(publickey);
    options.nonce = nonce;
    let gasPrice = initializedWeb3.eth.gasPrice;
    let gasPriceHex = gasPrice;
    let gasLimitHex = 6000000;
    options.gasPrice = gasPriceHex;
    options.gasLimit = gasLimitHex;
    var signedTx = await initializedWeb3.eth.accounts.signTransaction(
        options,
        privatekey
    );
    const sentTx = await initializedWeb3.eth.sendSignedTransaction(
        signedTx.raw || signedTx.rawTransaction
    );
      
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
connectWeb3();

deployContract();