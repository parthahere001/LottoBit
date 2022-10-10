// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
contract Lottery{
    address payable[] public players;
    uint256 public usdEntryFee;
    AggregatorV3Interface internal ethUsdPriceFeed;


    constructor (address _priceFeeAddress) public {
        usdEntryFee = 50 * (10**18);
        ethUsdPriceFeed = AggregatorV3Interface(_priceFeeAddress);
    }



    function enter() public payable {
        // 50 Dollars minimum
        //require();
        players.push(payable(msg.sender));
    }

    function getEnteranceFee() public view returns (uint256){}

    function startLottery() public {}

    function endLottery() public {}

}