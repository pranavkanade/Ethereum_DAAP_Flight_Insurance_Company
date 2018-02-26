window.invokeInsurance = function(candidate, publicAddress, flightId) {
    let candidateName = $("#candidate").val();
    let flightId = $("#flightId").val();
    let userAddress = $("#publicAddress").val();

    try {
        $("#msg").html("Wait for confirmation")
        $("#candidate").val("");
        $("#flightId").val("");
        $("#publicAddress").val("");

        // #TODO : change this address of the smart contract 

        var insuranceContract = CoursetroContract.at('0xa010cc45f6c2ec57b06f65bc8ed5d869eec77394');

        if (typeof web3 !== 'undefined') {
        web3 = new Web3(web3.currentProvider);
        } else {
            // set the provider you want from Web3.providers
            web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
        }


        web3.eth.defaultAccount = web3.eth.accounts[0];

        // # TODO : out the ABI of the smart contract in side the contract function

        var insuranceContractABI = web3.eth.contract();
        console.log(insuranceContract);

        // # TODO : invoke your constructor here inplace of following function
        var insuranceEvent = insuranceContract.Constructor();

        insuranceEvent.watch(function(error, result){
        if (!error)
            {
                $("#flightId").hide();
                $("#publicAddress").hide();
                $("#candidate").hide();
                $("#msg").html("Error try after sometime");
            } else {
                $("#loader").hide();
                console.log(error);
            }
        });

        $("#button").click(function() {
            // # TODO invoke function on the contract object that has been created 
        $("#loader").show();
        });
    }
    finally{

    }
}