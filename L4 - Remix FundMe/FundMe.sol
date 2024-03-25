//SPDX-License-Identifier: MIT

pragma solidity 0.8.24; // solidity version

import {PriceConverter} from "./Libraries/PriceConverter.sol";

error NotOwner();

contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant minimumUsd = 5 * 1e18; //5e18

    address[] public funders;
    mapping(address funcer => uint256 amountFunded) public addressToAmountFunded;

    //immutable variables are more gas efficient 
    //can be only set once in constractor
    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    //sepoli eth/usd 0x694AA1769357215DE4FAC081bf1f309aDC325306 from chainlink
    
    function fund() public payable{
        // Allow users to send $
        // Have a minimum $ sent
        // 1. How do we send ETD to this contract?
        // require(msg.value >= 1e18, "Didn't send enough ETH"); //1e18 = 1 ETH = 10000000000000000000 = 1 * 10 ** 18
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough ETH");
        // msg.value.getConversionRate();//even though we dont pass any value inside the function it automatically passes msg.value in getConversionRate()
        // What is revert?
        // Undo any actions that have been done and send the remaining gas back

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }


    function withdraw() public onlyOwner {
        
        //for loop
        for (uint256 funderIndex = 0 ; funderIndex < funders.length; funderIndex++) 
        {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array
        funders = new address[](0);

        // to withdraw the funds there are 3 ways:
        //transfer
        //send
        //call

        //Transfer
        // payable (msg.sender).transfer(address(this).balance);

        //Send
        // bool sendSuccess = payable (msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        //Call
        (bool callSuccess, /*bytes memory dataReturned*/) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
        

    }

    modifier onlyOwner() {
        // only owner of the contract can call this function
        // require(msg.sender == owner, "Only owner can use withdraw function");
        if(msg.sender != i_owner){revert NotOwner();}
        _; // this means that continue the execution of the function whatever the code is
    }

    //What happens if someone sends this contract ETH without calling fund function
    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}